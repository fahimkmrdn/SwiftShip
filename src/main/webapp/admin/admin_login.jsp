<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SwiftShip Admin - Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link rel="stylesheet" href="style.css">
</head>
<body class="d-flex align-items-center justify-content-center min-vh-100">

    <div class="w-100 px-3" style="max-width: 450px;">
        <div class="admin-card p-4 p-md-5 text-center shadow-lg border-secondary">
            
            <div class="mb-4">
                <h1 class="text-light fw-bold mb-1 fs-2">
                    <i class="bi bi-box-seam-fill text-primary me-2"></i>SwiftShip
                </h1>
                <p class="">Admin Portal Login</p>
            </div>

            <% 
                String errorMsg = request.getParameter("error");
                if ("invalid_credentials".equals(errorMsg)) {
            %>
            <div class="alert alert-danger d-flex align-items-center text-start mb-4 border-danger border-opacity-50" role="alert">
                <i class="bi bi-exclamation-octagon-fill me-2 fs-5"></i>
                <div>Invalid credentials. Please try again.</div>
            </div>
            <% } %>

            <form action="<%=request.getContextPath()%>/LoginServlet" method="POST" class="text-start">
                <div class="mb-3">
                    <label for="username" class="form-label small fw-medium">Username</label>
                    <input type="text" class="form-control form-control-lg form-custom bg-dark text-light border-secondary" id="username" name="username" placeholder="Enter admin username" required>
                </div>
                
                <div class="mb-4">
                    <label for="password" class="form-label small fw-medium">Password</label>
                    <input type="password" class="form-control form-control-lg form-custom bg-dark text-light border-secondary" id="password" name="password" placeholder="••••••••" required>
                </div>

                <button type="submit" class="btn btn-primary w-100 py-2 fw-medium fs-6" id="loginBtn">
                    <i class="bi bi-box-arrow-in-right me-2"></i>Login
                </button>
            </form>

            <div class="mt-4 pt-3 border-top border-secondary">
                <a href="../index.jsp" class="text-decoration-none small hover-primary" style="transition: color 0.2s;">
                    <i class="bi bi-arrow-left me-1"></i> Back to Public Tracking Site
                </a>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>