<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.swiftship.model.Shipment" %>
<%@ page import="com.swiftship.model.StatusHistory" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
    Shipment shipment = (Shipment) request.getAttribute("shipment");
    List<StatusHistory> historyList = (List<StatusHistory>) request.getAttribute("history");
    
    if (shipment == null) {
        response.sendRedirect("index.jsp");
        return;
    }

    String carrierName = "Unknown Carrier";
    if (shipment.getCarrierId() == 1) carrierName = "DHL Express";
    else if (shipment.getCarrierId() == 2) carrierName = "Pos Laju";
    else if (shipment.getCarrierId() == 5) carrierName = "J&T Express";

    SimpleDateFormat sdf = new SimpleDateFormat("dd MMM, yyyy - hh:mm a");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SwiftShip - Tracking Results</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link rel="stylesheet" href="style.css">
</head>
<body class="d-flex flex-column min-vh-100">

    <nav class="navbar navbar-expand-lg navbar-dark bg-brand shadow-sm sticky-top">
        <div class="container">
            <a class="navbar-brand fw-bold fs-4" href="index.jsp">SwiftShip</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    <li class="nav-item">
                        <a class="nav-link" href="index.jsp">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="rate_comparison.html">Rate Comparison</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="about_us.html">About Us</a>
                    </li>
                </ul>
                <div class="d-flex">
                    <a href="admin/admin_login.jsp" class="btn btn-outline-light px-4 rounded-pill">Admin Login</a>
                </div>
            </div>
        </div>
    </nav>

    <main class="flex-grow-1 py-5">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-12 col-lg-10 col-xl-8">
                    
                    <div class="d-flex justify-content-between align-items-center mb-4 pb-3 border-bottom">
                        <h1 class="text-brand fw-bold m-0 fs-2">Tracking Results</h1>
                        <span class="badge bg-brand fs-5 rounded-pill px-4 py-2 shadow-sm"><%= shipment.getTrackingNumber() %></span>
                    </div>

                    <div class="card shadow-sm border-0 bg-light mb-5 rounded-4">
                        <div class="card-body p-4">
                            <div class="row text-center text-md-start g-3">
                                <div class="col-12 col-md-4 border-md-end border-secondary-subtle">
                                    <span class="text-muted text-uppercase fw-semibold" style="letter-spacing: 1px; font-size: 0.8rem;">Carrier</span>
                                    <div class="fs-5 fw-bold text-dark mt-1"><i class="bi bi-truck me-2 text-brand"></i><%= carrierName %></div>
                                </div>
                                <div class="col-12 col-md-4 border-md-end border-secondary-subtle">
                                    <span class="text-muted text-uppercase fw-semibold" style="letter-spacing: 1px; font-size: 0.8rem;">Current Status</span>
                                    <div class="fs-5 fw-bold mt-1" style="color: #e67e22;"><i class="bi bi-arrow-repeat me-2"></i><%= shipment.getStatus() %></div>
                                </div>
                                <div class="col-12 col-md-4">
                                    <span class="text-muted text-uppercase fw-semibold" style="letter-spacing: 1px; font-size: 0.8rem;">Destination</span>
                                    <div class="fs-5 fw-bold text-dark mt-1"><i class="bi bi-geo-alt-fill me-2 text-brand"></i><%= shipment.getReceiverAddress() %></div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="timeline-container bg-white p-4 p-md-5 rounded-4 shadow-sm border-0">
                        <h3 class="fw-bold text-brand mb-4">Tracking History</h3>
                        
                        <div class="timeline">
                            <% 
                                if (historyList != null && !historyList.isEmpty()) {
                                    for (StatusHistory h : historyList) { 
                                        String icon = "bi-arrow-right-circle";
                                        if ("Booked".equals(h.getStatus())) icon = "bi-file-earmark-text";
                                        else if ("Picked Up".equals(h.getStatus())) icon = "bi-box-seam";
                                        else if ("Delivered".equals(h.getStatus())) icon = "bi-check-circle-fill";
                            %>
                            <div class="timeline-item completed">
                                <div class="timeline-date fw-medium"><%= sdf.format(h.getTimestamp()) %></div>
                                <div class="timeline-content bg-light border p-3 rounded-3 mt-2 shadow-sm">
                                    <strong class="fs-5 text-dark"><i class="bi <%= icon %> text-brand me-2"></i><%= h.getStatus() %></strong>
                                    <p class="text-muted mt-1 mb-0">Status updated by <%= h.getUpdatedBy() != null ? h.getUpdatedBy() : "System" %></p>
                                </div>
                            </div>
                            <% 
                                    } 
                                } else { 
                            %>
                            <div class="text-muted">No history found for this shipment.</div>
                            <% } %>
                        </div>
                    </div>

                    <div class="text-center mt-5">
                        <a href="index.jsp" class="btn btn-outline-secondary px-4 py-2 rounded-pill fw-medium shadow-sm">
                            <i class="bi bi-search me-2"></i>Track Another Shipment
                        </a>
                    </div>

                </div>
            </div>
        </div>
    </main>

    <button class="chatbot-btn" onclick="toggleChat()" title="Chat with AI Support">
        <i class="bi bi-chat-dots-fill"></i>
    </button>

    <div class="chatbot-window" id="chatWindow">
        <div class="chatbot-header">
            <span><i class="bi bi-robot me-2"></i>SwiftShip AI Assistant</span>
            <button class="btn-close btn-close-white" onclick="toggleChat()" aria-label="Close"></button>
        </div>
        <div class="chatbot-messages" id="chatMessages">
            <div class="message bot-message">Hello! I'm your SwiftShip logistics assistant. How can I help you track a parcel or calculate a rate today?</div>
        </div>
        <div class="chatbot-input-area">
            <input type="text" id="chatInput" placeholder="Ask about your parcel..." onkeypress="handleChatEnter(event)">
            <button onclick="sendChatMessage()" title="Send"><i class="bi bi-send-fill"></i></button>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function toggleChat() {
            const chatWindow = document.getElementById('chatWindow');
            if (chatWindow.style.display === "none" || chatWindow.style.display === "") {
                chatWindow.style.display = "flex";
                document.getElementById('chatInput').focus();
            } else {
                chatWindow.style.display = "none";
            }
        }

        function sendChatMessage() {
            const inputElement = document.getElementById('chatInput');
            const message = inputElement.value.trim();
            if (message === "") return;

            const chatMessages = document.getElementById('chatMessages');

            const userMsgDiv = document.createElement('div');
            userMsgDiv.className = 'message user-message';
            userMsgDiv.innerText = message;
            chatMessages.appendChild(userMsgDiv);

            inputElement.value = '';
            chatMessages.scrollTop = chatMessages.scrollHeight;
            
            setTimeout(() => {
                const botMsgDiv = document.createElement('div');
                botMsgDiv.className = 'message bot-message';
                botMsgDiv.innerText = "I'm currently running in prototype mode, but soon I will connect to the Gemini API to answer that!";
                chatMessages.appendChild(botMsgDiv);
                chatMessages.scrollTop = chatMessages.scrollHeight;
            }, 1000);
        }

        function handleChatEnter(event) {
            if (event.key === "Enter") {
                sendChatMessage();
            }
        }
    </script>
</body>
</html>