package com.kavalok.db;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.validation.constraints.NotNull;

@Entity
public class AllowedWord extends ModelBase {

  private String word;

  public AllowedWord(String word) {
    super();
    this.word = word;
  }

  public AllowedWord() {
    super();
  }

  @NotNull
  @Column(unique = true)
  public String getWord() {
    return word;
  }

  public void setWord(String word) {
    this.word = word;
  }
}
