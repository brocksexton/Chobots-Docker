package com.kavalok.db;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.ManyToOne;
import javax.validation.constraints.NotNull;

@Entity
public class UserReport extends ModelBase implements Serializable {

  private static final long serialVersionUID = 1L;

  private User reporter;

  private User user;

  private String text;

  private Boolean processed = false;

  @ManyToOne(fetch = FetchType.LAZY)
  @NotNull
  public User getUser() {
    return user;
  }

  public void setUser(User user) {
    this.user = user;
  }

  @Column(columnDefinition = "text not null")
  public String getText() {
    return text;
  }

  public void setText(String text) {
    this.text = text;
  }

  @ManyToOne(fetch = FetchType.LAZY)
  @NotNull
  public User getReporter() {
    return reporter;
  }

  public void setReporter(User reporter) {
    this.reporter = reporter;
  }

  @Column(columnDefinition = "boolean default false")
  public Boolean getProcessed() {
    return processed;
  }

  public void setProcessed(Boolean processed) {
    this.processed = processed;
  }
}
