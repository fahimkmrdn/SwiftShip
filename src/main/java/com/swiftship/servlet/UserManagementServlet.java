package com.swiftship.servlet;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.swiftship.dao.UserDAO;
import com.swiftship.model.User;

@WebServlet("/UserManagementServlet")
public class UserManagementServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (!isMasterAdmin(request, response)) return;

        UserDAO dao = new UserDAO();
        List<User> userList = dao.getAllUsers();
        
        request.setAttribute("userList", userList);
        request.getRequestDispatcher("/admin/admin_users.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (!isMasterAdmin(request, response)) return;

        String action = request.getParameter("action");
        UserDAO dao = new UserDAO();

        if ("add".equals(action)) {
            User newUser = new User();
            newUser.setUsername(request.getParameter("username"));
            newUser.setPassword(request.getParameter("password"));
            newUser.setName(request.getParameter("name"));
            newUser.setEmail(request.getParameter("email"));
            newUser.setPhone(request.getParameter("phone"));

            boolean success = dao.addStaff(newUser);
            if (success) {
                response.sendRedirect(request.getContextPath() + "/UserManagementServlet?msg=added");
            } else {
                response.sendRedirect(request.getContextPath() + "/UserManagementServlet?error=add_failed");
            }
        } 
        else if ("toggle".equals(action)) {
            int userId = Integer.parseInt(request.getParameter("userId"));
            String currentStatus = request.getParameter("currentStatus");
            String newStatus = "Active".equalsIgnoreCase(currentStatus) ? "Inactive" : "Active";
            
            dao.toggleUserStatus(userId, newStatus);
            response.sendRedirect(request.getContextPath() + "/UserManagementServlet?msg=status_updated");
        }
    }

    private boolean isMasterAdmin(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/admin/admin_login.jsp");
            return false;
        }
        User currentUser = (User) session.getAttribute("user");
        if (!"Admin".equalsIgnoreCase(currentUser.getRole())) {
            response.sendRedirect(request.getContextPath() + "/DashboardServlet?error=unauthorized");
            return false;
        }
        return true;
    }
}