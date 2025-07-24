package com.kavalok.db;

import javax.persistence.Entity;
import javax.persistence.ManyToOne;
import javax.persistence.Transient;

import com.kavalok.permissions.AccessPartner;

@Entity
public class Partner extends LoginModelBase {

  StuffType stuff;

  String portalUrl;

  @SuppressWarnings("unchecked")
  @Override
  @Transient
  public Class getAccessType() {
    return AccessPartner.class;
  }

  @ManyToOne
  public StuffType getStuff() {
    return stuff;
  }

  public void setStuff(StuffType stuff) {
    this.stuff = stuff;
  }

  public String getPortalUrl() {
    return portalUrl;
  }

  public void setPortalUrl(String portalUrl) {
    this.portalUrl = portalUrl;
  }
}
