<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SwiftShip - Track Your Parcel</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link rel="stylesheet" href="style.css">
    
    <script src="<%=request.getContextPath()%>/theme.js"></script>
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
                        <a class="nav-link active fw-medium" aria-current="page" href="index.jsp">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="rate_comparison.html">Rate Comparison</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="about_us.jsp">About Us</a>
                    </li>
                </ul>
                <div class="d-flex align-items-center gap-4">
                    <a href="admin/admin_login.jsp" class="btn btn-outline-light px-4 rounded-pill">Admin Login</a>
                    <button class="btn btn-outline-light rounded-circle d-flex align-items-center justify-content-center p-2" onclick="toggleTheme()" title="Toggle Light/Dark Mode" style="width: 35px; height: 35px;">
                        <i class="bi theme-icon-toggle fs-5"></i>
                    </button>
                </div>
                	
            </div>
        </div>
    </nav>

    <main class="flex-grow-1 d-flex align-items-center justify-content-center py-5">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-12 col-md-10 col-lg-8 col-xl-6">
                    <div class="card shadow border-0 rounded-4 p-4 p-md-5">
                        <div class="card-body text-center">
                            <h1 class="text-brand fw-bold mb-3">Track Your Shipment</h1>
                            <p class="text-muted mb-4">Enter your tracking number below to see the current status of your parcel.</p>
                            
                            <% if ("not_found".equals(request.getParameter("error"))) { %>
                                <div class="alert alert-danger mt-2 fw-medium text-start" role="alert">
                                    <i class="bi bi-exclamation-circle me-1"></i> We couldn't find a shipment with that tracking number. Please check and try again.
                                </div>
                            <% } %>

                            <form action="<%=request.getContextPath()%>/TrackingServlet" method="GET">
                                <div class="input-group input-group-lg mb-3">
                                    <input type="text" class="form-control bg-light" name="trackingNumber" id="trackingInput" placeholder="e.g., DHL123456789" required aria-label="Tracking Number">
                                    <button class="btn btn-brand px-4 fw-medium" type="submit">Track Parcel</button>
                                </div>
                            </form>
                        </div>
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