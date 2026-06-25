package com.swiftship.model;

import java.io.Serializable;
import java.sql.Timestamp;

public class StatusHistory implements Serializable {

    private static final long serialVersionUID = 1L;

    private int historyId;
    private String status;
    private String updatedBy;
    private Timestamp timestamp;
    private int shipmentId; 

    public StatusHistory() {
    }

    public StatusHistory(int historyId, String status, String updatedBy, Timestamp timestamp, int shipmentId) {
        this.historyId = historyId;
        this.status = status;
        this.updatedBy = updatedBy;
        this.timestamp = timestamp;
        this.shipmentId = shipmentId;
    }

    public int getHistoryId() {
        return historyId;
    }

    public void setHistoryId(int historyId) {
        this.historyId = historyId;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getUpdatedBy() {
        return updatedBy;
    }

    public void setUpdatedBy(String updatedBy) {
        this.updatedBy = updatedBy;
    }

    public Timestamp getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(Timestamp timestamp) {
        this.timestamp = timestamp;
    }

    public int getShipmentId() {
        return shipmentId;
    }

    public void setShipmentId(int shipmentId) {
        this.shipmentId = shipmentId;
    }
}