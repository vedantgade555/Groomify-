<%@ include file="header.jsp" %>
<%@ page import="model.Therapist" %>

<%
    Therapist t = (Therapist) request.getAttribute("therapist");
    if (t == null) {
        response.sendRedirect("salon_list.jsp");
        return;
    }

    // Enhanced dummy data — in real app, fetch from database
    int experienceYears = 8;
    int sessionsCompleted = 1240;
    int satisfactionRate = 98;
    String[] specialties = {"Deep Tissue", "Aromatherapy", "Hot Stone", "Reflexology"};
    String testimonial = "Absolutely amazing! I felt relaxed instantly. Highly skilled and professional.";
    String testimonialAuthor = "Sarah J.";
%>

<style>
    /* ----- KEYFRAMES ----- */
    @keyframes fadeUp {
        0% { opacity: 0; transform: translateY(30px); }
        100% { opacity: 1; transform: translateY(0); }
    }
    @keyframes fadeIn {
        0% { opacity: 0; }
        100% { opacity: 1; }
    }
    @keyframes float {
        0% { transform: translateY(0); }
        50% { transform: translateY(-8px); }
        100% { transform: translateY(0); }
    }
    @keyframes shimmer {
        0% { left: -100%; }
        100% { left: 100%; }
    }
    @keyframes pulse {
        0% { box-shadow: 0 0 0 0 rgba(212,175,55,0.4); }
        70% { box-shadow: 0 0 0 12px rgba(212,175,55,0); }
        100% { box-shadow: 0 0 0 0 rgba(212,175,55,0); }
    }

    .fade-up {
        opacity: 0;
        animation: fadeUp 0.8s cubic-bezier(0.23, 1, 0.32, 1) forwards;
    }
    .delay-1 { animation-delay: 0.1s; }
    .delay-2 { animation-delay: 0.2s; }
    .delay-3 { animation-delay: 0.3s; }
    .delay-4 { animation-delay: 0.4s; }
    .delay-5 { animation-delay: 0.5s; }

    /* ----- GLOBAL STYLES ----- */
    body {
        background: linear-gradient(135deg, rgba(0,0,0,0.7), rgba(0,0,0,0.5)),
                    url('https://images.unsplash.com/photo-1560066984-138dadb4c035?ixlib=rb-4.0.3&auto=format&fit=crop&w=2070&q=80');
        background-size: cover;
        background-position: center;
        background-attachment: fixed;
        font-family: 'Inter', sans-serif;
    }

    /* ----- HERO SECTION (OVERLAY) ----- */
    .therapist-hero {
        background: linear-gradient(105deg, rgba(0,0,0,0.7), rgba(0,0,0,0.5)),
                    url('https://images.unsplash.com/photo-1585747860715-2ba37f78886c?ixlib=rb-4.0.3&auto=format&fit=crop&w=2074&q=80');
        background-size: cover;
        background-position: center 30%;
        border-radius: 32px;
        padding: 3rem 2rem;
        margin-bottom: 2rem;
        box-shadow: 0 20px 40px rgba(0,0,0,0.3);
        border: 1px solid rgba(255,255,255,0.1);
    }

    /* ----- MAIN CARD – GLASS MORPHISM ----- */
    .profile-card {
        background: rgba(255,255,255,0.9);
        backdrop-filter: blur(12px);
        -webkit-backdrop-filter: blur(12px);
        border-radius: 36px;
        border: 1px solid rgba(255,255,255,0.3);
        box-shadow: 0 30px 60px rgba(0,0,0,0.1);
        transition: all 0.4s ease;
        overflow: hidden;
    }
    .profile-card:hover {
        box-shadow: 0 40px 80px rgba(212,175,55,0.2);
        border-color: rgba(212,175,55,0.4);
        transform: translateY(-6px);
    }

    /* ----- THERAPIST AVATAR ----- */
    .therapist-avatar {
        width: 200px;
        height: 200px;
        border-radius: 50%;
        object-fit: cover;
        border: 6px solid #d4af37;
        box-shadow: 0 15px 35px rgba(0,0,0,0.2);
        transition: all 0.3s;
        animation: float 6s infinite ease-in-out;
    }
    .therapist-avatar:hover {
        transform: scale(1.05);
        border-color: white;
        box-shadow: 0 20px 45px rgba(212,175,55,0.4);
    }

    /* ----- NAME WITH GRADIENT TEXT ----- */
    .gradient-text {
        background: linear-gradient(145deg, #1e2b37, #2c3e50);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        font-weight: 800;
    }

    /* ----- BADGES (GRADIENT) ----- */
    .badge-rating {
        background: linear-gradient(145deg, #d4af37, #b8942e);
        color: black;
        padding: 8px 20px;
        border-radius: 50px;
        font-weight: 700;
        box-shadow: 0 5px 15px rgba(212,175,55,0.3);
        transition: all 0.3s;
    }
    .badge-rating:hover {
        transform: scale(1.1);
        box-shadow: 0 10px 25px rgba(212,175,55,0.5);
    }
    .badge-availability {
        background: linear-gradient(145deg, #28a745, #1e7e34);
        color: white;
        padding: 8px 20px;
        border-radius: 50px;
        font-weight: 700;
        transition: all 0.3s;
    }
    .badge-availability:hover {
        transform: scale(1.1);
    }

    /* ----- STATISTICS CARDS ----- */
    .stat-item {
        background: rgba(255,255,255,0.5);
        backdrop-filter: blur(4px);
        border: 1px solid rgba(255,255,255,0.5);
        border-radius: 20px;
        padding: 1.2rem;
        transition: all 0.3s;
    }
    .stat-item:hover {
        background: white;
        border-color: #d4af37;
        transform: translateY(-6px);
        box-shadow: 0 15px 30px rgba(212,175,55,0.1);
    }

    /* ----- SPECIALTY TAGS ----- */
    .specialty-tag {
        background: rgba(212,175,55,0.1);
        border: 1px solid #d4af37;
        color: #2c3e50;
        padding: 6px 16px;
        border-radius: 50px;
        font-size: 0.9rem;
        font-weight: 600;
        transition: all 0.2s;
    }
    .specialty-tag:hover {
        background: #d4af37;
        color: black;
        transform: translateY(-2px);
    }

    /* ----- BUTTONS (GRADIENT + SHIMMER) ----- */
    .btn-gradient {
        background: linear-gradient(145deg, #d4af37, #b8942e);
        border: none;
        color: black;
        font-weight: 700;
        padding: 14px 30px;
        border-radius: 60px;
        letter-spacing: 1px;
        transition: all 0.3s;
        box-shadow: 0 8px 20px rgba(212,175,55,0.3);
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
        background: linear-gradient(90deg, transparent, rgba(255,255,255,0.4), transparent);
        transition: left 0.6s;
    }
    .btn-gradient:hover {
        background: linear-gradient(145deg, #e6c468, #c9a341);
        transform: scale(1.05);
        box-shadow: 0 15px 35px rgba(212,175,55,0.5);
    }
    .btn-gradient:hover::before {
        left: 100%;
    }
    .btn-outline {
        background: transparent;
        border: 2px solid #2c3e50;
        color: #2c3e50;
        font-weight: 600;
        padding: 12px 28px;
        border-radius: 60px;
        transition: all 0.3s;
    }
    .btn-outline:hover {
        background: #2c3e50;
        color: white;
        border-color: #2c3e50;
        transform: scale(1.05);
    }

    /* ----- TESTIMONIAL CARD ----- */
    .testimonial-card {
        background: rgba(255,255,255,0.5);
        backdrop-filter: blur(4px);
        border-radius: 24px;
        padding: 1.8rem;
        border: 1px solid rgba(255,255,255,0.6);
        transition: all 0.3s;
    }
    .testimonial-card:hover {
        background: white;
        border-color: #d4af37;
        box-shadow: 0 15px 30px rgba(212,175,55,0.1);
    }

    /* ----- RESPONSIVE ----- */
    @media (max-width: 768px) {
        .therapist-avatar { width: 150px; height: 150px; }
        .profile-card { margin: 1rem; }
    }
</style>

<div class="container py-5 px-lg-4">

    <div class="therapist-hero text-white text-center mb-5 fade-up delay-1">
        <h1 class="display-4 fw-bold" style="text-shadow: 0 10px 20px rgba(0,0,0,0.5);">
            Meet Your <span style="color: #d4af37;">Therapist</span>
        </h1>
        <p class="lead fs-3">Expert care, personalized just for you.</p>
    </div>

    <div class="row justify-content-center">
        <div class="col-lg-10">
            <div class="profile-card p-4 p-xl-5 fade-up delay-2">
                <div class="row g-5 align-items-center">
                    
                    <div class="col-lg-4 text-center">
                        <div class="position-relative d-inline-block">
                            <img src="https://images.unsplash.com/photo-1570158265777-4cdc0a8ecb1a?ixlib=rb-4.0.3&auto=format&fit=crop&w=987&q=80" 
                                 alt="<%= t.getName() %>" 
                                 class="therapist-avatar mb-3"
                                 onerror="this.src='https://via.placeholder.com/200'">
                            <span class="position-absolute bottom-0 end-0 p-2 bg-success rounded-circle" 
                                  style="width: 25px; height: 25px; border: 3px solid white;"></span>
                        </div>
                        <div class="mt-3 d-flex justify-content-center gap-2">
                            <span class="badge-rating"><i class="fas fa-star me-1"></i> <%= t.getRating() %> / 5.0</span>
                            <span class="badge-availability"><i class="fas fa-calendar-check me-1"></i> <%= t.getAvailability() %></span>
                        </div>
                    </div>

                    <div class="col-lg-8">
                        <h2 class="display-5 fw-bold gradient-text mb-2"><%= t.getName() %></h2>
                        
                        <div class="d-flex flex-wrap gap-4 mb-4">
                            <p class="text-muted mb-0"><i class="fas fa-envelope me-2" style="color: #d4af37;"></i> <%= t.getEmail() %></p>
                            <p class="text-muted mb-0"><i class="fas fa-phone me-2" style="color: #d4af37;"></i> <%= t.getPhone() %></p>
                        </div>

                        <p class="fs-5 mb-4" style="line-height: 1.7;">
                            <%= t.getName() %> is a certified massage and wellness therapist with over 
                            <strong><%= experienceYears %> years</strong> of experience. Specializing in therapeutic 
                            and relaxation techniques, <%= t.getName().split(" ")[0] %> is dedicated to helping clients 
                            achieve physical and mental balance.
                        </p>

                        <div class="row g-3 mb-4">
                            <div class="col-md-4">
                                <div class="stat-item text-center">
                                    <i class="fas fa-briefcase fa-2x mb-2" style="color: #d4af37;"></i>
                                    <h5 class="fw-bold mb-0"><%= experienceYears %>+</h5>
                                    <small class="text-muted">Years Experience</small>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="stat-item text-center">
                                    <i class="fas fa-user-check fa-2x mb-2" style="color: #d4af37;"></i>
                                    <h5 class="fw-bold mb-0"><%= sessionsCompleted %></h5>
                                    <small class="text-muted">Sessions Completed</small>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="stat-item text-center">
                                    <i class="fas fa-heart fa-2x mb-2" style="color: #d4af37;"></i>
                                    <h5 class="fw-bold mb-0"><%= satisfactionRate %>%</h5>
                                    <small class="text-muted">Satisfaction Rate</small>
                                </div>
                            </div>
                        </div>

                        <div class="mb-4">
                            <h6 class="fw-bold mb-3"><i class="fas fa-certificate me-2" style="color: #d4af37;"></i> Specialties</h6>
                            <div class="d-flex flex-wrap gap-2">
                                <% for(String spec : specialties) { %>
                                    <span class="specialty-tag"><%= spec %></span>
                                <% } %>
                            </div>
                        </div>

                        <div class="d-flex flex-wrap gap-3 mt-4">
                            <div class="btn btn-gradient px-5" style="cursor: default;">
                                <i class="fas fa-store me-2"></i>In-Store Booking Only
                            </div>
                            <a href="salon_list.jsp" class="btn btn-outline px-4">
                                <i class="fas fa-arrow-left me-2"></i>Back to List
                            </a>
                            <% if(session.getAttribute("admin") != null) { %>
                                <a href="manage_therapists.jsp" class="btn btn-outline-dark px-4">
                                    <i class="fas fa-cog me-2"></i>Admin Panel
                                </a>
                            <% } %>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="row justify-content-center mt-5 fade-up delay-4">
        <div class="col-lg-8">
            <div class="testimonial-card">
                <div class="d-flex gap-4 align-items-start">
                    <div class="flex-shrink-0">
                        <i class="fas fa-quote-right fa-3x" style="color: #d4af37; opacity: 0.3;"></i>
                    </div>
                    <div>
                        <p class="fs-5 fst-italic mb-2">"<%= testimonial %>"</p>
                        <div class="d-flex align-items-center">
                            <strong class="me-2">- <%= testimonialAuthor %></strong>
                            <div class="text-warning">
                                <i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="row mt-5 text-center fade-up delay-5">
        <div class="col-12">
            <div class="p-4 rounded-4" style="background: rgba(212,175,55,0.05); border: 1px dashed rgba(212,175,55,0.5);">
                <h5 class="fw-bold mb-2"><i class="fas fa-spa me-2" style="color: #d4af37;"></i> Ready to relax?</h5>
                <p class="text-muted mb-0">Choose from 20+ premium services and visit us in-store.</p>
            </div>
        </div>
    </div>

</div>

<%@ include file="footer.jsp" %>