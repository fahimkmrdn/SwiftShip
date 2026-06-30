package com.swiftship.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.swiftship.model.Shipment;
import com.swiftship.model.StatusHistory;
import com.swiftship.util.DBConnection;

public class ShipmentDAO {

    // --- HELPER METHOD TO PREVENT INCONSISTENT DATA ---
    private Shipment mapRowToShipment(ResultSet rs) throws SQLException {
        Shipment s = new Shipment();
        s.setShipmentId(rs.getInt("ShipmentID"));
        s.setTrackingNumber(rs.getString("trackingnumber"));
        s.setSenderName(rs.getString("sendername"));
        s.setSenderPhone(rs.getString("senderphone"));
        s.setSenderAddress(rs.getString("senderaddress"));
        s.setReceiverName(rs.getString("receivername"));
        s.setReceiverPhone(rs.getString("receiverphone"));
        s.setReceiverAddress(rs.getString("receiveraddress"));
        s.setParcelWeight(rs.getString("parcelweight"));
        s.setStatus(rs.getString("status"));
        s.setCarrierId(rs.getInt("carrierID"));
        return s;
    }

    public boolean registerShipment(Shipment shipment, String adminName) {
        boolean isSuccess = false;
        String insertShipmentSql = "INSERT INTO Shipment (trackingnumber, sendername, senderphone, senderaddress, receivername, receiverphone, receiveraddress, parcelweight, status, carrierID) VALUES (?, ?, ?, ?, ?, ?, ?, ?, 'Booked', ?)";
        
        try (Connection conn = DBConnection.getConnection()) {
            String[] returnId = { "SHIPMENTID" };
            try (PreparedStatement pstmt = conn.prepareStatement(insertShipmentSql, returnId)) {
                pstmt.setString(1, shipment.getTrackingNumber());
                pstmt.setString(2, shipment.getSenderName());
                pstmt.setString(3, shipment.getSenderPhone());
                pstmt.setString(4, shipment.getSenderAddress());
                pstmt.setString(5, shipment.getReceiverName());
                pstmt.setString(6, shipment.getReceiverPhone());
                pstmt.setString(7, shipment.getReceiverAddress());
                pstmt.setString(8, shipment.getParcelWeight()); 
                pstmt.setInt(9, shipment.getCarrierId());

                int affectedRows = pstmt.executeUpdate();

                if (affectedRows > 0) {
                    try (ResultSet rs = pstmt.getGeneratedKeys()) {
                        if (rs.next()) {
                            int newShipmentId = rs.getInt(1); 
                            String insertHistorySql = "INSERT INTO StatusHistory (status, updatedby, ShipmentID) VALUES ('Booked', ?, ?)";
                            try (PreparedStatement historyPstmt = conn.prepareStatement(insertHistorySql)) {
                                historyPstmt.setString(1, adminName);
                                historyPstmt.setInt(2, newShipmentId);
                                historyPstmt.executeUpdate();
                            }
                        }
                    }
                    isSuccess = true;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return isSuccess;
    }

    public List<Shipment> getAllShipments() {
        List<Shipment> list = new ArrayList<>();
        String sql = "SELECT * FROM Shipment ORDER BY ShipmentID DESC";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                list.add(mapRowToShipment(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // --- NEW: Added for Phase 5 Pagination ---
    public List<Shipment> getPaginatedShipments(int offset, int limit) {
        List<Shipment> list = new ArrayList<>();
        // Oracle 12c+ syntax for pagination
        String sql = "SELECT * FROM Shipment ORDER BY ShipmentID DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
             
            ps.setInt(1, offset);
            ps.setInt(2, limit);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapRowToShipment(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Shipment> searchShipments(String trackingNumber) {
        List<Shipment> list = new ArrayList<>();
        String sql = "SELECT * FROM Shipment WHERE UPPER(trackingnumber) LIKE ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
             
            ps.setString(1, "%" + trackingNumber.toUpperCase() + "%");
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapRowToShipment(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean updateShipmentStatus(String trackingNumber, String newStatus, String updatedBy) {
        int shipmentId = -1;
        String getShipmentSql = "SELECT ShipmentID FROM Shipment WHERE trackingnumber = ?";
        String updateSql = "UPDATE Shipment SET status = ? WHERE trackingnumber = ?";
        String historySql = "INSERT INTO StatusHistory (status, updatedby, ShipmentID) VALUES (?, ?, ?)";
        
        try (Connection conn = DBConnection.getConnection()) {
            conn.setAutoCommit(false); 
            
            try (PreparedStatement psId = conn.prepareStatement(getShipmentSql)) {
                psId.setString(1, trackingNumber);
                try (ResultSet rs = psId.executeQuery()) {
                    if (rs.next()) {
                        shipmentId = rs.getInt("ShipmentID");
                    }
                }
            }
            
            if (shipmentId != -1) {
                try (PreparedStatement psUpdate = conn.prepareStatement(updateSql)) {
                    psUpdate.setString(1, newStatus);
                    psUpdate.setString(2, trackingNumber);
                    psUpdate.executeUpdate();
                }
                
                try (PreparedStatement psHistory = conn.prepareStatement(historySql)) {
                    psHistory.setString(1, newStatus);
                    psHistory.setString(2, updatedBy);
                    psHistory.setInt(3, shipmentId);
                    psHistory.executeUpdate();
                }
                
                conn.commit();
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public Shipment getShipmentByTracking(String trackingNumber) {
        Shipment s = null;
        String sql = "SELECT * FROM Shipment WHERE UPPER(trackingnumber) = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, trackingNumber.toUpperCase());
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    s = mapRowToShipment(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return s;
    }

    public List<StatusHistory> getStatusHistory(int shipmentId) {
        List<StatusHistory> history = new ArrayList<>();
        String sql = "SELECT * FROM StatusHistory WHERE ShipmentID = ? ORDER BY status_timestamp DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, shipmentId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    StatusHistory sh = new StatusHistory();
                    sh.setHistoryId(rs.getInt("HistoryID"));
                    sh.setStatus(rs.getString("status"));
                    sh.setUpdatedBy(rs.getString("updatedby"));
                    sh.setTimestamp(rs.getTimestamp("status_timestamp"));
                    sh.setShipmentId(rs.getInt("ShipmentID"));
                    history.add(sh);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return history;
    }

    public int getTotalShipmentsCount() {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM Shipment";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }

    public int getInTransitCount() {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM Shipment WHERE status = 'In Transit'";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }

    public int getDeliveredCount() {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM Shipment WHERE status = 'Delivered'";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }

    public List<Shipment> getRecentShipments(int limit) {
        List<Shipment> list = new ArrayList<>();
        String sql = "SELECT * FROM (SELECT * FROM Shipment ORDER BY ShipmentID DESC) WHERE ROWNUM <= ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, limit);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapRowToShipment(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Shipment> getFilteredShipments(String carrier, String status) {
        List<Shipment> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM Shipment WHERE 1=1");

        if (status != null && !status.equals("ALL")) {
            if (status.equals("BOOKED")) sql.append(" AND status = 'Booked'");
            else if (status.equals("TRANSIT")) sql.append(" AND status = 'In Transit'");
            else if (status.equals("DELIVERED")) sql.append(" AND status = 'Delivered'");
        }

        if (carrier != null && !carrier.equals("ALL")) {
            if (carrier.equals("DHL")) sql.append(" AND carrierID = 1");
            else if (carrier.equals("POSL")) sql.append(" AND carrierID = 2");
            else if (carrier.equals("JNT")) sql.append(" AND carrierID = 5");
        }

        sql.append(" ORDER BY ShipmentID DESC");

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString());
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                list.add(mapRowToShipment(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}