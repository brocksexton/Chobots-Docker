package com.kavalok.dao;

import org.hibernate.Session;

import com.kavalok.dao.common.DAO;
import com.kavalok.db.Config;

public class ConfigDAO extends DAO<Config> {

  public ConfigDAO(Session session) {
    super(session);
  }

  public void setSpamMessagesCount(Integer value) {
    setValue("spamMessagesCount", value);
  }

  public Integer getSpamMessagesCount() {
    Integer result = (Integer) getValue("spamMessagesCount");
    if (result == null) result = 20;
    return result;
  }

  public void setStuffGroupNum(Integer value) {
    setValue("stuffGroupNum", value);
  }

  public Integer getStuffGroupNum() {
    Integer result = (Integer) getValue("stuffGroupNum");
    if (result == null) result = 0;
    return result;
  }

  public void setSafeModeEnabled(Boolean value) {
    setValue("safeModeEnabled", value);
  }

  public Boolean getSafeModeEnabled() {
    Boolean result = (Boolean) getValue("safeModeEnabled");
    if (result == null) result = false;
    return result;
  }

  public void setRegistrationEnabled(Boolean value) {
    setValue("registrationEnabled", value);
  }

  public Boolean getRegistrationEnabled() {
    Boolean result = (Boolean) getValue("registrationEnabled");
    if (result == null) result = false;
    return result;
  }

  public void setGuestEnabled(Boolean value) {
    setValue("guestEnabled", value);
  }

  public Boolean getGuestEnabled() {
    Boolean result = (Boolean) getValue("guestEnabled");
    if (result == null) result = false;
    return result;
  }

  public void setServerLimit(Integer value) {
    setValue("serverLimit", value);
  }

  public Integer getServerLimit() {
    Integer result = (Integer) getValue("serverLimit");
    if (result == null) result = 200;
    return result;
  }

  public void setValue(String name, Object value) {
    Config config = findByParameter("name", name);
    if (config == null) config = new Config(name);
    config.setObjectValue(value);
    makePersistent(config);
  }

  public Object getValue(String name) {
    Config config = findByParameter("name", name);

    return config == null ? null : config.getObjectValue();
  }

  public Config findByName(String name) {
    return findByParameter("name", name);
  }
}
