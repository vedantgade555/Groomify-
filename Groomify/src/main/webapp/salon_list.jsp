<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="header.jsp" %>
<%@ page import="dao.ServiceDAO, model.Service, java.util.List" %>

<% 
    /* Fetch all services from the database */ 
    ServiceDAO serviceDAO = new ServiceDAO(); 
    List<Service> services = serviceDAO.getAllServices();
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
    @keyframes pulse {
        0% { box-shadow: 0 0 0 0 rgba(212, 175, 55, 0.4); }
        70% { box-shadow: 0 0 0 10px rgba(212, 175, 55, 0); }
        100% { box-shadow: 0 0 0 0 rgba(212, 175, 55, 0); }
    }

    .fade-up {
        opacity: 0;
        animation: fadeUp 0.8s cubic-bezier(0.23, 1, 0.32, 1) forwards;
    }

    .delay-1 { animation-delay: 0.1s; }
    .delay-2 { animation-delay: 0.2s; }
    .delay-3 { animation-delay: 0.3s; }
    .delay-4 { animation-delay: 0.4s; }

    /* ----- GLOBAL STYLES ----- */
    body {
        background: linear-gradient(145deg, #fcf9f7 0%, #f8f3f0 100%);
        font-family: 'Inter', sans-serif;
        position: relative;
    }

    body::before {
        content: '';
        position: fixed;
        top: 0; left: 0; width: 100%; height: 100%;
        background-image: url('https://images.unsplash.com/photo-1560066984-138dadb4c035?ixlib=rb-4.0.3&auto=format&fit=crop&w=2070&q=80');
        background-size: cover;
        background-position: center;
        opacity: 0.03;
        pointer-events: none;
        z-index: -1;
    }

    /* ----- HERO SECTION ----- */
    .services-hero {
        background: linear-gradient(105deg, rgba(0, 0, 0, 0.7), rgba(0, 0, 0, 0.5)), url('img/luxury_hero.png');
        background-size: cover;
        background-position: center 40%;
        border-radius: 40px;
        padding: 4rem 2rem;
        margin-bottom: 4rem;
        box-shadow: 0 25px 40px rgba(0, 0, 0, 0.2);
        border: 1px solid rgba(255, 255, 255, 0.2);
        transition: all 0.3s;
    }

    .services-hero:hover {
        box-shadow: 0 35px 60px rgba(212, 175, 55, 0.2);
        border-color: rgba(212, 175, 55, 0.3);
    }

    .services-hero h1 {
        font-size: 4rem;
        font-weight: 800;
        text-shadow: 0 10px 20px rgba(0, 0, 0, 0.5);
        animation: float 6s infinite ease-in-out;
    }

    .gold-text {
        color: #d4af37;
        text-shadow: 0 0 15px rgba(212, 175, 55, 0.7);
    }

    .hero-badge {
        background: rgba(212, 175, 55, 0.2);
        backdrop-filter: blur(4px);
        border: 1px solid #d4af37;
        color: white;
        padding: 0.7rem 1.8rem;
        border-radius: 60px;
        font-weight: 600;
        display: inline-block;
        margin-bottom: 1.5rem;
    }

    /* ----- SERVICE CARD ----- */
    .service-card {
        background: rgba(255, 255, 255, 0.9);
        backdrop-filter: blur(10px);
        border: 1px solid rgba(255, 255, 255, 0.5);
        border-radius: 28px;
        overflow: hidden;
        transition: all 0.4s cubic-bezier(0.23, 1, 0.32, 1);
        height: 100%;
        display: flex;
        flex-direction: column;
        box-shadow: 0 15px 30px rgba(0, 0, 0, 0.05);
        position: relative;
    }

    .service-card:hover {
        transform: translateY(-15px);
        box-shadow: 0 30px 50px rgba(212, 175, 55, 0.2);
        border-color: #d4af37;
    }

    .card-img-top {
        height: 220px;
        background-size: cover;
        background-position: center;
        position: relative;
        transition: transform 0.6s;
    }

    .service-card:hover .card-img-top {
        transform: scale(1.05);
    }

    .img-overlay {
        position: absolute;
        top: 0; left: 0; width: 100%; height: 100%;
        background: linear-gradient(180deg, rgba(0, 0, 0, 0.1), rgba(0, 0, 0, 0.6));
    }

    .price-tag {
        background: linear-gradient(145deg, #d4af37, #b8942e);
        color: black;
        font-weight: 700;
        padding: 0.5rem 1.2rem;
        border-radius: 60px;
        display: inline-block;
        font-size: 1.2rem;
        box-shadow: 0 8px 20px rgba(212, 175, 55, 0.3);
        transition: all 0.3s;
        border: 2px solid white;
    }

    .service-card:hover .price-tag {
        transform: scale(1.1);
        background: linear-gradient(145deg, #e6c468, #c9a341);
        box-shadow: 0 12px 30px rgba(212, 175, 55, 0.5);
    }

    .duration-badge {
        background: rgba(255, 255, 255, 0.2);
        backdrop-filter: blur(4px);
        border: 1px solid rgba(255, 255, 255, 0.5);
        color: white;
        font-weight: 600;
        padding: 0.4rem 1rem;
        border-radius: 60px;
        font-size: 0.8rem;
        letter-spacing: 1px;
    }

    .popular-badge {
        background: linear-gradient(145deg, #ff6b6b, #ee5253);
        color: white;
        font-weight: 700;
        padding: 0.3rem 1rem;
        border-radius: 60px;
        font-size: 0.7rem;
        text-transform: uppercase;
        letter-spacing: 1px;
        position: absolute;
        top: 20px; right: 20px;
        z-index: 10;
        box-shadow: 0 5px 15px rgba(255, 107, 107, 0.3);
        animation: pulse 2s infinite;
    }

    .btn-service {
        background: linear-gradient(145deg, #d4af37, #b8942e);
        border: none;
        color: black;
        font-weight: 700;
        padding: 12px 28px;
        border-radius: 60px;
        letter-spacing: 1px;
        transition: all 0.3s;
        box-shadow: 0 8px 20px rgba(212, 175, 55, 0.3);
        position: relative;
        overflow: hidden;
        width: 100%;
        display: block;
        text-decoration: none;
    }

    .btn-service:hover {
        background: linear-gradient(145deg, #e6c468, #c9a341);
        transform: scale(1.05);
        box-shadow: 0 15px 35px rgba(212, 175, 55, 0.5);
        color: black;
    }

    .gallery-img {
        transition: all 0.4s ease;
    }

    @media (max-width: 768px) {
        .services-hero { padding: 3rem 1.5rem; }
        .services-hero h1 { font-size: 2.8rem; }
    }
</style>

<div class="container py-4">

    <div class="services-hero text-white text-center fade-up delay-1">
        <span class="hero-badge">
            <i class="fas fa-crown me-2" style="color: #d4af37;"></i> Groomify
        </span>
        <h1 class="display-1 fw-bold">Our <span class="gold-text">Premium</span> Services</h1>
        <p class="lead fs-3 mx-auto" style="max-width: 700px; text-shadow: 0 2px 10px rgba(0,0,0,0.3);">
            Indulge in the finest treatments tailored for your beauty and wellness.
        </p>
        <div class="d-flex justify-content-center flex-wrap gap-3 mt-4">
            <span class="duration-badge"><i class="fas fa-check-circle me-1"></i> 100% Organic</span>
            <span class="duration-badge"><i class="fas fa-user-tie me-1"></i> Expert Therapists</span>
            <span class="duration-badge"><i class="fas fa-clock me-1"></i> Flexible Options</span>
        </div>
    </div>

    <div class="row g-4">
        <% 
            int delay = 1; 
            /* Loop through services and assign unique images or themed fallbacks */
            for(Service s : services) { 
                String imageUrl; 
                String name = s.getServiceName(); 
                String lowName = name.toLowerCase(); 
                
                if (name.equals("Men's Classic Haircut")) {
                    imageUrl = "img/hair_men_classic.png"; 
                } else if (name.equals("Women's Signature Haircut")) {
                    imageUrl = "img/hair_women_signature.png"; 
                } else if (name.equals("Deep Tissue Massage")) {
                    imageUrl = "img/massage_deep_tissue.png"; 
                } else if (name.equals("Swedish Relaxation Massage")) { 
                    imageUrl = "img/massage_swedish_relax.png"; 
                } else if (name.equals("Hot Stone Therapy")) { 
                    imageUrl = "img/massage_hot_stone.png"; 
                } else if (name.equals("Aromatherapy Spa")) { 
                    imageUrl = "img/spa_aromatherapy.png"; 
                } else if (name.equals("Classic Manicure")) {
                    imageUrl = "img/nail_manicure_classic.png"; 
                } else if (name.equals("Premium Gel Manicure")) {
                    imageUrl = "img/nail_gel_premium.png"; 
                } else if (name.equals("Luxury Spa Pedicure")) {
                    imageUrl = "img/nail_pedicure_luxury.png"; 
                } else if (name.equals("Anti-Aging Facial")) {
                    imageUrl = "img/facial_anti_aging_spa.png"; 
                } else if (name.equals("Hydrating Skin Facial")) { 
                    imageUrl = "img/facial_hydrating_refresh.png"; 
                } else if (name.equals("Acne Clearing Treatment")) { 
                    imageUrl = "img/facial_acne_clearing.png"; 
                } else if (lowName.contains("balayage")) { 
                    imageUrl = "img/hair_women_signature.png"; 
                } else if (lowName.contains("beard")) { 
                    imageUrl = "img/hair_men_classic.png"; 
                } else if (lowName.contains("hair")) { 
                    imageUrl = "img/luxury_hair.png"; 
                } else if (lowName.contains("facial") || lowName.contains("skin") || lowName.contains("makeup") || lowName.contains("waxing") || lowName.contains("threading")) {
                    imageUrl = "img/luxury_skin.png"; 
                } else if (lowName.contains("massage") || lowName.contains("spa") || lowName.contains("scalp")) { 
                    imageUrl = "img/luxury_spa.png"; 
                } else if (lowName.contains("manicure") || lowName.contains("pedicure") || lowName.contains("nail")) { 
                    imageUrl = "img/luxury_nail.png"; 
                } else { 
                    /* Default Groomify Display Image */ 
                    imageUrl = "img/luxury_hero.png"; 
                } 
        %>
            <div class="col-lg-4 col-md-6 fade-up delay-<%= delay %>">
                <div class="service-card">
                    
                    <% if(delay <= 3) { %>
                        <span class="popular-badge"><i class="fas fa-fire me-1"></i> Popular</span>
                    <% } %>

                    <div class="card-img-top" style="background-image: url('<%= imageUrl %>');">
                        <div class="img-overlay"></div>
                    </div>

                    <div class="card-body d-flex flex-column p-4">
                        <div class="d-flex justify-content-between align-items-start mb-3">
                            <h3 class="card-title fw-bold mb-0" style="font-size: 1.6rem;">
                                <%= s.getServiceName() %>
                            </h3>
                            <span class="price-tag">Rs <%= s.getPrice() %></span>
                        </div>

                        <div class="mb-3">
                            <span class="badge bg-light text-dark p-3 rounded-pill border">
                                <i class="far fa-clock me-1"></i> <%= s.getDuration() %> mins
                            </span>
                        </div>

                        <p class="card-text text-muted mb-4" style="line-height: 1.6;">
                            Experience the best in <%= s.getServiceName().toLowerCase() %> with our expert therapists. Premium products, relaxing ambiance, and lasting results.
                        </p>

                        <div class="mt-auto">
                            <a href="book_appointment.jsp" class="btn-service text-center">
                                <i class="fas fa-calendar-alt me-2"></i> Book This Service
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        <% 
                delay = (delay % 4) + 1; 
            } 
        %>
    </div>

    <div class="row mt-5 pt-4 fade-up delay-4">
        <div class="col-12 text-center mb-4">
            <h2 class="fw-bold"><i class="fas fa-camera-retro me-2 gold-text"></i> Groomify <span class="gold-text">Ambience</span></h2>
            <p class="text-muted">Explore our luxurious facilities designed for your ultimate comfort.</p>
        </div>
        <div class="col-md-4 mb-4">
            <div class="rounded-4 overflow-hidden shadow-sm border border-light" style="height: 250px;">
                <img src="img/luxury_hero.png" class="w-100 h-100 object-fit-cover gallery-img" style="filter: brightness(0.9);"
                    onmouseover="this.style.transform='scale(1.1)'; this.style.filter='brightness(1.1)'"
                    onmouseout="this.style.transform='scale(1)'; this.style.filter='brightness(0.9)'">
            </div>
        </div>
        <div class="col-md-4 mb-4">
            <div class="rounded-4 overflow-hidden shadow-sm border border-light" style="height: 250px;">
                <img src="img/luxury_spa.png" class="w-100 h-100 object-fit-cover gallery-img" style="filter: brightness(0.9);"
                    onmouseover="this.style.transform='scale(1.1)'; this.style.filter='brightness(1.1)'"
                    onmouseout="this.style.transform='scale(1)'; this.style.filter='brightness(0.9)'">
            </div>
        </div>
        <div class="col-md-4 mb-4">
            <div class="rounded-4 overflow-hidden shadow-sm border border-light" style="height: 250px;">
                <img src="img/luxury_hair.png" class="w-100 h-100 object-fit-cover gallery-img" style="filter: brightness(0.9);"
                    onmouseover="this.style.transform='scale(1.1)'; this.style.filter='brightness(1.1)'"
                    onmouseout="this.style.transform='scale(1)'; this.style.filter='brightness(0.9)'">
            </div>
        </div>
    </div>

    <div class="row mt-4 mb-5 fade-up delay-3">
        <div class="col-12">
            <div class="p-5 rounded-4 text-center"
                style="background: linear-gradient(145deg, rgba(212,175,55,0.1), rgba(212,175,55,0.05)); border: 1px solid rgba(212,175,55,0.3);">
                <h3 class="fw-bold mb-3" style="color: #2c3e50;">Not sure which service to choose?</h3>
                <p class="fs-5 text-muted mb-4">Log in to your account or contact our beauty experts.</p>
                <a href="customer_login.jsp" class="btn btn-outline-dark btn-lg rounded-pill px-5 py-3 shadow-sm">
                    <i class="fas fa-sign-in-alt me-2"></i> Log In to Inquire
                </a>
            </div>
        </div>
    </div>

</div>

<%@ include file="footer.jsp" %>