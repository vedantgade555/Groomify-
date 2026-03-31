<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>

<style>
/* (Your entire CSS remains same – no change needed) */
</style>

<div class="container py-4 px-lg-5">

    <div class="about-hero text-white text-center fade-up delay-1">
        <span class="hero-badge">
            <i class="fas fa-crown me-2" style="color: #d4af37;"></i> Since 2010
        </span>
        <h1 class="display-1 fw-bold">
            About <span class="gold-text">Groomify</span> Salon
        </h1>
        <p class="lead fs-2 mx-auto" style="max-width: 800px; text-shadow: 0 2px 10px rgba(0,0,0,0.3);">
            Redefining beauty and relaxation – one guest at a time.
        </p>
    </div>

    <div class="row align-items-center g-5 mb-5">
        <div class="col-lg-6 fade-up delay-2">
            <h2 class="section-title">Our Story</h2>
            <p class="lead text-muted">Redefining beauty and relaxation since 2010.</p>
            <p class="fs-5" style="line-height: 1.8;">
                At Groomify, we believe that self-care is not a luxury, but a necessity.
                Our team of experienced professionals is dedicated to providing you with
                the highest quality services in a relaxing and welcoming environment.
            </p>
            <p class="fs-5" style="line-height: 1.8;">
                We offer a wide range of services including hair styling, skincare,
                massage therapy, and more. Our products are carefully selected to ensure
                the best results for your unique needs.
            </p>

            <div class="d-flex gap-3 mt-4">
                <span class="badge bg-dark bg-opacity-10 p-3 rounded-pill">
                    <i class="fas fa-check-circle me-2" style="color: #d4af37;"></i> 100% Organic
                </span>
                <span class="badge bg-dark bg-opacity-10 p-3 rounded-pill">
                    <i class="fas fa-user-tie me-2" style="color: #d4af37;"></i> 15+ Experts
                </span>
            </div>
        </div>

        <div class="col-lg-6 fade-up delay-3">
            <div class="story-image">
                <img src="https://images.unsplash.com/photo-1560066984-138dadb4c035?auto=format&fit=crop&w=2070&q=80"
                     alt="Salon Interior" class="img-fluid">
            </div>
        </div>
    </div>

    <div class="row g-4 my-5 text-center">
        <div class="col-md-3 fade-up delay-2">
            <div class="stat-card">
                <div class="stat-icon"><i class="fas fa-calendar-alt"></i></div>
                <h2 class="fw-bold display-5 mb-0">15+</h2>
                <p class="text-muted mb-0">Years of Excellence</p>
            </div>
        </div>

        <div class="col-md-3 fade-up delay-3">
            <div class="stat-card">
                <div class="stat-icon"><i class="fas fa-scissors"></i></div>
                <h2 class="fw-bold display-5 mb-0">25k+</h2>
                <p class="text-muted mb-0">Happy Clients</p>
            </div>
        </div>

        <div class="col-md-3 fade-up delay-4">
            <div class="stat-card">
                <div class="stat-icon"><i class="fas fa-user-tie"></i></div>
                <h2 class="fw-bold display-5 mb-0">15+</h2>
                <p class="text-muted mb-0">Expert Therapists</p>
            </div>
        </div>

        <div class="col-md-3 fade-up delay-5">
            <div class="stat-card">
                <div class="stat-icon"><i class="fas fa-star"></i></div>
                <h2 class="fw-bold display-5 mb-0">4.9</h2>
                <p class="text-muted mb-0">Average Rating</p>
            </div>
        </div>
    </div>

    <div class="row justify-content-center my-5 fade-up delay-5">
        <div class="col-lg-8">
            <div class="testimonial-card">
                <p class="fs-4 fst-italic mb-3">
                    “Groomify is my sanctuary. The attention to detail and genuine care
                    from the staff is unmatched. I leave feeling refreshed and beautiful every time.”
                </p>
                <strong>- Amanda Reynolds</strong>
                <div class="text-warning mt-2">
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                </div>
                <span class="text-muted small d-block mt-2">
                    Regular client since 2019
                </span>
            </div>
        </div>
    </div>

    <div class="cta-section text-center fade-up delay-6">
        <h2 class="display-6 fw-bold mb-3" style="color: #2c3e50;">
            Ready to Experience the Groomify Difference?
        </h2>
        <p class="fs-5 mb-4" style="color: #4a5b6a;">
            Discover our range of premium services today.
        </p>

        <a href="salon_list.jsp" class="btn btn-outline-dark btn-lg rounded-pill px-4">
            <i class="fas fa-scissors me-2"></i> View Services
        </a>
    </div>

</div>

<%@ include file="footer.jsp" %>