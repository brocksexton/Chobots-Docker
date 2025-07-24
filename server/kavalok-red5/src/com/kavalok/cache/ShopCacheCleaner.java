package com.kavalok.cache;

import java.util.TimerTask;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class ShopCacheCleaner extends TimerTask {

  public static final int DELAY = 60 * 60 * 1000;

  public static Logger logger = LoggerFactory.getLogger(ShopCacheCleaner.class);

  @Override
  public void run() {
    logger.debug("ShopCacheCleaner start");
    StuffTypeCache.getInstance().clear();
    logger.debug("ShopCacheCleaner end");
  }
}
