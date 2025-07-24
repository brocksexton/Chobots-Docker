package com.kavalok.dto;

public class WorldConfigTO {
  private Boolean safeModeEnabled;

  public WorldConfigTO(Boolean safeModeEnabled) {
    this.safeModeEnabled = safeModeEnabled;
  }

  public WorldConfigTO() {
    super();
  }

  public Boolean getSafeModeEnabled() {
    return safeModeEnabled;
  }

  public void setSafeModeEnabled(Boolean safeModeEnabled) {
    this.safeModeEnabled = safeModeEnabled;
  }
}
