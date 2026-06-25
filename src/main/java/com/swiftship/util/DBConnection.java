package com.swiftship.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    private static final String DB_URL = "jdbc:oracle:thin:@localhost:1521/FREEPDB1"; 
    private static final String DB_USER = "system";
    private static final String DB_PASSWORD = "oracle";

    public static Connection getConnection() {
        Connection connection = null;
        try {
            Class.forName("oracle.jdbc.OracleDriver");
            
            connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            System.out.println("Database connection successful!");
            
        } catch (ClassNotFoundException e) {
            System.out.println("Oracle JDBC Driver not found. Please make sure the ojdbc JAR is in your WEB-INF/lib folder.");
            e.printStackTrace();
        } catch (SQLException e) {
            System.out.println("Database connection failed. Check your password and Docker status.");
            e.printStackTrace();
        }
        return connection;
    }
}