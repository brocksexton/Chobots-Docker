package com.kavalok.dto;

public class ClientServerConfigTO {
  private Boolean guestsEnabled;
  private Boolean registrationEnabled;

  public ClientServerConfigTO() {}

  public ClientServerConfigTO(Boolean guestsEnabled, Boolean registrationEnabled) {
    this.guestsEnabled = guestsEnabled;
    this.registrationEnabled = registrationEnabled;
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
}
