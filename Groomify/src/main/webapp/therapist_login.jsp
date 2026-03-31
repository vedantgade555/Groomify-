<%@ include file="header.jsp" %>

    <style>
        /* ----- KEYFRAMES ----- */
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
                transform: translateY(-8px);
            }

            100% {
                transform: translateY(0);
            }
        }

        @keyframes shimmer {
            0% {
                left: -100%;
            }

            100% {
                left: 100%;
            }
        }

        .fade-in {
            animation: fadeIn 1.2s ease forwards;
        }

        .fade-up {
            opacity: 0;
            animation: fadeUp 0.9s cubic-bezier(0.23, 1, 0.32, 1) forwards;
        }

        .delay-1 {
            animation-delay: 0.1s;
        }

        .delay-2 {
            animation-delay: 0.2s;
        }

        .delay-3 {
            animation-delay: 0.3s;
        }

        .delay-4 {
            animation-delay: 0.4s;
        }

        .delay-5 {
            animation-delay: 0.5s;
        }

        /* ----- GLOBAL STYLES ----- */
        body {
            background: linear-gradient(135deg, rgba(0, 0, 0, 0.7), rgba(0, 0, 0, 0.5)),
                url('https://images.unsplash.com/photo-1560066984-138dadb4c035?ixlib=rb-4.0.3&auto=format&fit=crop&w=2070&q=80');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            font-family: 'Inter', sans-serif;
        }

        /* ----- LEFT PANEL – WELCOME & BRANDING ----- */
        .welcome-panel {
            background: linear-gradient(145deg, rgba(10, 10, 20, 0.85), rgba(20, 20, 30, 0.9)),
                url('https://images.unsplash.com/photo-1585747860715-2ba37f78886c?ixlib=rb-4.0.3&auto=format&fit=crop&w=2074&q=80');
            background-size: cover;
            background-position: center;
            border-radius: 32px;
            padding: 3rem 2rem;
            height: 100%;
            min-height: 600px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            color: white;
            border: 1px solid rgba(255, 255, 255, 0.1);
            box-shadow: 0 25px 50px rgba(0, 0, 0, 0.3);
            transition: all 0.4s ease;
        }

        .welcome-panel:hover {
            transform: scale(1.02);
            box-shadow: 0 35px 70px rgba(0, 123, 255, 0.2);
            border-color: rgba(0, 123, 255, 0.3);
        }

        .welcome-panel h1 {
            font-size: 3.2rem;
            font-weight: 800;
            text-shadow: 0 10px 20px rgba(0, 0, 0, 0.5);
            animation: float 6s infinite ease-in-out;
        }

        .accent-text {
            color: #17a2b8;
            text-shadow: 0 0 15px rgba(23, 162, 184, 0.5);
        }

        /* ----- FEATURE BADGES (LEFT PANEL) ----- */
        .feature-badge {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(4px);
            padding: 0.8rem 1.5rem;
            border-radius: 60px;
            font-weight: 500;
            border: 1px solid rgba(255, 255, 255, 0.2);
            transition: all 0.3s;
            display: flex;
            align-items: center;
        }

        .feature-badge:hover {
            background: rgba(23, 162, 184, 0.2);
            border-color: #17a2b8;
            transform: translateX(10px);
        }

        /* ----- RIGHT PANEL – LOGIN CARD (GLASS) ----- */
        .glass-card {
            background: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(12px);
            -webkit-backdrop-filter: blur(12px);
            border-radius: 32px;
            border: 1px solid rgba(255, 255, 255, 0.3);
            box-shadow: 0 25px 50px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
            overflow: hidden;
        }

        .glass-card:hover {
            box-shadow: 0 35px 70px rgba(23, 162, 184, 0.15);
            border-color: rgba(23, 162, 184, 0.4);
            transform: translateY(-8px);
        }

        /* ----- CARD HEADER WITH GRADIENT ----- */
        .login-header {
            background: linear-gradient(145deg, #17a2b8, #138496);
            padding: 2rem 1.5rem;
            border-bottom: 5px solid #ffc107;
            position: relative;
        }

        .login-header::after {
            content: '';
            position: absolute;
            bottom: -2px;
            left: 0;
            width: 100%;
            height: 3px;
            background: linear-gradient(90deg, #ffc107, rgba(255, 193, 7, 0.2));
        }

        /* ----- FORM FIELDS (FLOATING LABELS) ----- */
        .form-floating>.form-control {
            border-radius: 50px !important;
            border: 2px solid #e9ecef;
            padding: 1.2rem 1.2rem;
            height: calc(3.8rem + 2px);
            background: white;
            font-weight: 500;
            transition: all 0.2s;
        }

        .form-floating>.form-control:focus {
            border-color: #17a2b8;
            box-shadow: 0 0 0 0.25rem rgba(23, 162, 184, 0.25);
            transform: scale(1.01);
        }

        .form-floating>label {
            padding-left: 1.2rem;
            font-weight: 500;
            color: #6c757d;
        }

        /* ----- GRADIENT BUTTON WITH SHIMMER ----- */
        .btn-gradient {
            background: linear-gradient(145deg, #17a2b8, #138496);
            border: none;
            color: white;
            font-weight: 700;
            padding: 16px 28px;
            border-radius: 60px;
            letter-spacing: 1px;
            transition: all 0.3s ease;
            box-shadow: 0 10px 25px rgba(23, 162, 184, 0.3);
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
            transition: left 0.6s;
        }

        .btn-gradient:hover {
            background: linear-gradient(145deg, #138496, #17a2b8);
            transform: scale(1.05);
            box-shadow: 0 18px 35px rgba(23, 162, 184, 0.5);
        }

        .btn-gradient:hover::before {
            left: 100%;
        }

        /* ----- ALERT STYLES ----- */
        .alert-custom {
            border-radius: 50px;
            border: none;
            backdrop-filter: blur(4px);
            padding: 1rem 1.5rem;
            font-weight: 600;
        }

        .alert-danger {
            background: rgba(220, 53, 69, 0.2);
            border: 2px solid #dc3545;
            color: #dc3545;
        }

        /* ----- RESPONSIVE ----- */
        @media (max-width: 768px) {
            .welcome-panel {
                min-height: 400px;
                margin-bottom: 20px;
            }

            .welcome-panel h1 {
                font-size: 2.5rem;
            }
        }
    </style>

    <!-- ===== MAIN CONTAINER ===== -->
    <div class="container-fluid py-5 px-4">
        <div class="row justify-content-center align-items-stretch g-5">

            <!-- ===== LEFT COLUMN – WELCOME PANEL ===== -->
            <div class="col-lg-6 d-flex fade-up delay-1">
                <div class="welcome-panel w-100">
                    <!-- Salon Badge -->
                    <div class="mb-4">
                        <span class="badge bg-dark bg-opacity-50 px-4 py-3 rounded-pill fs-6">
                            <i class="fas fa-crown me-2" style="color: #ffc107;"></i> Groomify
                        </span>
                    </div>

                    <h1 class="display-3 fw-bold">Therapist<br><span class="accent-text">Portal</span></h1>
                    <p class="lead fs-3 mt-3" style="font-weight: 500;">Your schedule,<br>your success.</p>

                    <!-- Therapist Avatars / Community -->
                    <div class="mt-4 d-flex align-items-center">
                        <div class="d-flex">
                            <img src="img/user-male-1.jpg" class="rounded-circle border border-3 border-white"
                                width="50" height="50">
                            <img src="img/user-female-1.jpg" class="rounded-circle border border-3 border-white ms-n2"
                                width="50" height="50">
                            <img src="img/user-male-2.jpg" class="rounded-circle border border-3 border-white ms-n2"
                                width="50" height="50">
                            <img src="img/user-female-2.jpg" class="rounded-circle border border-3 border-white ms-n2"
                                width="50" height="50">
                        </div>
                        <span class="ms-3 text-white-50">+24 therapists online</span>
                    </div>

                    <!-- Feature List (Benefits for Therapists) -->
                    <div class="mt-5 d-flex flex-column gap-3">
                        <div class="feature-badge">
                            <i class="fas fa-calendar-check me-3 fs-5" style="color: #ffc107;"></i>
                            <span>Manage your schedule in real time</span>
                        </div>
                        <div class="feature-badge">
                            <i class="fas fa-user-check me-3 fs-5" style="color: #ffc107;"></i>
                            <span>View upcoming appointments</span>
                        </div>
                        <div class="feature-badge">
                            <i class="fas fa-chart-line me-3 fs-5" style="color: #ffc107;"></i>
                            <span>Track your performance &amp; ratings</span>
                        </div>
                        <div class="feature-badge">
                            <i class="fas fa-bell me-3 fs-5" style="color: #ffc107;"></i>
                            <span>Instant booking notifications</span>
                        </div>
                    </div>

                    <!-- Special Announcement -->
                    <div class="mt-5 p-3 rounded-4"
                        style="background: rgba(23,162,184,0.2); border: 1px solid rgba(23,162,184,0.5);">
                        <div class="d-flex align-items-center">
                            <i class="fas fa-gem fa-2x me-3" style="color: #ffc107;"></i>
                            <div>
                                <strong class="text-white">New this month:</strong>
                                <span class="text-white-50"> Therapist incentive program – earn up to 20% bonus!</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- ===== RIGHT COLUMN – LOGIN CARD ===== -->
            <div class="col-lg-6 d-flex fade-up delay-2">
                <div class="glass-card w-100">
                    <!-- Card Header -->
                    <div class="login-header text-white text-center">
                        <i class="fas fa-user-md fa-2x mb-3" style="color: #ffc107;"></i>
                        <h2 class="h2 fw-bold mb-0">Therapist Login</h2>
                        <p class="text-white-50 mb-0 mt-2">Access your professional dashboard</p>
                    </div>

                    <div class="card-body p-4 p-xl-5">
                        <!-- ERROR MESSAGE DISPLAY -->
                        <c:if test="${not empty errorMessage}">
                            <div class="alert alert-custom alert-danger d-flex align-items-center mb-4 fade-up"
                                role="alert">
                                <i class="fas fa-exclamation-triangle me-2 fs-5"></i>
                                ${errorMessage}
                            </div>
                        </c:if>

                        <!-- LOGIN FORM (ORIGINAL FUNCTIONALITY) -->
                        <form action="TherapistServlet" method="post">
                            <input type="hidden" name="action" value="login">

                            <!-- EMAIL FIELD -->
                            <div class="form-floating mb-4 fade-up delay-2">
                                <input class="form-control" id="email" type="email" name="email"
                                    placeholder="name@example.com" required autofocus>
                                <label for="email"><i class="fas fa-envelope me-2 text-secondary"></i>Email</label>
                            </div>

                            <!-- PASSWORD FIELD -->
                            <div class="form-floating mb-4 fade-up delay-3">
                                <input class="form-control" id="password" type="password" name="password"
                                    placeholder="Password" required>
                                <label for="password"><i class="fas fa-lock me-2 text-secondary"></i>Password</label>
                            </div>

                            <!-- REMEMBER ME & FORGOT PASSWORD -->
                            <div class="d-flex justify-content-between align-items-center mb-4 fade-up delay-4">
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" id="rememberMe">
                                    <label class="form-check-label text-muted" for="rememberMe">
                                        Remember me
                                    </label>
                                </div>
                                <a href="#" class="text-decoration-none small" style="color: #17a2b8;">
                                    Forgot password?
                                </a>
                            </div>

                            <!-- LOGIN BUTTON (GRADIENT + SHIMMER) -->
                            <div class="d-grid gap-2 mt-4 fade-up delay-5">
                                <button class="btn btn-gradient btn-lg" type="submit">
                                    <i class="fas fa-sign-in-alt me-2"></i>Login to Dashboard
                                </button>
                            </div>

                            <!-- SECURITY NOTE -->
                            <p class="text-center text-muted small mt-4 mb-0">
                                <i class="fas fa-shield-alt me-1"></i>256-bit SSL encrypted
                            </p>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%@ include file="footer.jsp" %>