package com.swiftship.servlet;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.swiftship.dao.UserDAO;
import com.swiftship.model.User;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public LoginServlet() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        UserDAO userDao = new UserDAO();
        User loggedInUser = userDao.authenticateUser(username, password);

        if (loggedInUser != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", loggedInUser);
            
            response.sendRedirect(request.getContextPath() + "/DashboardServlet");
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/admin_login.jsp?error=invalid_credentials"); 
        }
    }
}