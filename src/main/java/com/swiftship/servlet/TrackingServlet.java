package com.swiftship.servlet;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.swiftship.dao.ShipmentDAO;
import com.swiftship.model.Shipment;
import com.swiftship.model.StatusHistory;

@WebServlet("/TrackingServlet")
public class TrackingServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String trackingNumber = request.getParameter("trackingNumber");
        
        if (trackingNumber == null || trackingNumber.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/index.jsp?error=not_found");
            return;
        }

        ShipmentDAO dao = new ShipmentDAO();
        Shipment shipment = dao.getShipmentByTracking(trackingNumber.trim());

        if (shipment != null) {
            List<StatusHistory> history = dao.getStatusHistory(shipment.getShipmentId());
            request.setAttribute("shipment", shipment);
            request.setAttribute("history", history);
            request.getRequestDispatcher("/tracking.jsp").forward(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/index.jsp?error=not_found");
        }
    }
}