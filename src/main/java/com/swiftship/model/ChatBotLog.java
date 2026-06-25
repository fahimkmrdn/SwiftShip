package com.swiftship.model;

import java.io.Serializable;
import java.sql.Timestamp;

public class ChatBotLog implements Serializable {

    private static final long serialVersionUID = 1L;

    private int logId;
    private String sessionId;
    private String userQuery;
    private String botResponse;
    private Timestamp timestamp;
    private String trackingNumber;

    public ChatBotLog() {
    }

    public ChatBotLog(int logId, String sessionId, String userQuery, String botResponse, Timestamp timestamp, String trackingNumber) {
        this.logId = logId;
        this.sessionId = sessionId;
        this.userQuery = userQuery;
        this.botResponse = botResponse;
        this.timestamp = timestamp;
        this.trackingNumber = trackingNumber;
    }

    public int getLogId() {
        return logId;
    }

    public void setLogId(int logId) {
        this.logId = logId;
    }

    public String getSessionId() {
        return sessionId;
    }

    public void setSessionId(String sessionId) {
        this.sessionId = sessionId;
    }

    public String getUserQuery() {
        return userQuery;
    }

    public void setUserQuery(String userQuery) {
        this.userQuery = userQuery;
    }

    public String getBotResponse() {
        return botResponse;
    }

    public void setBotResponse(String botResponse) {
        this.botResponse = botResponse;
    }

    public Timestamp getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(Timestamp timestamp) {
        this.timestamp = timestamp;
    }

    public String getTrackingNumber() {
        return trackingNumber;
    }

    public void setTrackingNumber(String trackingNumber) {
        this.trackingNumber = trackingNumber;
    }
}