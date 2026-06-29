package com.swiftship.util;

import com.swiftship.dao.UserDAO;
import com.swiftship.model.User;

/**
 * A simple script to test the Oracle Database connection and DAOs.
 */
public class TestConnection {

    public static void main(String[] args) {
        System.out.println("Starting DAO test...");
        
        // Instantiate the DAO
        UserDAO userDao = new UserDAO();
        
        // Test with the credentials we just inserted into SQL Developer
        System.out.println("Attempting to login with 'admin' / 'admin123'...");
        User user = userDao.authenticateUser("admin", "admin123");
        
        if (user != null) {
            System.out.println("\n🎉 SUCCESS! Logged in as: " + user.getName() + " (Role: " + user.getRole() + ")");
        } else {
            System.out.println("\n❌ FAILED! Could not authenticate user. Check credentials or database.");
        }
    }
}