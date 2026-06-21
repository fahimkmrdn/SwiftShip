<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SwiftShip Admin - Compare Rates</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link rel="stylesheet" href="style.css">
</head>
<body>

    <div class="d-flex min-vh-100">
        
        <aside class="sidebar d-none d-lg-flex flex-column flex-shrink-0">
            <div class="brand-header p-4 border-bottom border-secondary">
                <h1 class="m-0"><i class="bi bi-box-seam-fill text-primary me-2"></i>SwiftShip</h1>
                <p class="text-muted small m-0 mt-1">Admin Portal</p>
            </div>
            <nav class="nav flex-column flex-grow-1 py-3 overflow-auto">
                <a href="admin_dashboard.html" class="nav-item-link">
                    <i class="bi bi-grid-1x2-fill"></i> DASHBOARD HOME
                </a>
                <a href="admin_register.html" class="nav-item-link">
                    <i class="bi bi-pencil-square"></i> REGISTER SHIPMENT
                </a>
                <a href="admin_update.html" class="nav-item-link">
                    <i class="bi bi-arrow-repeat"></i> UPDATE STATUS
                </a>
                <a href="admin_compare.html" class="nav-item-link active">
                    <i class="bi bi-calculator-fill"></i> COMPARE RATES
                </a>
                <a href="admin_reports.html" class="nav-item-link">
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
                    <h2 class="text-light m-0 fs-4 fw-semibold">Compare Carrier Rates</h2>
                </div>
                
                <div class="d-flex align-items-center gap-4">
                    <div class="d-none d-md-flex align-items-center gap-2 text-light">
                        <i class="bi bi-person-circle fs-4 text-secondary"></i>
                        <span class="fw-medium">Admin User (Staff)</span>
                    </div>
                    <a href="admin_login.html" class="btn btn-outline-danger btn-sm px-3 fw-medium">
                        <i class="bi bi-box-arrow-right me-1"></i> Logout
                    </a>
                </div>
            </header>

            <main class="p-4 flex-grow-1 overflow-auto">
                
                <div class="admin-card p-4 p-md-5 mx-auto" style="max-width: 1000px;">
                    <div class="mb-4 border-bottom border-secondary pb-3">
                        <h3 class="m-0 text-light fs-4 fw-semibold">Rate Calculator</h3>
                        <p class="text-muted m-0 mt-1">Enter the origin, destination, and parcel weight to fetch estimated shipping costs.</p>
                    </div>

                    <div class="alert alert-danger d-none align-items-center mb-4" id="errorAlert" role="alert">
                        <i class="bi bi-exclamation-triangle-fill me-2 fs-5"></i>
                        <span id="errorText"></span>
                    </div>

                    <form id="compareRatesForm" onsubmit="handleCompare(event)">
                        <div class="row g-4 mb-4">
                            <div class="col-md-6">
                                <label for="originInput" class="form-label text-muted small fw-medium">Origin Postcode / City</label>
                                <input type="text" class="form-control form-control-lg form-custom" id="originInput" required>
                            </div>
                            <div class="col-md-6">
                                <label for="destInput" class="form-label text-muted small fw-medium">Destination Postcode / City</label>
                                <input type="text" class="form-control form-control-lg form-custom" id="destInput" required>
                            </div>
                            <div class="col-12">
                                <label for="weightInput" class="form-label text-muted small fw-medium">Parcel Weight (kg)</label>
                                <input type="number" class="form-control form-control-lg form-custom" id="weightInput" step="0.1" required>
                            </div>
                        </div>

                        <div class="d-flex justify-content-end border-top border-secondary pt-3">
                            <button type="submit" class="btn btn-primary px-4 fw-medium">
                                <i class="bi bi-calculator me-2"></i>Calculate & Compare
                            </button>
                        </div>
                    </form>

                    <div id="resultsWrapper" class="d-none mt-5 pt-4 border-top border-secondary">
                        <h4 class="text-center text-light mb-4 fs-4 fw-semibold">Estimated Rates Overview</h4>
                        
                        <div class="row g-4">
                            
                            <div class="col-12 col-md-4">
                                <div class="card h-100 bg-dark border-success position-relative" style="box-shadow: 0 0 15px rgba(16, 185, 129, 0.1);">
                                    <span class="position-absolute top-0 start-50 translate-middle badge rounded-pill bg-success px-3 py-2 text-uppercase tracking-wide shadow">
                                        Best Value
                                    </span>
                                    <div class="card-body text-center p-4 mt-3">
                                        <h5 class="text-muted fw-semibold mb-3">Pos Laju</h5>
                                        <div class="text-light fw-bold display-5 mb-2">
                                            <span class="fs-4 text-muted align-top">RM</span> <span id="posLajuRate">0.00</span>
                                        </div>
                                        <p class="text-muted small mb-0"><i class="bi bi-clock me-1"></i> Est. Delivery: 2-3 Days</p>
                                    </div>
                                </div>
                            </div>

                            <div class="col-12 col-md-4">
                                <div class="card h-100 bg-dark border-secondary border-opacity-50">
                                    <div class="card-body text-center p-4">
                                        <h5 class="text-muted fw-semibold mb-3">J&T Express</h5>
                                        <div class="text-light fw-bold display-5 mb-2">
                                            <span class="fs-4 text-muted align-top">RM</span> <span id="jntRate">0.00</span>
                                        </div>
                                        <p class="text-muted small mb-0"><i class="bi bi-clock me-1"></i> Est. Delivery: 1-2 Days</p>
                                    </div>
                                </div>
                            </div>

                            <div class="col-12 col-md-4">
                                <div class="card h-100 bg-dark border-secondary border-opacity-50">
                                    <div class="card-body text-center p-4">
                                        <h5 class="text-muted fw-semibold mb-3">DHL Express</h5>
                                        <div class="text-light fw-bold display-5 mb-2">
                                            <span class="fs-4 text-muted align-top">RM</span> <span id="dhlRate">0.00</span>
                                        </div>
                                        <p class="text-muted small mb-0"><i class="bi bi-clock me-1"></i> Est. Delivery: Next Day</p>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>

                </div>

            </main>
        </div>
    </div>

    <!-- Bootstrap 5 JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function handleCompare(event) {
            event.preventDefault(); 
            
            const errorAlert = document.getElementById('errorAlert');
            const resultsWrapper = document.getElementById('resultsWrapper');
            const errorText = document.getElementById('errorText');
            
            // Hide previous alerts & results
            errorAlert.classList.add('d-none');
            errorAlert.classList.remove('d-flex');
            resultsWrapper.classList.add('d-none');

            const weightInput = parseFloat(document.getElementById('weightInput').value);

            // Validation
            if (isNaN(weightInput) || weightInput <= 0) {
                errorText.innerText = "Please enter a valid weight greater than 0 kg.";
                errorAlert.classList.remove('d-none');
                errorAlert.classList.add('d-flex');
                return;
            }

            // Calculation Logic
            const baseRatePosLaju = 7.50;
            const baseRateJnt = 8.50;
            const baseRateDHL = 15.00;

            const calcPosLaju = (5.00 + (baseRatePosLaju * weightInput)).toFixed(2);
            const calcJnt = (6.00 + (baseRateJnt * weightInput)).toFixed(2);
            const calcDHL = (10.00 + (baseRateDHL * weightInput)).toFixed(2);

            // Update DOM
            document.getElementById('posLajuRate').innerText = calcPosLaju;
            document.getElementById('jntRate').innerText = calcJnt;
            document.getElementById('dhlRate').innerText = calcDHL;

            // Show results & scroll smoothly
            resultsWrapper.classList.remove('d-none');
            
            document.querySelector('.flex-grow-1.overflow-auto').scrollTo({ 
                top: resultsWrapper.offsetTop, 
                behavior: 'smooth' 
            });
        }
    </script>
</body>
</html>