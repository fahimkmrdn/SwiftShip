<%@ page import="com.swiftship.model.User" %>
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
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SwiftShip Admin - Manage Users</title>
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
                <a href="<%=request.getContextPath()%>/UpdateStatusServlet?action=list" class="nav-item-link">
                    <i class="bi bi-arrow-repeat"></i> UPDATE STATUS
                </a>
                <a href="<%=request.getContextPath()%>/admin/admin_compare.jsp" class="nav-item-link">
                    <i class="bi bi-calculator-fill"></i> COMPARE RATES
                </a>
                <a href="<%=request.getContextPath()%>/ReportServlet" class="nav-item-link">
                    <i class="bi bi-bar-chart-fill"></i> REPORTS
                </a>
                <a href="<%=request.getContextPath()%>/UserManagementServlet" class="nav-item-link active">
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
                    <h2 class="text-light m-0 fs-4 fw-semibold">User Management</h2>
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

                <% if ("added".equals(request.getParameter("msg"))) { %>
                    <div class="alert alert-success alert-dismissible fade show shadow-sm" role="alert">
                        <i class="bi bi-check-circle-fill me-2"></i> Staff member successfully added.
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                <% } else if ("status_updated".equals(request.getParameter("msg"))) { %>
                    <div class="alert alert-info alert-dismissible fade show shadow-sm" role="alert">
                        <i class="bi bi-info-circle-fill me-2"></i> User account status updated.
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                <% } else if ("add_failed".equals(request.getParameter("error"))) { %>
                    <div class="alert alert-danger alert-dismissible fade show shadow-sm" role="alert">
                        <i class="bi bi-exclamation-triangle-fill me-2"></i> Failed to add user. Username or email may already exist.
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                <% } %>

                <div class="admin-card">
                    <div class="p-4 border-bottom border-secondary d-flex justify-content-between align-items-center flex-wrap gap-3">
                        <h3 class="m-0 text-light fs-5 fw-semibold">System Users</h3>
                        <button type="button" class="btn btn-primary px-3 fw-medium" data-bs-toggle="modal" data-bs-target="#addUserModal">
                            <i class="bi bi-person-plus-fill me-1"></i> Add New Staff
                        </button>
                    </div>
                    <div class="table-responsive">
                        <table class="table table-custom table-hover align-middle">
                            <thead>
                                <tr>
                                    <th scope="col">Name</th>
                                    <th scope="col">Username</th>
                                    <th scope="col">Role</th>
                                    <th scope="col">Contact Details</th>
                                    <th scope="col">Status</th>
                                    <th scope="col">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    List<User> userList = (List<User>) request.getAttribute("userList");
                                    if (userList != null && !userList.isEmpty()) {
                                        for (User u : userList) {
                                            boolean isActive = "Active".equalsIgnoreCase(u.getStatus());
                                %>
                                <tr>
                                    <td><strong class="text-light"><%= u.getName() %></strong></td>
                                    <td><%= u.getUsername() %></td>
                                    <td>
                                        <span class="badge <%= "Admin".equalsIgnoreCase(u.getRole()) ? "bg-primary" : "bg-secondary" %>">
                                            <%= u.getRole() %>
                                        </span>
                                    </td>
                                    <td>
                                        <div class="small"><i class="bi bi-envelope me-1"></i> <%= u.getEmail() %></div>
                                        <div class="small"><i class="bi bi-telephone me-1"></i> <%= u.getPhone() != null ? u.getPhone() : "N/A" %></div>
                                    </td>
                                    <td>
                                        <span class="badge-custom <%= isActive ? "bg-delivered" : "bg-danger text-light" %>">
                                            <%= u.getStatus() %>
                                        </span>
                                    </td>
                                    <td>
                                        <% if ("Admin".equalsIgnoreCase(u.getRole())) { %>
                                            <button class="btn btn-sm btn-outline-secondary disabled" title="Cannot deactivate Master Admin">Protected</button>
                                        <% } else { %>
                                            <form action="<%=request.getContextPath()%>/UserManagementServlet" method="POST" class="d-inline">
                                                <input type="hidden" name="action" value="toggle">
                                                <input type="hidden" name="userId" value="<%= u.getUserId() %>">
                                                <input type="hidden" name="currentStatus" value="<%= u.getStatus() %>">
                                                <button type="submit" class="btn btn-sm <%= isActive ? "btn-outline-danger" : "btn-outline-success" %>">
                                                    <%= isActive ? "Deactivate" : "Activate" %>
                                                </button>
                                            </form>
                                        <% } %>
                                    </td>
                                </tr>
                                <%      }
                                    } else {
                                %>
                                <tr>
                                    <td colspan="6" class="text-center py-4">No users found.</td>
                                </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                </div>

            </main>
        </div>
    </div>

    <div class="modal fade" id="addUserModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog">
            <form action="<%=request.getContextPath()%>/UserManagementServlet" method="POST" class="modal-content bg-dark text-light border-secondary shadow-lg">
                <div class="modal-header border-secondary">
                    <h5 class="modal-title fw-bold"><i class="bi bi-person-plus-fill me-2 text-primary"></i>Register New Staff</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body p-4">
                    <input type="hidden" name="action" value="add">
                    
                    <div class="mb-3">
                        <label class="form-label small fw-medium">Full Name</label>
                        <input type="text" class="form-control form-custom" name="name" required>
                    </div>
                    <div class="row g-3 mb-3">
                        <div class="col-md-6">
                            <label class="form-label small fw-medium">Username</label>
                            <input type="text" class="form-control form-custom" name="username" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label small fw-medium">Password</label>
                            <input type="password" class="form-control form-custom" name="password" required>
                        </div>
                    </div>
                    <div class="row g-3 mb-2">
                        <div class="col-md-6">
                            <label class="form-label small fw-medium">Email Address</label>
                            <input type="email" class="form-control form-custom" name="email" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label small fw-medium">Phone Number</label>
                            <input type="tel" class="form-control form-custom" name="phone">
                        </div>
                    </div>
                    <div class="mt-3 small">
                        <i class="bi bi-info-circle me-1"></i> New accounts are created with standard <strong>Staff</strong> permissions by default.
                    </div>
                </div>
                <div class="modal-footer border-secondary">
                    <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary fw-medium">Create Account</button>
                </div>
            </form>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>