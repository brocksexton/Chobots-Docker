package org.red5.server.net.rtmp;

/*
 * RED5 Open Source Flash Server - http://www.osflash.org/red5
 *
 * Copyright (c) 2006-2007 by respective authors (see below). All rights reserved.
 *
 * This library is free software; you can redistribute it and/or modify it under the
 * terms of the GNU Lesser General Public License as published by the Free Software
 * Foundation; either version 2.1 of the License, or (at your option) any later
 * version.
 *
 * This library is distributed in the hope that it will be useful, but WITHOUT ANY
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
 * PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License along
 * with this library; if not, write to the Free Software Foundation, Inc.,
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
 */

import java.net.InetSocketAddress;
import java.net.SocketAddress;
import java.util.concurrent.ArrayBlockingQueue;
import java.util.concurrent.BlockingQueue;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.LinkedBlockingQueue;
import java.util.concurrent.SynchronousQueue;
import java.util.concurrent.ThreadPoolExecutor;
import java.util.concurrent.TimeUnit;

import org.apache.mina.common.ByteBuffer;
import org.apache.mina.common.IoHandlerAdapter;
import org.apache.mina.common.SimpleByteBufferAllocator;
import org.apache.mina.common.ThreadModel;
import org.apache.mina.filter.LoggingFilter;
import org.apache.mina.filter.executor.ExecutorFilter;
import org.apache.mina.transport.socket.nio.SocketAcceptor;
import org.apache.mina.transport.socket.nio.SocketAcceptorConfig;
import org.apache.mina.transport.socket.nio.SocketSessionConfig;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Transport setup class configures socket acceptor and thread pools for RTMP in Mina. Note: This
 * code originates from AsyncWeb, I've modified it for use with Red5. - Luke
 */
public class RTMPMinaTransport {

  private static final int DEFAULT_EVENT_THREADS_CORE = 16;

  private static final int DEFAULT_EVENT_THREADS_KEEPALIVE = 60;

  private static final int DEFAULT_EVENT_THREADS_MAX = 32;

  private static final int DEFAULT_EVENT_THREADS_QUEUE = -1;

  private static final int DEFAULT_IO_THREADS = Runtime.getRuntime().availableProcessors() + 1;

  private static final int DEFAULT_PORT = 1935;

  private static final int DEFAULT_RECEIVE_BUFFER_SIZE = 256 * 1024;

  private static final int DEFAULT_SEND_BUFFER_SIZE = 64 * 1024;

  private static final boolean DEFAULT_TCP_NO_DELAY = false;

  private static final boolean DEFAULT_USE_HEAP_BUFFERS = true;

  private static final Logger log = LoggerFactory.getLogger(RTMPMinaTransport.class);

  private SocketAcceptor acceptor;

  private String address = null;

  private ExecutorService eventExecutor;

  private int eventThreadsCore = DEFAULT_EVENT_THREADS_CORE;

  private int eventThreadsKeepalive = DEFAULT_EVENT_THREADS_KEEPALIVE;

  private int eventThreadsMax = DEFAULT_EVENT_THREADS_MAX;

  private int eventThreadsQueue = DEFAULT_EVENT_THREADS_QUEUE;

  private IoHandlerAdapter ioHandler;

  private int ioThreads = DEFAULT_IO_THREADS;

  private boolean isLoggingTraffic = false;

  private int port = DEFAULT_PORT;

  private int receiveBufferSize = DEFAULT_RECEIVE_BUFFER_SIZE;

  private int sendBufferSize = DEFAULT_SEND_BUFFER_SIZE;

  private boolean tcpNoDelay = DEFAULT_TCP_NO_DELAY;

  private boolean useHeapBuffers = DEFAULT_USE_HEAP_BUFFERS;

  private void initIOHandler() {
    if (ioHandler == null) {
      log.info("No RTMP IO Handler associated - using defaults");
      ioHandler = new RTMPMinaIoHandler();
    }
  }

  public void setAddress(String address) {
    if ("*".equals(address) || "0.0.0.0".equals(address)) {
      address = null;
    }
    this.address = address;
  }

  public void setEventThreadsCore(int eventThreadsCore) {
    this.eventThreadsCore = eventThreadsCore;
  }

  public void setEventThreadsKeepalive(int eventThreadsKeepalive) {
    this.eventThreadsKeepalive = eventThreadsKeepalive;
  }

