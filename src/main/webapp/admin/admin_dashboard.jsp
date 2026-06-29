<%@ page import="com.swiftship.model.User" %>
<%@ page import="com.swiftship.model.Shipment" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    User currentUser = (User) session.getAttribute("user");
    if (currentUser == null) {
        response.sendRedirect(request.getContextPath() + "/admin/admin_login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SwiftShip Admin - Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/admin/style.css">
</head>
<body>

    <div class="d-flex min-vh-100">
        
        <aside class="sidebar d-none d-lg-flex flex-column flex-shrink-0">
            <div class="brand-header p-4 border-bottom border-secondary">
                <h1 class="m-0"><i class="bi bi-box-seam-fill text-primary me-2"></i>SwiftShip</h1>
                <p class="small m-0 mt-1">Admin Portal</p>
            </div>
            <nav class="nav flex-column flex-grow-1 py-3 overflow-auto">
                <a href="<%=request.getContextPath()%>/DashboardServlet" class="nav-item-link active">
                    <i class="bi bi-grid-1x2-fill"></i> DASHBOARD HOME
                </a>
                <a href="<%=request.getContextPath()%>/admin/admin_register.jsp" class="nav-item-link">
                    <i class="bi bi-pencil-square"></i> REGISTER SHIPMENT
                </a>
                <a href="<%=request.getContextPath()%>/UpdateStatusServlet?action=list" class="nav-item-link">
                    <i class="bi bi-arrow-repeat"></i> UPDATE STATUS
                </a>
                <a href="<%=request.getContextPath()%>/admin/admin_compare.jsp" class="nav-item-link">
                    <i class="bi bi-calculator-fill"></i> COMPARE RATES
                </a>
                <a href="<%=request.getContextPath()%>/admin/admin_reports.jsp" class="nav-item-link">
                    <i class="bi bi-bar-chart-fill"></i> REPORTS
                </a>
            </nav>
        </aside>

        <div class="flex-grow-1 d-flex flex-column w-100">
            
            <header class="topbar d-flex justify-content-between align-items-center px-4 sticky-top">
                <div class="d-flex align-items-center">
                    <button class="btn btn-outline-secondary d-lg-none me-3 border-0">
                        <i class="bi bi-list fs-4"></i>
                    </button>
                    <h2 class="text-light m-0 fs-4 fw-semibold">Overview</h2>
                </div>
                
                <div class="d-flex align-items-center gap-4">
                    <div class="d-none d-md-flex align-items-center gap-2 text-light">
                        <i class="bi bi-person-circle fs-4 text-secondary"></i>
                        <span class="fw-medium"><%= currentUser.getName() %> (<%= currentUser.getRole() %>)</span>
                    </div>
                    <a href="<%=request.getContextPath()%>/LogoutServlet" class="btn btn-outline-danger btn-sm px-3 fw-medium">
                        <i class="bi bi-box-arrow-right me-1"></i> Logout
                    </a>
                </div>
            </header>

            <main class="p-4 flex-grow-1 overflow-auto">
                
                <div class="row g-4 mb-4">
                    <div class="col-12 col-md-4">
                        <div class="admin-card p-4 text-center h-100">
                            <h3 class="text-uppercase fs-6 fw-bold mb-2">Total Shipments</h3>
                            <div class="stat-value"><%= request.getAttribute("totalShipments") != null ? request.getAttribute("totalShipments") : "0" %></div>
                        </div>
                    </div>
                    <div class="col-12 col-md-4">
                        <div class="admin-card p-4 text-center h-100">
                            <h3 class="text-uppercase fs-6 fw-bold mb-2">Currently In Transit</h3>
                            <div class="stat-value text-warning"><%= request.getAttribute("inTransit") != null ? request.getAttribute("inTransit") : "0" %></div>
                        </div>
                    </div>
                    <div class="col-12 col-md-4">
                        <div class="admin-card p-4 text-center h-100">
                            <h3 class="text-uppercase fs-6 fw-bold mb-2">Delivered</h3>
                            <div class="stat-value text-success"><%= request.getAttribute("delivered") != null ? request.getAttribute("delivered") : "0" %></div>
                        </div>
                    </div>
                </div>

                <div class="admin-card">
                    <div class="p-4 border-bottom border-secondary d-flex justify-content-between align-items-center">
                        <h3 class="m-0 text-light fs-5 fw-semibold">Recent Shipments</h3>
                        <a href="<%=request.getContextPath()%>/DashboardServlet" class="btn btn-sm btn-outline-primary"><i class="bi bi-arrow-clockwise"></i> Refresh</a>
                    </div>
                    
                    <div class="table-responsive">
                        <table class="table table-custom table-hover align-middle">
                            <thead>
                                <tr>
                                    <th scope="col">Tracking Number</th>
                                    <th scope="col">Sender Name</th>
                                    <th scope="col">Carrier</th>
                                    <th scope="col">Status</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    List<Shipment> recentShipments = (List<Shipment>) request.getAttribute("recentShipments");
                                    if (recentShipments != null && !recentShipments.isEmpty()) {
                                        for (Shipment s : recentShipments) {
                                            String carrierName = "Unknown Carrier";
                                            String iconColor = "text-secondary";
                                            if (s.getCarrierId() == 1) { carrierName = "DHL Express"; iconColor = "text-warning"; }
                                            else if (s.getCarrierId() == 2) { carrierName = "Pos Laju"; iconColor = "text-danger"; }
                                            else if (s.getCarrierId() == 5) { carrierName = "J&T Express"; iconColor = "text-danger"; }

                                            String badgeClass = "bg-secondary";
                                            if ("Delivered".equals(s.getStatus())) badgeClass = "bg-delivered";
                                            else if ("In Transit".equals(s.getStatus())) badgeClass = "bg-transit";
                                            else if ("Booked".equals(s.getStatus())) badgeClass = "bg-booked";
                                %>
                                <tr>
                                    <td><strong class="text-light"><%= s.getTrackingNumber() %></strong></td>
                                    <td><%= s.getSenderName() %></td>
                                    <td>
                                        <span class="d-inline-flex align-items-center gap-1">
                                            <i class="bi bi-truck <%= iconColor %>"></i> <%= carrierName %>
                                        </span>
                                    </td>
                                    <td><span class="badge-custom <%= badgeClass %>"><%= s.getStatus() %></span></td>
                                </tr>
                                <%
                                        }
                                    } else {
                                %>
                                <tr>
                                    <td colspan="4" class="text-center py-4">No recent shipments found.</td>
                                </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                </div>

            </main>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>