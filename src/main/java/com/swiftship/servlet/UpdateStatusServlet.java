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
        // Protect the route
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/admin/admin_login.jsp");
            return;
        }

        String action = request.getParameter("action");
        ShipmentDAO dao = new ShipmentDAO();

        // Handle the default list view with pagination
        if ("list".equals(action) || action == null) {
            int page = 1;
            int recordsPerPage = 10; // Load 10 shipments at a time
            
            // Get the requested page from the URL (e.g., ?page=2)
            if (request.getParameter("page") != null) {
                try {
                    page = Integer.parseInt(request.getParameter("page"));
                } catch (NumberFormatException e) {
                    page = 1; // Fallback to page 1 if URL is messed up
                }
            }
            
            // Calculate where the database should start pulling records
            int offset = (page - 1) * recordsPerPage;
            
            List<Shipment> shipments = dao.getPaginatedShipments(offset, recordsPerPage);
            int totalRecords = dao.getTotalShipmentsCount();
            int totalPages = (int) Math.ceil((double) totalRecords / recordsPerPage);
            
            request.setAttribute("shipmentList", shipments);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.getRequestDispatcher("/admin/admin_update.jsp").forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Protect the route
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/admin/admin_login.jsp");
            return;
        }
        User currentUser = (User) session.getAttribute("user");

        String action = request.getParameter("action");
        ShipmentDAO dao = new ShipmentDAO();

        // Handle Search queries
        if ("search".equals(action)) {
            String tracking = request.getParameter("trackingNumber");
            List<Shipment> shipments = dao.searchShipments(tracking);
            
            request.setAttribute("shipmentList", shipments);
            // Hide pagination when viewing search results
            request.setAttribute("currentPage", 1);
            request.setAttribute("totalPages", 1); 
            
            request.getRequestDispatcher("/admin/admin_update.jsp").forward(request, response);
            
        } 
        // Handle saving a status update
        else if ("updateStatus".equals(action)) {
            String tracking = request.getParameter("trackingNumber");
            String newStatus = request.getParameter("status");
            
            dao.updateShipmentStatus(tracking, newStatus, currentUser.getName());
            
            // Redirect back to list view with success message
            response.sendRedirect(request.getContextPath() + "/UpdateStatusServlet?action=list&msg=updated");
        }
    }
}