  public void setEventThreadsMax(int eventThreadsMax) {
    this.eventThreadsMax = eventThreadsMax;
  }

  public void setEventThreadsQueue(int eventThreadsQueue) {
    this.eventThreadsQueue = eventThreadsQueue;
  }

  public void setIoHandler(IoHandlerAdapter rtmpIOHandler) {
    this.ioHandler = rtmpIOHandler;
  }

  public void setIoThreads(int ioThreads) {
    this.ioThreads = ioThreads;
  }

  public void setIsLoggingTraffic(boolean isLoggingTraffic) {
    this.isLoggingTraffic = isLoggingTraffic;
  }

  public void setPort(int port) {
    this.port = port;
  }

  public void setReceiveBufferSize(int receiveBufferSize) {
    this.receiveBufferSize = receiveBufferSize;
  }

  public void setSendBufferSize(int sendBufferSize) {
    this.sendBufferSize = sendBufferSize;
  }

  public void setTcpNoDelay(boolean tcpNoDelay) {
    this.tcpNoDelay = tcpNoDelay;
  }

  public void setUseHeapBuffers(boolean useHeapBuffers) {
    this.useHeapBuffers = useHeapBuffers;
  }

  public void start() throws Exception {
    initIOHandler();

    ByteBuffer.setUseDirectBuffers(!useHeapBuffers); // this is global, oh well.
    if (useHeapBuffers) {
      ByteBuffer.setAllocator(new SimpleByteBufferAllocator()); // dont pool for heap buffers.
    }
    log.info("RTMP Mina Transport Settings");
    log.info("IO Threads: {}", ioThreads);
    log.info(
        "Event Threads - core: {}, max: {}, queue: {}, keepalive: {}",
        new Object[] {eventThreadsCore, eventThreadsMax, eventThreadsQueue, eventThreadsKeepalive});

    eventExecutor =
        new ThreadPoolExecutor(
            eventThreadsCore,
            eventThreadsMax,
            eventThreadsKeepalive,
            TimeUnit.SECONDS,
            threadQueue(eventThreadsQueue));
    // Avoid the reject by setting CallerRunsPolicy
    // This prevents memory leak in Mina ExecutorFilter
    ((ThreadPoolExecutor) eventExecutor)
        .setRejectedExecutionHandler(new ThreadPoolExecutor.CallerRunsPolicy());

    // Executors.newCachedThreadPool() is always preferred by IoService
    // See http://mina.apache.org/configuring-thread-model.html for details
    acceptor = new SocketAcceptor(ioThreads, Executors.newCachedThreadPool());

    acceptor.getFilterChain().addLast("threadPool", new ExecutorFilter(eventExecutor));

    SocketAcceptorConfig config = acceptor.getDefaultConfig();
    config.setThreadModel(ThreadModel.MANUAL);
    config.setReuseAddress(true);
    config.setBacklog(100);

    log.info("TCP No Delay: {}", tcpNoDelay);
    log.info("Receive Buffer Size: {}", receiveBufferSize);
    log.info("Send Buffer Size: {}", sendBufferSize);

    SocketSessionConfig sessionConf = (SocketSessionConfig) config.getSessionConfig();
    sessionConf.setReuseAddress(true);
    sessionConf.setTcpNoDelay(tcpNoDelay);
    sessionConf.setReceiveBufferSize(receiveBufferSize);
    sessionConf.setSendBufferSize(sendBufferSize);

    if (isLoggingTraffic) {
      log.info("Configuring traffic logging filter");
      acceptor.getFilterChain().addFirst("LoggingFilter", new LoggingFilter());
    }

    SocketAddress socketAddress =
        (address == null) ? new InetSocketAddress(port) : new InetSocketAddress(address, port);
    acceptor.bind(socketAddress, ioHandler);

    log.info("RTMP Mina Transport bound to {}", socketAddress.toString());
  }

  public void stop() {
    log.info("RTMP Mina Transport unbind");
    acceptor.unbindAll();
    eventExecutor.shutdown();
  }

  private BlockingQueue<Runnable> threadQueue(int size) {
    switch (size) {
      case -1:
        return new LinkedBlockingQueue<Runnable>();
      case 0:
        return new SynchronousQueue<Runnable>();
      default:
        return new ArrayBlockingQueue<Runnable>(size);
    }
  }

  public String toString() {
    return "RTMP Mina Transport [port=" + port + "]";
  }
}
