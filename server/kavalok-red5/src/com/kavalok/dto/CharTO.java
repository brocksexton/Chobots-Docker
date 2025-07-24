package com.kavalok.dto;

import java.util.List;

import com.kavalok.dto.friend.FriendTO;
import com.kavalok.dto.stuff.StuffItemLightTO;

public class CharTO extends FriendTO {
  private String id;

  private String body;
  private Integer color;
  private boolean chatEnabled;
  private boolean chatEnabledByParent;
  private Integer chatBanLeftTime;
  private boolean enabled;
  private boolean isParent;
  private boolean isCitizen;
  private boolean isGuest;
  private boolean isAgent;
  private boolean isModerator;
  private boolean isOnline;
  private String locale;
  private Integer age;
  private Boolean hasRobot;
  private String teamName;
  private int teamColor = 0;
  private boolean acceptRequests;
  private List<StuffItemLightTO> clothes;
  private StuffItemLightTO playerCard;

  public String getId() {
    return id;
  }

  public void setId(String id) {
    this.id = id;
  }

  public String getBody() {
    return body;
  }

  public void setBody(String body) {
    this.body = body;
  }

  public boolean isChatEnabled() {
    return chatEnabled;
  }

  public void setChatEnabled(boolean chatEnabled) {
    this.chatEnabled = chatEnabled;
  }

  public Integer getChatBanLeftTime() {
    return chatBanLeftTime;
  }

  public void setChatBanLeftTime(Integer chatBanLeftTime) {
    this.chatBanLeftTime = chatBanLeftTime;
  }

  public boolean isEnabled() {
    return enabled;
  }

  public void setEnabled(boolean enabled) {
    this.enabled = enabled;
  }

  public boolean isParent() {
    return isParent;
  }

  public void setParent(boolean isParent) {
    this.isParent = isParent;
  }

  public boolean isCitizen() {
    return isCitizen;
  }

  public void setCitizen(boolean isCitizen) {
    this.isCitizen = isCitizen;
  }

  public boolean isGuest() {
    return isGuest;
  }

  public void setGuest(boolean isGuest) {
    this.isGuest = isGuest;
  }

  public boolean isAgent() {
    return isAgent;
  }

  public void setAgent(boolean isAgent) {
    this.isAgent = isAgent;
  }

  public boolean isModerator() {
    return isModerator;
  }

  public void setModerator(boolean isModerator) {
    this.isModerator = isModerator;
  }

  public boolean isOnline() {
    return isOnline;
  }

  public void setOnline(boolean isOnline) {
    this.isOnline = isOnline;
  }

  public String getLocale() {
    return locale;
  }

  public void setLocale(String locale) {
    this.locale = locale;
  }

  public Integer getAge() {
    return age;
  }

  public void setAge(Integer age) {
    this.age = age;
  }

  public boolean isAcceptRequests() {
    return acceptRequests;
  }

  public void setAcceptRequests(boolean acceptRequests) {
    this.acceptRequests = acceptRequests;
  }

  public List<StuffItemLightTO> getClothes() {
    return clothes;
  }

  public void setClothes(List<StuffItemLightTO> clothes) {
    this.clothes = clothes;
  }

  public boolean isChatEnabledByParent() {
    return chatEnabledByParent;
  }

  public void setChatEnabledByParent(boolean chatEnabledByParent) {
    this.chatEnabledByParent = chatEnabledByParent;
  }

  public Integer getColor() {
    return color;
  }

  public void setColor(Integer color) {
    this.color = color;
  }

  public StuffItemLightTO getPlayerCard() {
    return playerCard;
  }

  public void setPlayerCard(StuffItemLightTO playerCard) {
    this.playerCard = playerCard;
  }

  public Boolean getHasRobot() {
    return hasRobot;
  }

  public void setHasRobot(Boolean hasRobot) {
    this.hasRobot = hasRobot;
  }

  public String getTeamName() {
    return teamName;
  }

  public void setTeamName(String teamName) {
    this.teamName = teamName;
  }

  public int getTeamColor() {
    return teamColor;
  }

  public void setTeamColor(int teamColor) {
    this.teamColor = teamColor;
  }
}
