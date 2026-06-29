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

@WebServlet("/ReportServlet")
public class ReportServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    private void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/admin/admin_login.jsp");
            return;
        }

        String carrier = request.getParameter("carrierFilter");
        String status = request.getParameter("statusFilter");
        
        ShipmentDAO dao = new ShipmentDAO();
        List<Shipment> reportList;
        
        if (carrier != null || status != null) {
            reportList = dao.getFilteredShipments(carrier, status);
        } else {
            reportList = null; 
        }

        if (reportList != null) {
            int total = reportList.size();
            int delivered = 0;
            int pending = 0;

            for (Shipment s : reportList) {
                if ("Delivered".equals(s.getStatus())) {
                    delivered++;
                } else {
                    pending++;
                }
            }

            request.setAttribute("totalCount", total);
            request.setAttribute("deliveredCount", delivered);
            request.setAttribute("pendingCount", pending);
        }

        request.setAttribute("reportList", reportList);
        request.getRequestDispatcher("/admin/admin_reports.jsp").forward(request, response);
    }
}