<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Test JSP</title>
</head>
<body>
    <h1>Test JSP Working!</h1>
    <p>Current time: <%= new java.util.Date() %></p>
    <p>Server info: <%= application.getServerInfo() %></p>
    <p>Servlet version: <%= application.getMajorVersion() %>.<%= application.getMinorVersion() %></p>
</body>
</html> 