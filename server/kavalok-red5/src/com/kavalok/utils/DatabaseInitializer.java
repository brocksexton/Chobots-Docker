package com.kavalok.utils;

import java.util.Date;

import org.hibernate.Session;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.kavalok.dao.AdminDAO;
import com.kavalok.dao.ConfigDAO;
import com.kavalok.dao.ServerDAO;
import com.kavalok.db.Admin;
import com.kavalok.db.Config;
import com.kavalok.db.Server;

public class DatabaseInitializer {
  private static final Logger logger = LoggerFactory.getLogger(DatabaseInitializer.class);

  // Default config values as hex strings
  private static final String[][] DEFAULT_CONFIGS =
      new String[][] {
        {
          "registrationEnabled",
          "ACED0005737200116A6176612E6C616E672E426F6F6C65616ECD207280D59CFAEE0200015A000576616C7565787001"
        },
        {
          "guestEnabled",
          "ACED0005737200116A6176612E6C616E672E426F6F6C65616ECD207280D59CFAEE0200015A000576616C7565787000"
        },
        {
          "spamMessagesCount",
          "ACED0005737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B020000787000000014"
        },
        {
          "serverLimit",
          "ACED0005737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B0200007870000000C8"
        }
      };

  public static void initialize(Session session, String serverUrl, boolean available) {
    ServerDAO serverDAO = new ServerDAO(session);
    Server currentServer = serverDAO.findByUrl(serverUrl);
    if (currentServer == null) {
      if (serverDAO.findAll().isEmpty()) {
        // Create server
        Server server = new Server();
        server.setUrl(serverUrl);
        server.setName("Serv1");
        server.setAvailable(true);
        server.setRunning(available);
        serverDAO.makePersistent(server);
        logger.info("Created new Server record for {} (no servers existed)", serverUrl);

        // Create admin user if none exists
        AdminDAO adminDAO = new AdminDAO(session);
        if (adminDAO.findAll().isEmpty()) {
          Admin admin = new Admin();
          admin.setLogin("admin");
          admin.setPassword("admin"); // In production, hash this!
          admin.setPermissionLevel(1000);
          adminDAO.makePersistent(admin);
          logger.info("Created placeholder admin user");
        }

        // Create default configs if missing
        ConfigDAO configDAO = new ConfigDAO(session);
        for (int i = 0; i < DEFAULT_CONFIGS.length; i++) {
          String name = DEFAULT_CONFIGS[i][0];
          String hex = DEFAULT_CONFIGS[i][1];
          if (configDAO.findByName(name) == null) {
            Config config = new Config(name);
            config.setCreated(new Date());
            config.setValue(hexStringToByteArray(hex));
            configDAO.makePersistent(config);
            logger.info("Created config entry: {}", name);
          }
        }
      }
    }
  }

  private static byte[] hexStringToByteArray(String s) {
    int len = s.length();
    byte[] data = new byte[len / 2];
    for (int i = 0; i < len; i += 2) {
      data[i / 2] =
          (byte) ((Character.digit(s.charAt(i), 16) << 4) + Character.digit(s.charAt(i + 1), 16));
    }
    return data;
  }
}
