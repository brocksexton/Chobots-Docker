package com.kavalok.dto.stuff;

public class StuffTOBase {
  private String fileName;
  private String type;
  private String name;
  private Long id;
  private int price;
  private Boolean hasColor;

  public Boolean getHasColor() {
    return hasColor;
  }

  public void setHasColor(Boolean hasColor) {
    this.hasColor = hasColor;
  }

  public Long getId() {
    return id;
  }

  public void setId(Long id) {
    this.id = id;
  }

  public String getFileName() {
    return fileName;
  }

  public void setFileName(String fileName) {
    this.fileName = fileName;
  }

  public String getType() {
    return type;
  }

  public void setType(String type) {
    this.type = type;
  }

  public int getPrice() {
    return price;
  }

  public void setPrice(int price) {
    this.price = price;
  }

  public String getName() {
    return name;
  }

  public void setName(String name) {
    this.name = name;
  }
}
