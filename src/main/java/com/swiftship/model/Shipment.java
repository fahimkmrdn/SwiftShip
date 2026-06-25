package com.swiftship.model;

import java.io.Serializable;

public class Shipment implements Serializable {

    private static final long serialVersionUID = 1L;

    private int shipmentId;
    private String trackingNumber;
    private String senderName;
    private String senderPhone;
    private String senderAddress;
    private String receiverName;
    private String receiverPhone;
    private String receiverAddress;
    private String parcelWeight;
    private String status;
    private int carrierId; 

    public Shipment() {
    }

    public Shipment(int shipmentId, String trackingNumber, String senderName, String senderPhone, String senderAddress, String receiverName, String receiverPhone, String receiverAddress, String parcelWeight, String status, int carrierId) {
        this.shipmentId = shipmentId;
        this.trackingNumber = trackingNumber;
        this.senderName = senderName;
        this.senderPhone = senderPhone;
        this.senderAddress = senderAddress;
        this.receiverName = receiverName;
        this.receiverPhone = receiverPhone;
        this.receiverAddress = receiverAddress;
        this.parcelWeight = parcelWeight;
        this.status = status;
        this.carrierId = carrierId;
    }

    public int getShipmentId() {
        return shipmentId;
    }

    public void setShipmentId(int shipmentId) {
        this.shipmentId = shipmentId;
    }

    public String getTrackingNumber() {
        return trackingNumber;
    }

    public void setTrackingNumber(String trackingNumber) {
        this.trackingNumber = trackingNumber;
    }

    public String getSenderName() {
        return senderName;
    }

    public void setSenderName(String senderName) {
        this.senderName = senderName;
    }

    public String getSenderPhone() {
        return senderPhone;
    }

    public void setSenderPhone(String senderPhone) {
        this.senderPhone = senderPhone;
    }

    public String getSenderAddress() {
        return senderAddress;
    }

    public void setSenderAddress(String senderAddress) {
        this.senderAddress = senderAddress;
    }

    public String getReceiverName() {
        return receiverName;
    }

    public void setReceiverName(String receiverName) {
        this.receiverName = receiverName;
    }

    public String getReceiverPhone() {
        return receiverPhone;
    }

    public void setReceiverPhone(String receiverPhone) {
        this.receiverPhone = receiverPhone;
    }

    public String getReceiverAddress() {
        return receiverAddress;
    }

    public void setReceiverAddress(String receiverAddress) {
        this.receiverAddress = receiverAddress;
    }

    public String getParcelWeight() {
        return parcelWeight;
    }

    public void setParcelWeight(String parcelWeight) {
        this.parcelWeight = parcelWeight;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public int getCarrierId() {
        return carrierId;
    }

    public void setCarrierId(int carrierId) {
        this.carrierId = carrierId;
    }
}