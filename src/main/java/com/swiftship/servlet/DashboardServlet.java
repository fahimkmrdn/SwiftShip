package com.swiftship.servlet;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.swiftship.dao.ShipmentDAO;
import com.swiftship.model.Shipment;

@WebServlet("/DashboardServlet")
public class DashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/admin/admin_login.jsp");
            return;
        }

        ShipmentDAO dao = new ShipmentDAO();
        
        int totalShipments = dao.getTotalShipmentsCount();
        int inTransit = dao.getInTransitCount();
        int delivered = dao.getDeliveredCount();
        List<Shipment> recentShipments = dao.getRecentShipments(5);

        request.setAttribute("totalShipments", totalShipments);
        request.setAttribute("inTransit", inTransit);
        request.setAttribute("delivered", delivered);
        request.setAttribute("recentShipments", recentShipments);

        request.getRequestDispatcher("/admin/admin_dashboard.jsp").forward(request, response);
    }
}