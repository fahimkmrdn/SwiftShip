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
    if (!"Admin".equalsIgnoreCase(currentUser.getRole())) {
        response.sendRedirect(request.getContextPath() + "/DashboardServlet?error=unauthorized");
        return;
    }
    List<Shipment> reportList = (List<Shipment>) request.getAttribute("reportList");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SwiftShip Admin - Generate Reports</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/admin/style.css">
    
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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
                <a href="<%=request.getContextPath()%>/UpdateStatusServlet?action=list" class="nav-item-link">
                    <i class="bi bi-arrow-repeat"></i> UPDATE STATUS
                </a>
                <a href="<%=request.getContextPath()%>/admin/admin_compare.jsp" class="nav-item-link">
                    <i class="bi bi-calculator-fill"></i> COMPARE RATES
                </a>
                <a href="<%=request.getContextPath()%>/ReportServlet" class="nav-item-link active">
                    <i class="bi bi-bar-chart-fill"></i> REPORTS
                </a>
                <a href="<%=request.getContextPath()%>/UserManagementServlet" class="nav-item-link">
                    <i class="bi bi-people-fill"></i> MANAGE USERS
                </a>
            </nav>
        </aside>

        <div class="flex-grow-1 d-flex flex-column w-100">
            
            <header class="topbar d-flex justify-content-between align-items-center px-4 sticky-top">
                <div class="d-flex align-items-center">
                    <button class="btn btn-outline-secondary d-lg-none me-3 border-0">
                        <i class="bi bi-list fs-4"></i>
                    </button>
                    <h2 class="text-light m-0 fs-4 fw-semibold">Generate Reports</h2>
                </div>
                
                <div class="d-flex align-items-center gap-4">
                    <button class="btn btn-outline-secondary rounded-circle d-flex align-items-center justify-content-center p-2" onclick="toggleTheme()" title="Toggle Light/Dark Mode" style="width: 40px; height: 40px;">
                        <i class="bi theme-icon-toggle fs-5"></i>
                    </button>

                    <div class="d-none d-md-flex align-items-center gap-2 text-light border-start border-secondary ps-3 ms-1">
                        <i class="bi bi-person-circle fs-4 text-secondary"></i>
                        <span class="fw-medium"><%= currentUser.getName() %> (<%= currentUser.getRole() %>)</span>
                    </div>
                    <a href="<%=request.getContextPath()%>/LogoutServlet" class="btn btn-outline-danger btn-sm px-3 fw-medium">
                        <i class="bi bi-box-arrow-right me-1"></i> Logout
                    </a>
                </div>
            </header>

            <main class="p-4 flex-grow-1 overflow-auto">
                
                <div class="admin-card p-4 mb-4">
                    <div class="mb-4 border-bottom border-secondary pb-3">
                        <h3 class="m-0 text-light fs-5 fw-semibold"><i class="bi bi-funnel-fill me-2 text-primary"></i>Report Filters</h3>
                    </div>
                    
                    <form id="reportFilters" action="<%=request.getContextPath()%>/ReportServlet" method="POST">
                        <div class="row g-3 mb-4">
                            <div class="col-md-3">
                                <label for="dateFrom" class="form-label small fw-medium">Date From</label>
                                <input type="date" class="form-control form-custom" id="dateFrom" name="dateFrom">
                            </div>
                            <div class="col-md-3">
                                <label for="dateTo" class="form-label small fw-medium">Date To</label>
                                <input type="date" class="form-control form-custom" id="dateTo" name="dateTo">
                            </div>
                            <div class="col-md-3">
                                <label for="carrierFilter" class="form-label small fw-medium">Carrier</label>
                                <select class="form-select form-custom" id="carrierFilter" name="carrierFilter">
                                    <option value="ALL" <%= "ALL".equals(request.getParameter("carrierFilter")) ? "selected" : "" %>>All Carriers</option>
                                    <option value="DHL" <%= "DHL".equals(request.getParameter("carrierFilter")) ? "selected" : "" %>>DHL Express</option>
                                    <option value="POSL" <%= "POSL".equals(request.getParameter("carrierFilter")) ? "selected" : "" %>>Pos Laju</option>
                                    <option value="JNT" <%= "JNT".equals(request.getParameter("carrierFilter")) ? "selected" : "" %>>J&T Express</option>
                                </select>
                            </div>
                            <div class="col-md-3">
                                <label for="statusFilter" class="form-label small fw-medium">Status</label>
                                <select class="form-select form-custom" id="statusFilter" name="statusFilter">
                                    <option value="ALL" <%= "ALL".equals(request.getParameter("statusFilter")) ? "selected" : "" %>>All Statuses</option>
                                    <option value="BOOKED" <%= "BOOKED".equals(request.getParameter("statusFilter")) ? "selected" : "" %>>Booked</option>
                                    <option value="TRANSIT" <%= "TRANSIT".equals(request.getParameter("statusFilter")) ? "selected" : "" %>>In Transit</option>
                                    <option value="DELIVERED" <%= "DELIVERED".equals(request.getParameter("statusFilter")) ? "selected" : "" %>>Delivered</option>
                                </select>
                            </div>
                        </div>
                        <div class="text-end border-top border-secondary pt-3">
                            <button type="submit" class="btn btn-primary px-4 fw-medium" id="generateBtn">
                                <i class="bi bi-file-earmark-bar-graph me-2"></i>Generate Report
                            </button>
                        </div>
                    </form>
                </div>

                <div id="reportResults" class="<%= reportList != null ? "" : "d-none" %>">
                    
                    <div class="row g-4 mb-4">
                        <div class="col-12 col-md-4">
                            <div class="admin-card p-4 text-center h-100">
                                <h4 class="text-uppercase fs-6 fw-bold mb-2">Total Shipments</h4>
                                <div class="stat-value" id="kpiTotal"><%= request.getAttribute("totalCount") != null ? request.getAttribute("totalCount") : "0" %></div>
                            </div>
                        </div>
                        <div class="col-12 col-md-4">
                            <div class="admin-card p-4 text-center h-100 border-success border-opacity-50">
                                <h4 class="text-uppercase fs-6 fw-bold mb-2">Delivered</h4>
                                <div class="stat-value text-success" id="kpiDelivered"><%= request.getAttribute("deliveredCount") != null ? request.getAttribute("deliveredCount") : "0" %></div>
                            </div>
                        </div>
                        <div class="col-12 col-md-4">
                            <div class="admin-card p-4 text-center h-100 border-warning border-opacity-50">
                                <h4 class="text-uppercase fs-6 fw-bold mb-2">Pending / Transit</h4>
                                <div class="stat-value text-warning" id="kpiPending"><%= request.getAttribute("pendingCount") != null ? request.getAttribute("pendingCount") : "0" %></div>
                            </div>
                        </div>
                    </div>

                    <div class="row g-4 mb-4">
                        <div class="col-12 col-md-6">
                            <div class="admin-card p-4 h-100">
                                <h4 class="text-light fs-6 fw-bold mb-3 text-center">Carrier Distribution</h4>
                                <div style="position: relative; height: 250px; width: 100%;">
                                    <canvas id="carrierChart"></canvas>
                                </div>
                            </div>
                        </div>
                        <div class="col-12 col-md-6">
                            <div class="admin-card p-4 h-100">
                                <h4 class="text-light fs-6 fw-bold mb-3 text-center">Shipment Statuses</h4>
                                <div style="position: relative; height: 250px; width: 100%;">
                                    <canvas id="statusChart"></canvas>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="admin-card">
                        <div class="p-4 border-bottom border-secondary d-flex justify-content-between align-items-center flex-wrap gap-3">
                            <h3 class="m-0 text-light fs-5 fw-semibold">Shipment Data</h3>
                            <button type="button" class="btn btn-success btn-sm px-3 fw-medium" onclick="exportToCSV()">
                                <i class="bi bi-file-earmark-excel-fill me-1"></i> Export CSV
                            </button>
                        </div>
                        <div class="table-responsive">
                            <table class="table table-custom table-hover align-middle" id="reportTable">
                                <thead>
                                    <tr>
                                        <th scope="col">Tracking #</th>
                                        <th scope="col">Carrier</th>
                                        <th scope="col">Sender</th>
                                        <th scope="col">Destination</th>
                                        <th scope="col">Status</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        if (reportList != null && !reportList.isEmpty()) {
                                            for (Shipment s : reportList) {
                                                String carrierName = "Unknown";
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
                                        <td>
                                            <span class="d-inline-flex align-items-center gap-1">
                                                <i class="bi bi-truck <%= iconColor %>"></i> <%= carrierName %>
                                            </span>
                                        </td>
                                        <td><%= s.getSenderName() %></td>
                                        <td><%= s.getReceiverAddress() %></td>
                                        <td><span class="badge-custom <%= badgeClass %>"><%= s.getStatus() %></span></td>
                                    </tr>
                                    <%      }
                                        } else if (reportList != null) { 
                                    %>
                                    <tr>
                                        <td colspan="5" class="text-center py-4">No shipments found matching filters.</td>
                                    </tr>
                                    <% } %>
                                </tbody>
                            </table>
                        </div>
                    </div>

                </div>

            </main>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.getElementById('reportFilters').addEventListener('submit', function() {
            const btn = document.getElementById('generateBtn');
            btn.innerHTML = '<span class="spinner-border spinner-border-sm me-2" aria-hidden="true"></span>Processing...';
            btn.classList.add('disabled');
        });

        function exportToCSV() {
            let csvContent = "data:text/csv;charset=utf-8,";
            csvContent += "Tracking Number,Carrier,Sender,Destination,Status\n";
            
            let rows = document.querySelectorAll("#reportTable tbody tr");
            
            rows.forEach(function(row) {
                let cols = row.querySelectorAll("td");
                if(cols.length > 0 && cols[0].innerText !== "No shipments found matching filters.") {
                    let data = Array.from(cols).map(c => '"' + c.innerText.trim() + '"').join(",");
                    csvContent += data + "\n";
                }
            });

            var encodedUri = encodeURI(csvContent);
            var link = document.createElement("a");
            link.setAttribute("href", encodedUri);
            link.setAttribute("download", "swiftship_report_" + new Date().getTime() + ".csv");
            document.body.appendChild(link);

            link.click();
            document.body.removeChild(link);
        }

        <% if (request.getAttribute("reportList") != null) { %>
            const carrierCtx = document.getElementById('carrierChart').getContext('2d');
            new Chart(carrierCtx, {
                type: 'pie',
                data: {
                    labels: ['DHL Express', 'Pos Laju', 'J&T Express'],
                    datasets: [{
                        data: <%= request.getAttribute("carrierData") != null ? request.getAttribute("carrierData") : "[0,0,0]" %>,
                        backgroundColor: ['#f59e0b', '#ef4444', '#dc2626'],
                        borderWidth: 0
                    }]
                },
                options: { 
                    responsive: true, 
                    maintainAspectRatio: false, 
                    plugins: { legend: { labels: { color: '#9ca3af' } } } 
                }
            });

            const statusCtx = document.getElementById('statusChart').getContext('2d');
            new Chart(statusCtx, {
                type: 'doughnut',
                data: {
                    labels: ['Booked', 'In Transit', 'Delivered'],
                    datasets: [{
                        data: <%= request.getAttribute("statusData") != null ? request.getAttribute("statusData") : "[0,0,0]" %>,
                        backgroundColor: ['#3b82f6', '#f59e0b', '#10b981'],
                        borderWidth: 0
                    }]
                },
                options: { 
                    responsive: true, 
                    maintainAspectRatio: false, 
                    plugins: { legend: { labels: { color: '#9ca3af' } } } 
                }
            });
        <% } %>
    </script>
</body>
</html>