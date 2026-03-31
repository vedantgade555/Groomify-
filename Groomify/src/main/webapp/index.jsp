<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ include file="header.jsp" %>

        <style>
            /* ----- CUSTOM ANIMATIONS & KEYFRAMES ----- */
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
                    transform: translateY(0px);
                }

                50% {
                    transform: translateY(-10px);
                }

                100% {
                    transform: translateY(0px);
                }
            }

            .fade-in {
                animation: fadeIn 1.2s cubic-bezier(0.23, 1, 0.32, 1) forwards;
            }

            .fade-up {
                opacity: 0;
                /* hidden until animation plays */
                animation: fadeUp 1s cubic-bezier(0.23, 1, 0.32, 1) forwards;
            }

            /* ----- HERO SECTION ----- */
            .hero-section {
                background-image: linear-gradient(90deg, rgba(0, 0, 0, 0.7) 0%, rgba(0, 0, 0, 0.3) 100%),
                    url('img/hero-bg.jpg');
                background-size: cover;
                background-position: center 30%;
                background-repeat: no-repeat;
                border-radius: 24px !important;
                box-shadow: 0 20px 35px rgba(0, 0, 0, 0.3);
                transition: box-shadow 0.4s ease;
            }

            .hero-section:hover {
                box-shadow: 0 30px 50px rgba(0, 0, 0, 0.4);
            }

            .hero-section .container-fluid {
                backdrop-filter: blur(2px);
                /* subtle depth */
            }

            .text-shadow {
                text-shadow: 0 5px 15px rgba(0, 0, 0, 0.5);
            }

            /* custom button – glassmorphism + gradient */
            .btn-custom {
                background: linear-gradient(145deg, #d4af37, #b8942e);
                border: none;
                color: #000;
                font-weight: 600;
                padding: 12px 36px;
                letter-spacing: 1px;
                border-radius: 50px;
                transition: all 0.3s ease;
                box-shadow: 0 8px 20px rgba(180, 140, 50, 0.3);
            }

            .btn-custom:hover {
                background: linear-gradient(145deg, #e6c468, #c9a341);
                transform: scale(1.08);
                box-shadow: 0 15px 30px rgba(212, 175, 55, 0.5);
                color: #000;
            }

            /* ----- SERVICE & THERAPIST CARDS ----- */
            .service-card {
                background: linear-gradient(135deg, rgba(20, 20, 20, 0.85) 0%, rgba(40, 40, 40, 0.9) 100%),
                    url('img/service-bg.jpg');
                background-size: cover;
                background-position: center;
                border-radius: 24px;
                transition: all 0.4s cubic-bezier(0.25, 0.46, 0.45, 0.94);
                color: white;
                border: none !important;
                box-shadow: 0 15px 30px rgba(0, 0, 0, 0.2);
                position: relative;
                overflow: hidden;
            }

            .therapist-card {
                background: linear-gradient(135deg, rgba(10, 10, 10, 0.8) 0%, rgba(30, 30, 30, 0.85) 100%),
                    url('img/therapist-bg.jpg');
                background-size: cover;
                background-position: center 20%;
                border-radius: 24px;
                transition: all 0.4s cubic-bezier(0.25, 0.46, 0.45, 0.94);
                border: none !important;
                box-shadow: 0 15px 30px rgba(0, 0, 0, 0.2);
                position: relative;
                overflow: hidden;
            }

            /* overlay effect on hover – solid & premium */
            .service-card::after,
            .therapist-card::after {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: linear-gradient(145deg, rgba(212, 175, 55, 0.1), rgba(100, 100, 100, 0.05));
                opacity: 0;
                transition: opacity 0.5s ease;
                pointer-events: none;
                border-radius: 24px;
            }

            .service-card:hover::after,
            .therapist-card:hover::after {
                opacity: 1;
            }

            .service-card:hover,
            .therapist-card:hover {
                transform: translateY(-12px) scale(1.02);
                box-shadow: 0 30px 45px rgba(0, 0, 0, 0.35);
            }

            /* inside content spacing */
            .card-content {
                position: relative;
                z-index: 3;
            }

            .btn-outline-light {
                border-width: 2px;
                transition: all 0.3s;
                border-radius: 40px;
                padding: 10px 28px;
                font-weight: 600;
            }

            .btn-outline-light:hover {
                background: white;
                color: black;
                transform: scale(1.05);
                border-color: white;
            }

            .btn-outline-secondary {
                border-width: 2px;
                transition: all 0.3s;
                border-radius: 40px;
                padding: 10px 28px;
                font-weight: 600;
                background: transparent;
                border-color: #6c757d;
                color: #6c757d;
            }

            .btn-outline-secondary:hover {
                background: #6c757d;
                color: white;
                transform: scale(1.05);
            }

            /* floating animation for hero heading (subtle) */
            .display-5 {
                animation: float 6s infinite ease-in-out;
                display: inline-block;
            }

            /* additional content: price/offer badge */
            .offer-badge {
                background: linear-gradient(145deg, #d4af37, #b8942e);
                color: black;
                font-weight: 700;
                padding: 6px 18px;
                border-radius: 50px;
                display: inline-block;
                margin-bottom: 15px;
                letter-spacing: 1px;
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
            }

            /* fade-up delays for child elements */
            .hero-section .offer-badge {
                animation-delay: 0.2s;
            }

            .hero-section h1 {
                animation-delay: 0.3s;
            }

            .hero-section p {
                animation-delay: 0.5s;
            }

            .hero-section .btn {
                animation-delay: 0.7s;
            }

            .service-card {
                animation-delay: 0.2s;
            }

            .therapist-card {
                animation-delay: 0.4s;
            }

            /* responsive fine-tuning */
            @media (max-width: 768px) {
                .hero-section {
                    background-position: 70% center;
                }

                .display-5 {
                    font-size: 2.2rem;
                }
            }
        </style>

        <div class="container py-4">

            <div class="p-5 mb-5 hero-section text-white rounded shadow-lg fade-in">
                <div class="container-fluid py-5">
                    <span class="offer-badge fade-up"><i class="fas fa-tag me-2"></i>20% OFF – FIRST VISIT</span>
                    <h1 class="display-5 fw-bold text-shadow fade-up">Welcome to Groomify</h1>
                    <p class="col-md-8 fs-4 mx-auto text-shadow fade-up">
                        <i class="fas fa-spa me-2"></i> Premium hair, skin &amp; spa rituals.
                        <br class="d-none d-md-block">Reclaim your glow.
                    </p>
                    <div class="d-flex justify-content-center gap-4 mt-4 mb-3 fade-up">
                        <span class="text-white-50"><i class="fas fa-star text-warning me-1"></i> 4.9 ★ (2.3k
                            reviews)</span>
                        <span class="text-white-50"><i class="fas fa-clock me-1"></i> 8am – 9pm</span>
                    </div>
                    <a href="book_appointment.jsp" class="btn btn-custom btn-lg shadow fade-up">
                        <i class="fas fa-calendar-check me-2"></i>Book Appointment
                    </a>
                </div>
            </div>

            <div class="row g-4 align-items-md-stretch">
                <div class="col-md-6 fade-up">
                    <div class="h-100 p-5 service-card rounded-4 d-flex flex-column justify-content-center">
                        <div class="card-content">
                            <div class="d-flex align-items-center mb-3">
                                <i class="fas fa-cut fa-2x me-3" style="color: #d4af37;"></i>
                                <h2 class="fw-bold mb-0">Our Services</h2>
                            </div>
                            <p class="mb-4" style="font-size: 1.2rem;">
                                From precision haircuts to deep tissue massages – all organic, all premium.
                            </p>
                            <ul class="list-unstyled mb-4">
                                <li class="mb-2"><i class="fas fa-check-circle me-2" style="color: #d4af37;"></i> Luxury
                                    haircuts &amp; styling</li>
                                <li class="mb-2"><i class="fas fa-check-circle me-2" style="color: #d4af37;"></i> Facial
                                    &amp; gold-leaf treatments</li>
                                <li class="mb-2"><i class="fas fa-check-circle me-2" style="color: #d4af37;"></i> Hot
                                    stone / aromatherapy</li>
                            </ul>
                            <a href="salon_list.jsp" class="btn btn-outline-light mt-2">
                                <i class="fas fa-arrow-right me-2"></i>View Services
                            </a>
                        </div>
                    </div>
                </div>

                <div class="col-md-6 fade-up">
                    <div class="h-100 p-5 therapist-card rounded-4 d-flex flex-column justify-content-center">
                        <div class="card-content">
                            <div class="d-flex align-items-center mb-3">
                                <i class="fas fa-user-md fa-2x me-3" style="color: #d4af37;"></i>
                                <h2 class="fw-bold mb-0">Meet Our Therapists</h2>
                            </div>
                            <p class="mb-4" style="font-size: 1.2rem;">
                                12+ certified specialists, 10+ years average experience. Your well-being is their
                                mission.
                            </p>
                            <div class="d-flex align-items-center mb-4">
                                <div class="d-flex">
                                    <img src="img/user-female-1.jpg" class="rounded-circle border border-2 border-white"
                                        width="45" height="45" style="object-fit: cover;">
                                    <img src="img/user-male-1.jpg"
                                        class="rounded-circle border border-2 border-white ms-n2" width="45" height="45"
                                        style="object-fit: cover;">
                                    <img src="img/user-female-2.jpg"
                                        class="rounded-circle border border-2 border-white ms-n2" width="45" height="45"
                                        style="object-fit: cover;">
                                    <span class="ms-3 text-white align-self-center">+9 experts</span>
                                </div>
                            </div>
                            <a href="about.jsp" class="btn btn-outline-light mt-2">
                                <i class="fas fa-users me-2"></i>About Us
                            </a>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row mt-5 text-center fade-up" style="animation-delay: 0.6s;">
                <div class="col-12">
                    <div class="p-4 bg-white rounded-4 shadow-sm d-inline-block px-5">
                        <i class="fas fa-shield-alt me-2" style="color: #d4af37;"></i>
                        <span class="fw-bold">100% hygiene guaranteed</span>
                        <span class="mx-3 text-muted">|</span>
                        <i class="fas fa-leaf me-2" style="color: #d4af37;"></i>
                        <span class="fw-bold">Organic &amp; vegan products</span>
                        <span class="mx-3 text-muted">|</span>
                        <i class="fas fa-clock me-2" style="color: #d4af37;"></i>
                        <span class="fw-bold">Same-day booking</span>
                    </div>
                </div>
            </div>

        </div>
        <%@ include file="footer.jsp" %>