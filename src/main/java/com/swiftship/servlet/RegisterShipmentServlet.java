package com.swiftship.servlet;

import java.io.IOException;
import java.util.Random;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.swiftship.dao.ShipmentDAO;
import com.swiftship.model.Shipment;
import com.swiftship.model.User;

@WebServlet("/RegisterShipmentServlet")
public class RegisterShipmentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/admin/admin_login.jsp");
            return;
        }
        User currentUser = (User) session.getAttribute("user");

        String senderName = request.getParameter("senderName");
        String senderPhone = request.getParameter("senderPhone");
        String senderAddress = request.getParameter("senderAddress");
        String receiverName = request.getParameter("receiverName");
        String receiverPhone = request.getParameter("receiverPhone");
        String receiverAddress = request.getParameter("receiverAddress");
        String parcelWeight = request.getParameter("parcelWeight");
        int carrierId = Integer.parseInt(request.getParameter("carrierId"));

        String prefix = "TRK";
        if (carrierId == 1) prefix = "DHL";
        if (carrierId == 2) prefix = "POSL";
        if (carrierId == 5) prefix = "JNT"; 
        
        String randomDigits = String.format("%09d", new Random().nextInt(1000000000));
        String trackingNumber = prefix + randomDigits;

        Shipment shipment = new Shipment();
        shipment.setTrackingNumber(trackingNumber);
        shipment.setSenderName(senderName);
        shipment.setSenderPhone(senderPhone);
        shipment.setSenderAddress(senderAddress);
        shipment.setReceiverName(receiverName);
        shipment.setReceiverPhone(receiverPhone);
        shipment.setReceiverAddress(receiverAddress);
        shipment.setParcelWeight(parcelWeight);
        shipment.setCarrierId(carrierId);

        ShipmentDAO dao = new ShipmentDAO();
        boolean success = dao.registerShipment(shipment, currentUser.getName());

        if (success) {
            response.sendRedirect("admin/admin_register.jsp?success=true&tracking=" + trackingNumber);
        } else {
            response.sendRedirect("admin/admin_register.jsp?error=true");
        }
    }
}