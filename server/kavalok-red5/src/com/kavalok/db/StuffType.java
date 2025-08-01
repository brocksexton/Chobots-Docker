package com.kavalok.db;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.ManyToOne;
import javax.validation.constraints.NotNull;

@Entity
public class StuffType extends ModelBase {

  private String fileName;

  private Boolean hasColor;

  private Boolean premium;

  private Boolean giftable;

  private Boolean rainable;

  private int price;

  private Shop shop;

  private String type;

  private String placement;

  private String info;

  private String itemOfTheMonth;

  private String name;

  private int groupNum = 0;

  @NotNull
  @Column(columnDefinition = "varchar(10)")
  public String getPlacement() {
    return placement;
  }

  public void setPlacement(String placement) {
    this.placement = placement;
  }

  @NotNull
  @Column(columnDefinition = "varchar(1)")
  public String getType() {
    return type;
  }

  public void setType(String type) {
    this.type = type;
  }

  @NotNull
  public String getFileName() {
    return fileName;
  }

  public void setFileName(String className) {
    this.fileName = className;
  }

  @NotNull
  public int getPrice() {
    return price;
  }

  public void setPrice(int price) {
    this.price = price;
  }

  @ManyToOne(fetch = FetchType.LAZY)
  public Shop getShop() {
    return shop;
  }

  public void setShop(Shop shop) {
    this.shop = shop;
  }

  public String getInfo() {
    return info;
  }

  public void setInfo(String info) {
    this.info = info;
  }

  @NotNull
  @Column(columnDefinition = "bit(1) default true")
  public Boolean getHasColor() {
    return hasColor;
  }

  public void setHasColor(Boolean hasColor) {
    this.hasColor = hasColor;
  }

  @NotNull
  @Column(columnDefinition = "bit(1) default false")
  public Boolean getPremium() {
    return premium;
  }

  public void setPremium(Boolean premium) {
    this.premium = premium;
  }

  @NotNull
  @Column(columnDefinition = "bit(1) default false")
  public Boolean getRainable() {
    return rainable;
  }

  public void setRainable(Boolean rainable) {
    this.rainable = rainable;
  }

  @NotNull
  @Column(columnDefinition = "bit(1) default false")
  public Boolean getGiftable() {
    return giftable;
  }

  public void setGiftable(Boolean giftable) {
    this.giftable = giftable;
  }

  @Column(columnDefinition = "varchar(8)")
  public String getItemOfTheMonth() {
    return itemOfTheMonth;
  }

  public void setItemOfTheMonth(String itemOfTheMonth) {
    this.itemOfTheMonth = itemOfTheMonth;
  }

  public String getName() {
    return name;
  }

  public void setName(String name) {
    this.name = name;
  }

  @Column(nullable = false, columnDefinition = "int(2) default 0")
  public int getGroupNum() {
    return groupNum;
  }

  public void setGroupNum(int groupNum) {
    this.groupNum = groupNum;
  }
}
