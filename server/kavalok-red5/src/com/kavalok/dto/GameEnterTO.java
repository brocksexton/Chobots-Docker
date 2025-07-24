package com.kavalok.dto;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.red5.io.utils.ObjectMap;

import com.kavalok.dto.friend.FriendTO;
import com.kavalok.dto.pet.PetTO;
import com.kavalok.dto.robot.RobotTO;
import com.kavalok.dto.stuff.StuffItemLightTO;

public class GameEnterTO extends KeysTO {

  private Long userId;
  private Long age;
  private String remoteId;
  private Boolean chatEnabled = true;
  private Boolean membershipChatDisabled = false;
  private Boolean serverInSafeMode = false;
  private Boolean nonCitizenChatDisabled = false;
  private Boolean chatEnabledByParent = true;
  private Long chatBanLeftTime = null;
  private Boolean helpEnabled = true;
  private Boolean isGuest = false;
  private String email;
  private Boolean isAgent = false;
  private Boolean isCitizen = false;
  private Date citizenExpirationDate = null;
  private Integer citizenTryCount = null;
  private Boolean isModerator = false;
  private Boolean isParent = true;
  private Boolean firstLogin = false;
  private String body = "default";
  private Integer color = 0x9191C8;
  private Double money = 0d;
  private List<String> dances;
  private List<StuffItemLightTO> stuffs = new ArrayList<StuffItemLightTO>();
  private List<String> friends = new ArrayList<String>();
  private List<String> ignoreList = new ArrayList<String>();
  private List<ObjectMap<String, Object>> commands = new ArrayList<ObjectMap<String, Object>>();
  private Boolean notActivated = false;
  private PetTO pet = null;
  private List<Object> quests = new ArrayList<Object>();
  private Date created = new Date();
  private Boolean drawEnabled = false;
  private Boolean acceptRequests = true;
  private int soundVolume = 40;
  private int musicVolume = 20;
  private Boolean showTips = false;
  private Boolean showCharNames;
  private Date serverTime;
  private Boolean finishingNotification;
  private Boolean finishedNotification;
  private Boolean superUser = false;
  private StuffItemLightTO playerCard;

  private RobotTO robot = null;
  private List<FriendTO> robotTeam = null;
  private Integer teamColor = 0;

  public int getSoundVolume() {
    return soundVolume;
  }

  public void setSoundVolume(int soundVolume) {
    this.soundVolume = soundVolume;
  }

  public int getMusicVolume() {
    return musicVolume;
  }

  public void setMusicVolume(int musicVolume) {
    this.musicVolume = musicVolume;
  }

  public Boolean getShowTips() {
    return showTips;
  }

  public void setShowTips(Boolean showTips) {
    this.showTips = showTips;
  }

  public String getRemoteId() {
    return remoteId;
  }

  public void setRemoteId(String remoteId) {
    this.remoteId = remoteId;
  }

  public Boolean getChatEnabled() {
    return chatEnabled;
  }

  public void setChatEnabled(Boolean chatEnabled) {
    this.chatEnabled = chatEnabled;
  }

  public Long getChatBanLeftTime() {
    return chatBanLeftTime;
  }

  public void setChatBanLeftTime(Long chatBanLeftTime) {
    this.chatBanLeftTime = chatBanLeftTime;
  }

  public Boolean getHelpEnabled() {
    return helpEnabled;
  }

  public void setHelpEnabled(Boolean helpEnabled) {
    this.helpEnabled = helpEnabled;
  }

  public Boolean getIsGuest() {
    return isGuest;
  }

  public void setIsGuest(Boolean isGuest) {
    this.isGuest = isGuest;
  }

  public String getEmail() {
    return email;
  }

  public void setEmail(String email) {
    this.email = email;
  }

  public Boolean getIsAgent() {
    return isAgent;
  }

  public void setIsAgent(Boolean isAgent) {
    this.isAgent = isAgent;
  }

  public Boolean getIsCitizen() {
    return isCitizen;
  }

  public void setIsCitizen(Boolean isCitizen) {
    this.isCitizen = isCitizen;
  }

  public Date getCitizenExpirationDate() {
    return citizenExpirationDate;
  }

  public void setCitizenExpirationDate(Date citizenExpirationDate) {
    this.citizenExpirationDate = citizenExpirationDate;
  }

  public Boolean getIsModerator() {
    return isModerator;
  }

  public void setIsModerator(Boolean isModerator) {
    this.isModerator = isModerator;
  }

  public Boolean getIsParent() {
    return isParent;
  }

  public void setIsParent(Boolean isParent) {
    this.isParent = isParent;
  }

  public Boolean getFirstLogin() {
    return firstLogin;
  }

  public void setFirstLogin(Boolean firstLogin) {
    this.firstLogin = firstLogin;
  }

  public String getBody() {
    return body;
  }

  public void setBody(String body) {
    this.body = body;
  }

