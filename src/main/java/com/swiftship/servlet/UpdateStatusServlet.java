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
import com.swiftship.model.User;

@WebServlet("/UpdateStatusServlet")
public class UpdateStatusServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/admin/admin_login.jsp");
            return;
        }

        String action = request.getParameter("action");
        ShipmentDAO dao = new ShipmentDAO();

        if ("list".equals(action) || action == null) {
            List<Shipment> shipments = dao.getAllShipments();
            request.setAttribute("shipmentList", shipments);
            request.getRequestDispatcher("/admin/admin_update.jsp").forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/admin/admin_login.jsp");
            return;
        }
        User currentUser = (User) session.getAttribute("user");

        String action = request.getParameter("action");
        ShipmentDAO dao = new ShipmentDAO();

        if ("search".equals(action)) {
            String tracking = request.getParameter("trackingNumber");
            List<Shipment> shipments = dao.searchShipments(tracking);
            
            request.setAttribute("shipmentList", shipments);
            request.getRequestDispatcher("/admin/admin_update.jsp").forward(request, response);
            
        } else if ("updateStatus".equals(action)) {
            String tracking = request.getParameter("trackingNumber");
            String newStatus = request.getParameter("status");
            
            dao.updateShipmentStatus(tracking, newStatus, currentUser.getName());
            
            response.sendRedirect(request.getContextPath() + "/UpdateStatusServlet?action=list&msg=updated");
        }
    }
}