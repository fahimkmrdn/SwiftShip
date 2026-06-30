<%@ page import="com.swiftship.model.Shipment" %>
<%@ page import="com.swiftship.model.User" %>
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
    <title>SwiftShip Admin - Update Status</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/admin/style.css">
    
    <script src="<%=request.getContextPath()%>/theme.js"></script>    
</head>
<body>

<div class="d-flex vh-100 overflow-hidden">
    <aside class="sidebar d-none d-lg-flex flex-column flex-shrink-0">
        <div class="brand-header p-4 border-bottom border-secondary">
            <h1 class="m-0"><i class="bi bi-box-seam-fill text-primary me-2"></i>SwiftShip</h1>
            <p class="small m-0 mt-1">Admin Portal</p>
        </div>
        <nav class="nav flex-column flex-grow-1 py-3 overflow-auto">
            <a href="<%=request.getContextPath()%>/DashboardServlet" class="nav-item-link">
                <i class="bi bi-grid-1x2-fill"></i> DASHBOARD HOME
            </a>
            <a href="<%=request.getContextPath()%>/admin/admin_register.jsp" class="nav-item-link">
                <i class="bi bi-pencil-square"></i> REGISTER SHIPMENT
            </a>
            <a href="<%=request.getContextPath()%>/UpdateStatusServlet?action=list" class="nav-item-link active">
                <i class="bi bi-arrow-repeat"></i> UPDATE STATUS
            </a>
            <a href="<%=request.getContextPath()%>/admin/admin_compare.jsp" class="nav-item-link">
                <i class="bi bi-calculator-fill"></i> COMPARE RATES
            </a>
            <% if ("Admin".equalsIgnoreCase(currentUser.getRole())) { %>
            <a href="<%=request.getContextPath()%>/admin/admin_reports.jsp" class="nav-item-link">
                <i class="bi bi-bar-chart-fill"></i> REPORTS
            </a>
            <a href="<%=request.getContextPath()%>/admin/admin_users.jsp" class="nav-item-link">
                <i class="bi bi-people-fill"></i> MANAGE USERS
            </a>
            <% } %>
        </nav>
    </aside>

    <div class="flex-grow-1 d-flex flex-column w-100">
        <header class="topbar d-flex justify-content-between align-items-center px-4 sticky-top">
            <div class="d-flex align-items-center">
                <button class="btn btn-outline-secondary d-lg-none me-3 border-0">
                    <i class="bi bi-list fs-4"></i>
                </button>
                <h2 class="text-light m-0 fs-4 fw-semibold">Shipment Management</h2>
            </div>
            
            <div class="d-flex align-items-center gap-4">
                <button class="btn btn-outline-secondary rounded-circle d-flex align-items-center justify-content-center p-2" onclick="toggleTheme()" title="Toggle Light/Dark Mode" style="width: 40px; height: 40px;">
        	        <i class="bi theme-icon-toggle fs-5"></i>
                </button>
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
            <div class="admin-card p-4">
                
                <div class="row g-3 mb-4">
                    <div class="col-md-4">
                        <form action="<%=request.getContextPath()%>/UpdateStatusServlet" method="POST" class="input-group">
                            <input type="hidden" name="action" value="search">
                            <input type="text" name="trackingNumber" class="form-control" placeholder="Search Tracking ID...">
                            <button class="btn btn-primary" type="submit"><i class="bi bi-search"></i></button>
                        </form>
                    </div>
                    <div class="col-md-3">
                        <select class="form-select" onchange="filterTable()">
                            <option value="">All Carriers</option>
                            <option value="DHL">DHL Express</option>
                            <option value="Pos Laju">Pos Laju</option>
                            <option value="J&T">J&T Express</option>
                        </select>
                    </div>
                    <div class="col-md-3">
                        <select class="form-select" onchange="filterTable()">
                            <option value="">All Statuses</option>
                            <option value="Booked">Booked</option>
                            <option value="Picked Up">Picked Up</option>
                            <option value="In Transit">In Transit</option>
                            <option value="Out for Delivery">Out for Delivery</option>
                            <option value="Delivered">Delivered</option>
                        </select>
                    </div>
                </div>

                <% if (request.getParameter("msg") != null) { %>
                    <div class="alert alert-success">Status Updated Successfully!</div>
                <% } %>

                <div class="table-responsive">
                    <table class="table table-custom table-hover align-middle">
                        <thead>
                            <tr>
                                <th>Tracking #</th>
                                <th>Carrier</th>
                                <th>Destination</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                List<Shipment> shipments = (List<Shipment>) request.getAttribute("shipmentList");
                                if (shipments != null && !shipments.isEmpty()) {
                                    for (Shipment s : shipments) {
                                        String carrierName = "Unknown Carrier";
                                        if (s.getCarrierId() == 1) carrierName = "DHL Express";
                                        else if (s.getCarrierId() == 2) carrierName = "Pos Laju";
                                        else if (s.getCarrierId() == 5) carrierName = "J&T Express";
                            %>
                            <tr>
                                <td><%= s.getTrackingNumber() %></td>
                                <td><%= carrierName %></td>
                                <td><%= s.getReceiverAddress() %></td>
                                <td>
                                    <span class="badge 
                                        <%= "Delivered".equals(s.getStatus()) ? "bg-success" : 
                                            "In Transit".equals(s.getStatus()) ? "bg-warning text-dark" : "bg-secondary" %>">
                                        <%= s.getStatus() %>
                                    </span>
                                </td>
                                <td>
                                    <button class="btn btn-outline-primary" 
                                            onclick="openUpdateModal('<%= s.getTrackingNumber() %>')">
                                        Update
                                    </button>
                                </td>
                            </tr>
                            <% 
                                    } 
                                } else { 
                            %>
                            <tr>
                                <td colspan="5" class="text-center py-4">No shipments available.</td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
                
                <!-- Pagination Controls added here -->
                <%
                    Integer currentPageAttr = (Integer) request.getAttribute("currentPage");
                    Integer totalPagesAttr = (Integer) request.getAttribute("totalPages");
                    
                    if (currentPageAttr != null && totalPagesAttr != null && totalPagesAttr > 1) {
                        int currentPage = currentPageAttr;
                        int totalPages = totalPagesAttr;
                %>
                <div class="d-flex justify-content-between align-items-center mt-4 border-top border-secondary pt-3">
                    <span class="small">Showing page <%= currentPage %> of <%= totalPages %></span>
                    <nav aria-label="Page navigation">
                        <ul class="pagination pagination-sm mb-0 custom-pagination">
                            <li class="page-item <%= (currentPage == 1) ? "disabled" : "" %>">
                                <a class="page-link bg-dark text-light border-secondary" href="?action=list&page=<%= currentPage - 1 %>">Previous</a>
                            </li>
                            <li class="page-item <%= (currentPage == totalPages) ? "disabled" : "" %>">
                                <a class="page-link bg-dark text-light border-secondary" href="?action=list&page=<%= currentPage + 1 %>">Next</a>
                            </li>
                        </ul>
                    </nav>
                </div>
                <% } %>
                
            </div>
        </main>
    </div>
</div>

<div class="modal fade" id="updateModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog">
        <form action="<%=request.getContextPath()%>/UpdateStatusServlet" method="POST" class="modal-content bg-dark text-white border-secondary">
            <div class="modal-header border-secondary">
                <h5 class="modal-title">Update Shipment Status</h5>
            </div>
            <div class="modal-body">
                <input type="hidden" name="action" value="updateStatus">
                <input type="hidden" name="trackingNumber" id="modalTracking">
                <div class="mb-3">
                    <label class="form-label">New Status</label>
                    <select name="status" class="form-select bg-dark text-white border-secondary" required>
                        <option value="Booked">Booked</option>
                        <option value="Picked Up">Picked Up</option>
                        <option value="In Transit">In Transit</option>
                        <option value="Out for Delivery">Out for Delivery</option>
                        <option value="Delivered">Delivered</option>
                    </select>
                </div>
            </div>
            <div class="modal-footer border-secondary">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                <button type="submit" class="btn btn-primary">Save Changes</button>
            </div>
        </form>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function openUpdateModal(trackingNumber) {
        document.getElementById('modalTracking').value = trackingNumber;
        const myModal = new bootstrap.Modal(document.getElementById('updateModal'));
        myModal.show();
    }

    function filterTable() {
        console.log("Filter logic triggered");
    }
</script>
</body>
</html>