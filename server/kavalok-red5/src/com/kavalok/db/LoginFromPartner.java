package com.kavalok.db;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.OneToOne;

@Entity
public class LoginFromPartner extends ModelBase implements Serializable {

  private static final long serialVersionUID = 1L;

  private User user;
  private String uid;

  @OneToOne
  public User getUser() {
    return user;
  }

  public void setUser(User user) {
    this.user = user;
  }

  public String getUid() {
    return uid;
  }

  public void setUid(String uid) {
    this.uid = uid;
  }
}
