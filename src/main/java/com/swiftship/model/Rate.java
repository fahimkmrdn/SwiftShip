package com.swiftship.model;

import java.io.Serializable;

public class Rate implements Serializable {

    private static final long serialVersionUID = 1L;

    private int rateId;
    private String originZone;
    private String destinationZone;
    private String weightLimit;
    private String shippingCost;
    private int carrierId;

    public Rate() {
    }

    public Rate(int rateId, String originZone, String destinationZone, String weightLimit, String shippingCost, int carrierId) {
        this.rateId = rateId;
        this.originZone = originZone;
        this.destinationZone = destinationZone;
        this.weightLimit = weightLimit;
        this.shippingCost = shippingCost;
        this.carrierId = carrierId;
    }

    public int getRateId() {
        return rateId;
    }

    public void setRateId(int rateId) {
        this.rateId = rateId;
    }

    public String getOriginZone() {
        return originZone;
    }

    public void setOriginZone(String originZone) {
        this.originZone = originZone;
    }

    public String getDestinationZone() {
        return destinationZone;
    }

    public void setDestinationZone(String destinationZone) {
        this.destinationZone = destinationZone;
    }

    public String getWeightLimit() {
        return weightLimit;
    }

    public void setWeightLimit(String weightLimit) {
        this.weightLimit = weightLimit;
    }

    public String getShippingCost() {
        return shippingCost;
    }

    public void setShippingCost(String shippingCost) {
        this.shippingCost = shippingCost;
    }

    public int getCarrierId() {
        return carrierId;
    }

    public void setCarrierId(int carrierId) {
        this.carrierId = carrierId;
    }
}