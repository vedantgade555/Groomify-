<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <%@ include file="header.jsp" %>

            <style>
                /* ----- GLOBAL & KEYFRAMES ----- */
                @keyframes fadeIn {
                    0% {
                        opacity: 0;
                    }

                    100% {
                        opacity: 1;
                    }
                }

                @keyframes fadeUp {
                    0% {
                        opacity: 0;
                        transform: translateY(30px);
                    }

                    100% {
                        opacity: 1;
                        transform: translateY(0);
                    }
                }

                @keyframes float {
                    0% {
                        transform: translateY(0);
                    }

                    50% {
                        transform: translateY(-10px);
                    }

                    100% {
                        transform: translateY(0);
                    }
                }

                .fade-in {
                    animation: fadeIn 1.2s cubic-bezier(0.23, 1, 0.32, 1) forwards;
                }

                .fade-up {
                    opacity: 0;
                    animation: fadeUp 0.9s cubic-bezier(0.23, 1, 0.32, 1) forwards;
                }

                .delay-1 {
                    animation-delay: 0.2s;
                }

                .delay-2 {
                    animation-delay: 0.4s;
                }

                .delay-3 {
                    animation-delay: 0.6s;
                }

                .delay-4 {
                    animation-delay: 0.8s;
                }

                /* ----- BODY ----- */
                body {
                    background: linear-gradient(135deg, rgba(0, 0, 0, 0.7), rgba(0, 0, 0, 0.5)),
                        url('https://images.unsplash.com/photo-1560066984-138dadb4c035?ixlib=rb-4.0.3&auto=format&fit=crop&w=2070&q=80');
                    background-size: cover;
                    background-position: center;
                    background-attachment: fixed;
                    font-family: 'Inter', sans-serif;
                }

                /* ----- LEFT PANEL ----- */
                .welcome-panel {
                    background: linear-gradient(145deg, rgba(10, 10, 20, 0.85), rgba(20, 20, 30, 0.9)),
                        url('https://images.unsplash.com/photo-1585747860715-2ba37f78886c?ixlib=rb-4.0.3&auto=format&fit=crop&w=2074&q=80');
                    background-size: cover;
                    background-position: center;
                    border-radius: 32px;
                    padding: 3rem 2rem;
                    height: 100%;
                    min-height: 550px;
                    display: flex;
                    flex-direction: column;
                    justify-content: center;
                    color: white;
                    border: 1px solid rgba(255, 255, 255, 0.1);
                    box-shadow: 0 20px 35px rgba(0, 0, 0, 0.3);
                    transition: transform 0.4s, box-shadow 0.4s;
                }

                .welcome-panel:hover {
                    transform: scale(1.02);
                    box-shadow: 0 30px 50px rgba(0, 0, 0, 0.4);
                }

                .welcome-panel h1 {
                    font-size: 3rem;
                    font-weight: 800;
                    text-shadow: 0 5px 20px rgba(0, 0, 0, 0.5);
                    animation: float 6s infinite ease-in-out;
                }

                .welcome-panel .gold-text {
                    color: #d4af37;
                    text-shadow: 0 0 10px rgba(212, 175, 55, 0.5);
                }

                /* ----- RIGHT PANEL ----- */
                .login-card {
                    background: rgba(255, 255, 255, 0.95);
                    backdrop-filter: blur(10px);
                    border-radius: 32px;
                    border: none;
                    box-shadow: 0 25px 40px rgba(0, 0, 0, 0.15);
                    transition: all 0.3s ease;
                    overflow: hidden;
                }

                .login-card:hover {
                    box-shadow: 0 35px 60px rgba(212, 175, 55, 0.15);
                    transform: translateY(-8px);
                }

                .login-header {
                    background: linear-gradient(145deg, #1e1e1e, #2c2c2c);
                    padding: 2rem 1.5rem;
                    border-bottom: 4px solid #d4af37;
                    position: relative;
                }

                .login-header::after {
                    content: '';
                    position: absolute;
                    bottom: -2px;
                    left: 0;
                    width: 100%;
                    height: 2px;
                    background: linear-gradient(90deg, #d4af37, transparent);
                }

                .login-header h2 {
                    font-weight: 700;
                    background: linear-gradient(145deg, #fff, #e0e0e0);
                    -webkit-background-clip: text;
                    -webkit-text-fill-color: transparent;
                    letter-spacing: 1px;
                }

                /* ----- FORM FIELDS ----- */
                .form-floating>label {
                    color: #6c757d;
                    font-weight: 500;
                    padding-left: 1.2rem;
                }

                .form-floating>.form-control {
                    border-radius: 50px !important;
                    border: 2px solid #e9ecef;
                    padding: 1.2rem;
                    height: calc(3.8rem + 2px);
                    background: white;
                    transition: all 0.2s;
                    font-weight: 500;
                }

                .form-floating>.form-control:focus {
                    border-color: #d4af37;
                    box-shadow: 0 0 0 0.25rem rgba(212, 175, 55, 0.25);
                    transform: scale(1.01);
                }

                /* ----- BUTTON ----- */
                .btn-gradient {
                    background: linear-gradient(145deg, #d4af37, #b8942e);
                    border: none;
                    color: black;
                    font-weight: 700;
                    padding: 14px 28px;
                    border-radius: 50px;
                    letter-spacing: 1px;
                    transition: all 0.3s ease;
                    box-shadow: 0 8px 20px rgba(212, 175, 55, 0.3);
                    position: relative;
                    overflow: hidden;
                }

                .btn-gradient::before {
                    content: '';
                    position: absolute;
                    top: 0;
                    left: -100%;
                    width: 100%;
                    height: 100%;
                    background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.4), transparent);
                    transition: left 0.5s;
                }

                .btn-gradient:hover {
                    background: linear-gradient(145deg, #e6c468, #c9a341);
                    transform: scale(1.05);
                    box-shadow: 0 15px 30px rgba(212, 175, 55, 0.5);
                }

                .btn-gradient:hover::before {
                    left: 100%;
                }

                /* ----- ERROR ALERT ----- */
                .alert-custom {
                    background: rgba(220, 53, 69, 0.1);
                    border: 2px solid #dc3545;
                    border-radius: 50px;
                    color: #dc3545;
                    font-weight: 600;
                    backdrop-filter: blur(4px);
                }

                /* ----- RESPONSIVE ----- */
                @media(max-width:768px) {
                    .welcome-panel {
                        min-height: 300px;
                        margin-bottom: 20px;
                    }

                    .welcome-panel h1 {
                        font-size: 2.5rem;
                    }
                }
            </style>

            <div class="container-fluid py-5 px-4">
                <div class="row justify-content-center align-items-stretch g-5">
                    <div class="col-lg-6 d-flex fade-up delay-1">
                        <div class="welcome-panel w-100">
                            <div class="mb-4"><span class="badge bg-dark bg-opacity-50 px-4 py-2 rounded-pill fs-6"><i
                                        class="fas fa-crown me-2" style="color:#d4af37;"></i>Admin Portal</span></div>
                            <h1 class="display-3 fw-bold">Groomify</h1>
                            <p class="lead fs-3 mt-3" style="font-weight:500;">Welcome back,<br>Manager.</p>
                            <div class="mt-4 d-flex align-items-center">
                                <div class="vr bg-white opacity-50 me-3" style="width:4px;height:50px;"></div>
                                <p class="mb-0 fs-5 fw-light opacity-75">Your dashboard is waiting.<br>Securely manage
                                    appointments, staff &amp; services.</p>
                            </div>
                            <div class="mt-5">
                                <img src="img/user-female-2.jpg"
                                    class="rounded-circle border border-3 border-white me-2" width="50" height="50">
                                <img src="img/user-male-1.jpg" class="rounded-circle border border-3 border-white me-2"
                                    width="50" height="50">
                                <img src="img/user-female-1.jpg" class="rounded-circle border border-3 border-white"
                                    width="50" height="50">
                                <span class="ms-3 text-white-50">+4 admins online</span>
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-6 d-flex fade-up delay-2">
                        <div class="login-card w-100">
                            <div class="login-header text-center">
                                <i class="fas fa-lock fa-2x mb-3" style="color:#d4af37;"></i>
                                <h2 class="h3 mb-0">Admin Login</h2>
                                <p class="text-white-50 mb-0 mt-2">Enter your credentials to access the dashboard</p>
                            </div>
                            <div class="card-body p-4 p-xl-5">
                                <c:if test="${not empty errorMessage}">
                                    <div class="alert alert-custom d-flex align-items-center mb-4 fade-up" role="alert">
                                        <i class="fas fa-exclamation-triangle me-2 fs-5"></i> ${errorMessage}
                                    </div>
                                </c:if>
                                <form action="AdminServlet" method="post">
                                    <input type="hidden" name="action" value="login">
                                    <div class="form-floating mb-4 fade-up delay-2">
                                        <input class="form-control" type="text" id="username" name="username"
                                            placeholder="Username" required autofocus>
                                        <label for="username"><i
                                                class="fas fa-user me-2 text-secondary"></i>Username</label>
                                    </div>
                                    <div class="form-floating mb-4 fade-up delay-3">
                                        <input class="form-control" type="password" id="password" name="password"
                                            placeholder="Password" required>
                                        <label for="password"><i
                                                class="fas fa-key me-2 text-secondary"></i>Password</label>
                                    </div>
                                    <div class="d-flex justify-content-between align-items-center mb-4 fade-up delay-4">
                                        <div class="form-check">
                                            <input class="form-check-input" type="checkbox" id="rememberMe">
                                            <label class="form-check-label text-muted" for="rememberMe">Remember
                                                me</label>
                                        </div>
                                        <a href="#" class="text-decoration-none small" style="color:#d4af37;">Forgot
                                            password?</a>
                                    </div>
                                    <div class="d-grid gap-2 mt-4 fade-up delay-4">
                                        <button class="btn btn-gradient btn-lg" type="submit"><i
                                                class="fas fa-sign-in-alt me-2"></i>Login to Dashboard</button>
                                    </div>
                                    <p class="text-center text-muted small mt-4 mb-0 fade-up delay-4"><i
                                            class="fas fa-shield-alt me-1"></i>Secured with 256-bit encryption</p>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <%@ include file="footer.jsp" %>