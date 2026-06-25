package com.swiftship.model;

import java.io.Serializable;

public class Carrier implements Serializable {

    private static final long serialVersionUID = 1L;

    private int carrierId;
    private String carrierName;
    private String carrierPhone;
    private String carrierEmail;
    private String serviceDetails;

    public Carrier() {
    }

    public Carrier(int carrierId, String carrierName, String carrierPhone, String carrierEmail, String serviceDetails) {
        this.carrierId = carrierId;
        this.carrierName = carrierName;
        this.carrierPhone = carrierPhone;
        this.carrierEmail = carrierEmail;
        this.serviceDetails = serviceDetails;
    }

    public int getCarrierId() {
        return carrierId;
    }

    public void setCarrierId(int carrierId) {
        this.carrierId = carrierId;
    }

    public String getCarrierName() {
        return carrierName;
    }

    public void setCarrierName(String carrierName) {
        this.carrierName = carrierName;
    }

    public String getCarrierPhone() {
        return carrierPhone;
    }

    public void setCarrierPhone(String carrierPhone) {
        this.carrierPhone = carrierPhone;
    }

    public String getCarrierEmail() {
        return carrierEmail;
    }

    public void setCarrierEmail(String carrierEmail) {
        this.carrierEmail = carrierEmail;
    }

    public String getServiceDetails() {
        return serviceDetails;
    }

    public void setServiceDetails(String serviceDetails) {
        this.serviceDetails = serviceDetails;
    }
}