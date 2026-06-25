package com.swiftship.model;

import java.io.Serializable;
import java.sql.Timestamp;


public class EmailNotification implements Serializable {

    private static final long serialVersionUID = 1L;

    private int notificationId;
    private String recipientEmail;
    private String notificationType;
    private Timestamp sentAt;
    private int shipmentId; 

    public EmailNotification() {
    }

    public EmailNotification(int notificationId, String recipientEmail, String notificationType, Timestamp sentAt, int shipmentId) {
        this.notificationId = notificationId;
        this.recipientEmail = recipientEmail;
        this.notificationType = notificationType;
        this.sentAt = sentAt;
        this.shipmentId = shipmentId;
    }

    public int getNotificationId() {
        return notificationId;
    }

    public void setNotificationId(int notificationId) {
        this.notificationId = notificationId;
    }

    public String getRecipientEmail() {
        return recipientEmail;
    }

    public void setRecipientEmail(String recipientEmail) {
        this.recipientEmail = recipientEmail;
    }

    public String getNotificationType() {
        return notificationType;
    }

    public void setNotificationType(String notificationType) {
        this.notificationType = notificationType;
    }

    public Timestamp getSentAt() {
        return sentAt;
    }

    public void setSentAt(Timestamp sentAt) {
        this.sentAt = sentAt;
    }

    public int getShipmentId() {
        return shipmentId;
    }

    public void setShipmentId(int shipmentId) {
        this.shipmentId = shipmentId;
    }
}