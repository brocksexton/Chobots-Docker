package org.red5.server.net;

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

import java.util.Iterator;

import org.red5.server.api.IConnection;
import org.red5.server.api.event.IEvent;

/** Queue of connection events */
public interface IConnectionEventQueue {
  /**
   * Whether queue has waiting connection events
   *
   * @param conn Connection
   * @return <code>true</code> if queue has waiting events for connection, <code>false</code>
   *     otherwise
   */
  public boolean hasEventsWaiting(IConnection conn);

  /**
   * Return iterator over waiting events
   *
   * @param conn Connection
   * @return Iterator over events
   */
  public Iterator<IEvent> pickupEvents(IConnection conn);
}