  public Double getMoney() {
    return money;
  }

  public void setMoney(Double money) {
    this.money = money;
  }

  public List<StuffItemLightTO> getStuffs() {
    return stuffs;
  }

  public void setStuffs(List<StuffItemLightTO> stuffs) {
    this.stuffs = stuffs;
  }

  public List<String> getFriends() {
    return friends;
  }

  public void setFriends(List<String> friends) {
    this.friends = friends;
  }

  public List<String> getIgnoreList() {
    return ignoreList;
  }

  public void setIgnoreList(List<String> ignoreList) {
    this.ignoreList = ignoreList;
  }

  public List<ObjectMap<String, Object>> getCommands() {
    return commands;
  }

  public void setCommands(List<ObjectMap<String, Object>> commands) {
    this.commands = commands;
  }

  public Boolean getNotActivated() {
    return notActivated;
  }

  public void setNotActivated(Boolean notActivated) {
    this.notActivated = notActivated;
  }

  public PetTO getPet() {
    return pet;
  }

  public void setPet(PetTO pet) {
    this.pet = pet;
  }

  public List<Object> getQuests() {
    return quests;
  }

  public void setQuests(List<Object> quests) {
    this.quests = quests;
  }

  public Date getCreated() {
    return created;
  }

  public void setCreated(Date created) {
    this.created = created;
  }

  public Boolean getDrawEnabled() {
    return drawEnabled;
  }

  public void setDrawEnabled(Boolean drawEnabled) {
    this.drawEnabled = drawEnabled;
  }

  public Boolean getAcceptRequests() {
    return acceptRequests;
  }

  public void setAcceptRequests(Boolean acceptRequests) {
    this.acceptRequests = acceptRequests;
  }

  public Boolean getChatEnabledByParent() {
    return chatEnabledByParent;
  }

  public void setChatEnabledByParent(Boolean chatEnabledByParent) {
    this.chatEnabledByParent = chatEnabledByParent;
  }

  public Integer getCitizenTryCount() {
    return citizenTryCount;
  }

  public void setCitizenTryCount(Integer citizenTryCount) {
    this.citizenTryCount = citizenTryCount;
  }

  public Integer getColor() {
    return color;
  }

  public void setColor(Integer color) {
    this.color = color;
  }

  public Date getServerTime() {
    return serverTime;
  }

  public void setServerTime(Date serverTime) {
    this.serverTime = serverTime;
  }

  public Boolean getShowCharNames() {
    return showCharNames;
  }

  public void setShowCharNames(Boolean showCharNames) {
    this.showCharNames = showCharNames;
  }

  public Boolean getFinishingNotification() {
    return finishingNotification;
  }

  public void setFinishingNotification(Boolean finishingNotification) {
    this.finishingNotification = finishingNotification;
  }

  public Boolean getFinishedNotification() {
    return finishedNotification;
  }

  public void setFinishedNotification(Boolean finishedNotification) {
    this.finishedNotification = finishedNotification;
  }

  public List<String> getDances() {
    return dances;
  }

  public void setDances(List<String> dances) {
    this.dances = dances;
  }

  public Boolean getMembershipChatDisabled() {
    return membershipChatDisabled;
  }

  public void setMembershipChatDisabled(Boolean membershipChatDisabled) {
    this.membershipChatDisabled = membershipChatDisabled;
  }

  public Boolean getNonCitizenChatDisabled() {
    return nonCitizenChatDisabled;
  }

  public void setNonCitizenChatDisabled(Boolean nonCitizenChatDisabled) {
    this.nonCitizenChatDisabled = nonCitizenChatDisabled;
  }

  public Boolean getServerInSafeMode() {
    return serverInSafeMode;
  }

  public void setServerInSafeMode(Boolean serverInSafeMode) {
    this.serverInSafeMode = serverInSafeMode;
  }

  public Boolean getSuperUser() {
    return superUser;
  }

  public void setSuperUser(Boolean superUser) {
    this.superUser = superUser;
  }

  public Long getUserId() {
    return userId;
  }

  public void setUserId(Long userId) {
    this.userId = userId;
  }

  public StuffItemLightTO getPlayerCard() {
    return playerCard;
  }

  public void setPlayerCard(StuffItemLightTO stuffItemLightTO) {
    this.playerCard = stuffItemLightTO;
  }

  public RobotTO getRobot() {
    return robot;
  }

  public void setRobot(RobotTO robot) {
    this.robot = robot;
  }

  public List<FriendTO> getRobotTeam() {
    return robotTeam;
  }

  public void setRobotTeam(List<FriendTO> robotTeam) {
    this.robotTeam = robotTeam;
  }

  public Integer getTeamColor() {
    return teamColor;
  }

  public void setTeamColor(Integer teamColor) {
    this.teamColor = teamColor;
  }

  public Long getAge() {
    return age;
  }

  public void setAge(Long age) {
    this.age = age;
  }
}
