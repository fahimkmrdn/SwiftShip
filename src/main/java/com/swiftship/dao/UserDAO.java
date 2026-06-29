package com.swiftship.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.swiftship.model.User;
import com.swiftship.util.DBConnection;

public class UserDAO {

    public User authenticateUser(String username, String password) {
        User loggedInUser = null;
        
        String sql = "SELECT * FROM Users WHERE username = ? AND password = ? AND status = 'Active'";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, username);
            pstmt.setString(2, password);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    loggedInUser = new User();
                    loggedInUser.setUserId(rs.getInt("UserID"));
                    loggedInUser.setUsername(rs.getString("username"));
                    loggedInUser.setName(rs.getString("name"));
                    loggedInUser.setEmail(rs.getString("email"));
                    loggedInUser.setPhone(rs.getString("phone"));
                    loggedInUser.setRole(rs.getString("role"));
                    loggedInUser.setStatus(rs.getString("status"));
                }
            }

        } catch (SQLException e) {
            System.out.println("Error during user authentication: " + e.getMessage());
            e.printStackTrace();
        }

        return loggedInUser;
    }
}