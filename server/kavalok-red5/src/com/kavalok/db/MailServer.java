package com.kavalok.db;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Entity;

@Entity
public class MailServer extends ModelBase implements Serializable {

  private static final long serialVersionUID = 1L;

  private String url;

  private Boolean available;

  private String login;

  private String pass;

  private Integer port;

  private Integer sentLastDay;

  private Date lastUsageDate;

  public String getLogin() {
    return login;
  }

  public void setLogin(String login) {
    this.login = login;
  }

  public String getPass() {
    return pass;
  }

  public void setPass(String pass) {
    this.pass = pass;
  }

  public Integer getPort() {
    return port;
  }

  public void setPort(Integer port) {
    this.port = port;
  }

  public String getUrl() {
    return url;
  }

  public void setUrl(String url) {
    this.url = url;
  }

  public Boolean getAvailable() {
    return available;
  }

  public void setAvailable(Boolean available) {
    this.available = available;
  }

  public Date getLastUsageDate() {
    return lastUsageDate;
  }

  public void setLastUsageDate(Date lastUsageDate) {
    this.lastUsageDate = lastUsageDate;
  }

  public Integer getSentLastDay() {
    return sentLastDay == null ? 0 : sentLastDay;
  }

  public void setSentLastDay(Integer sentLastDay) {
    this.sentLastDay = sentLastDay;
  }
}
