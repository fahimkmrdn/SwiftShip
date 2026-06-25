<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.swiftship.model.User" %>
<%
    User currentUser = (User) session.getAttribute("user");
    if (currentUser == null) {
        response.sendRedirect("admin_login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SwiftShip Admin - Register Shipment</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link rel="stylesheet" href="style.css">
</head>
<body>

    <div class="d-flex min-vh-100">
        
        <aside class="sidebar d-none d-lg-flex flex-column flex-shrink-0">
            <div class="brand-header p-4 border-bottom border-secondary">
                <h1 class="m-0"><i class="bi bi-box-seam-fill text-primary me-2"></i>SwiftShip</h1>
                <p class="small m-0 mt-1">Admin Portal</p>
            </div>
            <nav class="nav flex-column flex-grow-1 py-3 overflow-auto">
                <a href="admin_dashboard.jsp" class="nav-item-link">
                    <i class="bi bi-grid-1x2-fill"></i> DASHBOARD HOME
                </a>
                <a href="admin_register.jsp" class="nav-item-link active">
                    <i class="bi bi-pencil-square"></i> REGISTER SHIPMENT
                </a>
				<a href="<%=request.getContextPath()%>/UpdateStatusServlet?action=list" class="nav-item-link">                    <i class="bi bi-arrow-repeat"></i> UPDATE STATUS
                </a>
                <a href="admin_compare.jsp" class="nav-item-link">
                    <i class="bi bi-calculator-fill"></i> COMPARE RATES
                </a>
                <a href="admin_reports.jsp" class="nav-item-link">
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
                    <h2 class="text-light m-0 fs-4 fw-semibold">Register New Shipment</h2>
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
                
                <div class="admin-card p-4 p-md-5 mx-auto" style="max-width: 900px;">
                    <div class="mb-4">
                        <h3 class="m-0 text-light fs-4 fw-semibold">Shipment Details</h3>
                        <p class="m-0 mt-1">Enter the sender, receiver, and parcel specifications to generate a booking.</p>
                    </div>

                    <% 
                        String trackingParam = request.getParameter("tracking");
                        if (trackingParam != null) {
                    %>
                    <div class="alert alert-success d-flex align-items-center" role="alert">
                        <i class="bi bi-check-circle-fill me-2 fs-5"></i>
                        <div>
                            Shipment successfully registered! Tracking Number: <strong class="ms-1"><%= trackingParam %></strong>
                        </div>
                    </div>
                    <% } %>

                    <% 
                        String errorParam = request.getParameter("error");
                        if (errorParam != null) {
                    %>
                    <div class="alert alert-danger d-flex align-items-center" role="alert">
                        <i class="bi bi-exclamation-triangle-fill me-2 fs-5"></i>
                        <div>Failed to register shipment. Check database connection.</div>
                    </div>
                    <% } %>

                    <form action="<%=request.getContextPath()%>/RegisterShipmentServlet" method="POST">
                        
                        <h5 class="text-light fs-6 fw-semibold mt-4 mb-3 pb-2 border-bottom border-secondary">Sender Information</h5>
                        <div class="row g-3">
                            <div class="col-md-6">
                                <label for="senderName" class="form-label small fw-medium">Full Name</label>
                                <input type="text" class="form-control form-custom" id="senderName" name="senderName" required>
                            </div>
                            <div class="col-md-6">
                                <label for="senderPhone" class="form-label small fw-medium">Phone Number</label>
                                <input type="tel" class="form-control form-custom" id="senderPhone" name="senderPhone" required>
                            </div>
                            <div class="col-12">
                                <label for="senderAddress" class="form-label small fw-medium">Full Address</label>
                                <textarea class="form-control form-custom" id="senderAddress" name="senderAddress" rows="2" required></textarea>
                            </div>
                        </div>

                        <h5 class="text-light fs-6 fw-semibold mt-5 mb-3 pb-2 border-bottom border-secondary">Receiver Information</h5>
                        <div class="row g-3">
                            <div class="col-md-6">
                                <label for="receiverName" class="form-label small fw-medium">Full Name</label>
                                <input type="text" class="form-control form-custom" id="receiverName" name="receiverName" required>
                            </div>
                            <div class="col-md-6">
                                <label for="receiverPhone" class="form-label small fw-medium">Phone Number</label>
                                <input type="tel" class="form-control form-custom" id="receiverPhone" name="receiverPhone" required>
                            </div>
                            <div class="col-12">
                                <label for="receiverAddress" class="form-label small fw-medium">Full Address</label>
                                <textarea class="form-control form-custom" id="receiverAddress" name="receiverAddress" rows="2" required></textarea>
                            </div>
                        </div>

                        <h5 class="text-light fs-6 fw-semibold mt-5 mb-3 pb-2 border-bottom border-secondary">Parcel & Carrier</h5>
                        <div class="row g-3 mb-5">
                            <div class="col-md-6">
                                <label for="parcelWeight" class="form-label small fw-medium">Parcel Weight (kg)</label>
                                <input type="number" class="form-control form-custom" id="parcelWeight" name="parcelWeight" step="0.1" min="0.1" placeholder="0.0" required> 
                            </div>
                            <div class="col-md-6">
                                <label for="carrierId" class="form-label small fw-medium">Select Carrier</label>
                                <select class="form-select form-custom" id="carrierId" name="carrierId" required>
                                    <option value="" disabled selected>-- Choose Carrier --</option>
                                    <option value="1">DHL Express</option>
                                    <option value="2">Pos Laju</option>
                                    <option value="5">J&T Express</option>
                                </select>
                            </div>
                        </div>

                        <div class="d-flex justify-content-end gap-3 pt-4 border-top border-secondary">
                            <button type="reset" class="btn btn-outline-secondary px-4">Clear</button>
                            <button type="submit" class="btn btn-primary px-4 fw-medium"><i class="bi bi-save me-2"></i>Register Shipment</button>
                        </div>

                    </form>
                </div>

            </main>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>