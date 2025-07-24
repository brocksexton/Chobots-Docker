package com.kavalok.db;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.JoinColumns;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;

@Entity
public class GuestMarketingInfo extends ModelBase {

  private User user;
  private MarketingInfo marketingInfo;

  @ManyToOne(fetch = FetchType.LAZY)
  @JoinColumns({@JoinColumn(name = "userId", referencedColumnName = "id")})
  public User getUser() {
    return user;
  }

  public void setUser(User user) {
    this.user = user;
  }

  @OneToOne(fetch = FetchType.LAZY)
  @JoinColumns({@JoinColumn(name = "marketingInfoId", referencedColumnName = "id")})
  public MarketingInfo getMarketingInfo() {
    return marketingInfo;
  }

  public void setMarketingInfo(MarketingInfo marketingInfo) {
    this.marketingInfo = marketingInfo;
  }
}
