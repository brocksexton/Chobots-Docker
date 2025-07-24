package com.kavalok.db;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Entity;

import org.hibernate.annotations.Type;

@Entity
public class ClientError extends ModelBase implements Serializable {

  private static final long serialVersionUID = 1L;

  private String messsage;

  private Integer count;

  private Date updated;

  public ClientError() {
    super();
  }

  public ClientError(String messsage) {
    super();
    this.messsage = messsage;
    count = 0;
    updated = new Date();
  }

  @Type(type = "text")
  public String getMessage() {
    return messsage;
  }

  public void setMessage(String message) {
    this.messsage = message;
  }

  public Integer getCount() {
    return count;
  }

  public void setCount(Integer count) {
    this.count = count;
  }

  public Date getUpdated() {
    return updated;
  }

  public void setUpdated(Date updated) {
    this.updated = updated;
  }
}
