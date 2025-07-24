package com.kavalok.dto;

public class ServerConfigTO {
  private Boolean guestsEnabled;

  private Boolean registrationEnabled;

  private Integer spamMessagesLimit;

  private Integer serverLimit;

  public ServerConfigTO() {
    super();
  }

  public ServerConfigTO(
      Boolean guestsEnabled,
      Boolean registrationEnabled,
      Integer spamMessagesLimit,
      Integer serverLimit) {
    super();
    this.guestsEnabled = guestsEnabled;
    this.registrationEnabled = registrationEnabled;
    this.spamMessagesLimit = spamMessagesLimit;
    this.serverLimit = serverLimit;
  }

  public Boolean getGuestsEnabled() {
    return guestsEnabled;
  }

  public void setGuestsEnabled(Boolean guestsEnabled) {
    this.guestsEnabled = guestsEnabled;
  }

  public Boolean getRegistrationEnabled() {
    return registrationEnabled;
  }

  public void setRegistrationEnabled(Boolean registrationEnabled) {
    this.registrationEnabled = registrationEnabled;
  }

  public Integer getSpamMessagesLimit() {
    return spamMessagesLimit;
  }

  public void setSpamMessagesLimit(Integer spamMessagesLimit) {
    this.spamMessagesLimit = spamMessagesLimit;
  }

  public Integer getServerLimit() {
    return serverLimit;
  }

  public void setServerLimit(Integer serverLimit) {
    this.serverLimit = serverLimit;
  }
}
