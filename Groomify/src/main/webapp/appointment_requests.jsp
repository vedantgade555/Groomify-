<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ include file="header.jsp" %>
        <%@ page import="dao.BookingDAO, model.Booking, java.util.List" %>
            <% /* --- SESSION CHECK --- */ if (session.getAttribute("admin")==null) {
                response.sendRedirect("admin_login.jsp"); return; } /* --- FETCH BOOKINGS --- */ BookingDAO
                bookingDAO=new BookingDAO(); List<Booking> allBookings = bookingDAO.getAllBookings();

                /* --- STATISTICS (extra content) --- */
                int totalBookings = allBookings.size();
                int pendingCount = 0;
                int approvedCount = 0;
                int rejectedCount = 0;
                for (Booking b : allBookings) {
                switch (b.getStatus()) {
                case "Pending": pendingCount++; break;
                case "Approved": approvedCount++; break;
                case "Rejected": rejectedCount++; break;
                }
                }
                %>

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

                    @keyframes slideInRight {
                        0% {
                            opacity: 0;
                            transform: translateX(30px);
                        }

                        100% {
                            opacity: 1;
                            transform: translateX(0);
                        }
                    }

                    @keyframes float {
                        0% {
                            transform: translateY(0);
                        }

                        50% {
                            transform: translateY(-6px);
                        }

                        100% {
                            transform: translateY(0);
                        }
                    }

                    /* ----- ANIMATION CLASSES ----- */
                    .fade-in {
                        animation: fadeIn 1s ease forwards;
                    }

                    .fade-up {
                        opacity: 0;
                        animation: fadeUp 0.8s cubic-bezier(0.23, 1, 0.32, 1) forwards;
                    }

                    .slide-right {
                        opacity: 0;
                        animation: slideInRight 0.7s ease forwards;
                    }

                    /* DELAYS */
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
                        background: linear-gradient(145deg, #f9f5f0, #f0ebe5);
                        font-family: 'Inter', sans-serif;
                    }

                    /* ----- PAGE HEADER WITH BACKGROUND IMAGE ----- */
                    .page-header {
                        background: linear-gradient(105deg, rgba(212, 175, 55, 0.15), rgba(255, 255, 255, 0.5)),
                            url('https://images.unsplash.com/photo-1585747860715-2ba37f78886c?ixlib=rb-4.0.3&auto=format&fit=crop&w=2074&q=80');
                        background-size: cover;
                        background-position: center 30%;
                        padding: 1.8rem 2rem;
                        border-radius: 28px;
                        margin-bottom: 2rem;
                        box-shadow: 0 15px 30px rgba(0, 0, 0, 0.05);
                        border-left: 10px solid #d4af37;
                        transition: all 0.3s;
                    }

                    .page-header:hover {
                        transform: scale(1.01);
                        box-shadow: 0 20px 40px rgba(212, 175, 55, 0.15);
                    }

                    .page-header h1 {
                        font-weight: 800;
                        background: linear-gradient(145deg, #1a1a1a, #333);
                        -webkit-background-clip: text;
                        -webkit-text-fill-color: transparent;
                        text-shadow: 2px 2px 10px rgba(255, 215, 0, 0.2);
                    }

                    /* ----- STATISTICS CARDS (GRADIENT, HOVER) ----- */
                    .stat-card {
                        background: white;
                        border-radius: 20px;
                        padding: 1.5rem 1rem;
                        box-shadow: 0 8px 20px rgba(0, 0, 0, 0.02);
                        transition: all 0.3s cubic-bezier(0.23, 1, 0.32, 1);
                        border: 1px solid rgba(255, 255, 255, 0.5);
                        backdrop-filter: blur(4px);
                        position: relative;
                        overflow: hidden;
                    }

                    .stat-card::before {
                        content: '';
                        position: absolute;
                        top: 0;
                        left: 0;
                        width: 6px;
                        height: 100%;
                        background: linear-gradient(180deg, #d4af37, #b8942e);
                        transition: width 0.3s;
                    }

                    .stat-card:hover {
                        transform: translateY(-10px);
                        box-shadow: 0 20px 30px rgba(212, 175, 55, 0.15);
                    }

                    .stat-card:hover::before {
                        width: 12px;
                    }

                    .stat-icon {
                        width: 55px;
                        height: 55px;
                        background: linear-gradient(145deg, #f9e7b3, #f5d97a);
                        border-radius: 16px;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        font-size: 1.8rem;
                        color: #1e1e1e;
                        transition: all 0.3s;
                    }

                    .stat-card:hover .stat-icon {
                        background: linear-gradient(145deg, #d4af37, #b8942e);
                        transform: rotate(8deg) scale(1.1);
                        color: black;
                    }

                    /* ----- MAIN CARD (TABLE CONTAINER) ----- */
                    .table-card {
                        background: rgba(255, 255, 255, 0.85);
                        backdrop-filter: blur(10px);
                        border-radius: 28px;
                        border: 1px solid rgba(255, 255, 255, 0.6);
                        box-shadow: 0 25px 40px -10px rgba(0, 0, 0, 0.08);
                        transition: all 0.3s;
                        overflow: hidden;
                    }

                    .table-card:hover {
                        box-shadow: 0 30px 50px -10px rgba(212, 175, 55, 0.15);
                        border-color: rgba(212, 175, 55, 0.3);
                    }

                    /* ----- TABLE STYLES ----- */
                    .table {
                        margin-bottom: 0;
                    }

                    .table thead th {
                        background: linear-gradient(145deg, #2c3e50, #1e2b37);
                        color: white;
                        font-weight: 600;
                        text-transform: uppercase;
                        font-size: 0.8rem;
                        letter-spacing: 1px;
                        border-bottom: none;
                        padding: 1rem 1rem;
                        vertical-align: middle;
                    }

                    .table tbody tr {
                        transition: all 0.2s;
                        vertical-align: middle;
                    }

                    .table tbody tr:hover {
                        background: rgba(212, 175, 55, 0.05);
                        transform: scale(1.01);
                        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.02);
                    }

                    /* ----- STATUS BADGES (GRADIENT) ----- */
                    .badge-pending {
                        background: linear-gradient(145deg, #f39c12, #e67e22);
                        color: white;
                        padding: 8px 16px;
                        border-radius: 50px;
                        font-weight: 600;
                        font-size: 0.8rem;
                        box-shadow: 0 4px 10px rgba(243, 156, 18, 0.2);
                    }

                    .badge-approved {
                        background: linear-gradient(145deg, #2ecc71, #27ae60);
                        color: white;
                        padding: 8px 16px;
                        border-radius: 50px;
                        font-weight: 600;
                        font-size: 0.8rem;
                        box-shadow: 0 4px 10px rgba(46, 204, 113, 0.2);
                    }

                    .badge-rejected {
                        background: linear-gradient(145deg, #e74c3c, #c0392b);
                        color: white;
                        padding: 8px 16px;
                        border-radius: 50px;
                        font-weight: 600;
                        font-size: 0.8rem;
                        box-shadow: 0 4px 10px rgba(231, 76, 60, 0.2);
                    }

                    /* ----- ACTION BUTTONS (GRADIENT + HOVER) ----- */
                    .btn-approve {
                        background: linear-gradient(145deg, #2ecc71, #27ae60);
                        border: none;
                        color: white;
                        padding: 8px 18px;
                        border-radius: 50px;
                        font-weight: 600;
                        font-size: 0.8rem;
                        transition: all 0.3s;
                        box-shadow: 0 4px 10px rgba(46, 204, 113, 0.2);
                    }

                    .btn-approve:hover {
                        background: linear-gradient(145deg, #27ae60, #1e8449);
                        transform: scale(1.08);
                        box-shadow: 0 8px 18px rgba(46, 204, 113, 0.4);
                    }

                    .btn-reject {
                        background: linear-gradient(145deg, #e74c3c, #c0392b);
                        border: none;
                        color: white;
                        padding: 8px 18px;
                        border-radius: 50px;
                        font-weight: 600;
                        font-size: 0.8rem;
                        transition: all 0.3s;
                        box-shadow: 0 4px 10px rgba(231, 76, 60, 0.2);
                    }

                    .btn-reject:hover {
                        background: linear-gradient(145deg, #c0392b, #a8231a);
                        transform: scale(1.08);
                        box-shadow: 0 8px 18px rgba(231, 76, 60, 0.4);
                    }

                    .btn-processed {
                        background: #6c757d;
                        color: white;
                        padding: 8px 18px;
                        border-radius: 50px;
                        font-size: 0.8rem;
                        opacity: 0.8;
                        cursor: default;
                    }

                    /* ----- FILTER BAR (EXTRA) ----- */
                    .filter-bar {
                        background: white;
                        border-radius: 60px;
                        padding: 0.5rem 0.5rem 0.5rem 1.5rem;
                        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.02);
                        border: 1px solid rgba(0, 0, 0, 0.03);
                    }

                    .filter-bar input,
                    .filter-bar select {
                        border: none;
                        background: transparent;
                        padding: 0.6rem 0.8rem;
                        font-weight: 500;
                        color: #2c3e50;
                    }

                    .filter-bar input:focus,
                    .filter-bar select:focus {
                        outline: none;
                        box-shadow: none;
                        border-bottom: 2px solid #d4af37;
                    }

                    /* ----- RESPONSIVE ----- */
                    @media (max-width: 768px) {
                        .page-header {
                            padding: 1.5rem;
                        }

                        .stat-card {
                            margin-bottom: 1rem;
                        }
                    }
                </style>

                <div class="container-fluid py-4 px-lg-5">

                    <div class="page-header d-flex justify-content-between align-items-center fade-up delay-1">
                        <div>
                            <h1 class="display-6 fw-bold mb-2">📋 Appointment Requests</h1>
                            <p class="text-dark-50 mb-0" style="font-size: 1.1rem;">
                                <i class="fas fa-calendar-alt me-2" style="color: #d4af37;"></i>
                                Manage all booking requests, approve or reject appointments.
                            </p>
                        </div>
                        <div>
                            <span class="badge bg-dark bg-opacity-75 p-3 px-4 rounded-pill shadow-sm">
                                <i class="fas fa-store me-1"></i> Groomify &middot; Admin
                            </span>
                        </div>
                    </div>

                    <div class="row g-4 mb-5">
                        <div class="col-xl-3 col-md-6 fade-up delay-2">
                            <div class="stat-card d-flex align-items-center">
                                <div class="stat-icon me-3">
                                    <i class="fas fa-calendar-check"></i>
                                </div>
                                <div>
                                    <p class="text-muted mb-1 small fw-semibold">TOTAL BOOKINGS</p>
                                    <h3 class="fw-bold mb-0">
                                        <%= totalBookings %>
                                    </h3>
                                    <span class="text-success small"><i class="fas fa-arrow-up"></i> +8 this week</span>
                                </div>
                            </div>
                        </div>
                        <div class="col-xl-3 col-md-6 fade-up delay-3">
                            <div class="stat-card d-flex align-items-center">
                                <div class="stat-icon me-3">
                                    <i class="fas fa-hourglass-half"></i>
                                </div>
                                <div>
                                    <p class="text-muted mb-1 small fw-semibold">PENDING</p>
                                    <h3 class="fw-bold mb-0">
                                        <%= pendingCount %>
                                    </h3>
                                    <span class="text-warning small">awaiting decision</span>
                                </div>
                            </div>
                        </div>
                        <div class="col-xl-3 col-md-6 fade-up delay-4">
                            <div class="stat-card d-flex align-items-center">
                                <div class="stat-icon me-3">
                                    <i class="fas fa-check-circle"></i>
                                </div>
                                <div>
                                    <p class="text-muted mb-1 small fw-semibold">APPROVED</p>
                                    <h3 class="fw-bold mb-0">
                                        <%= approvedCount %>
                                    </h3>
                                    <span class="text-success small">confirmed</span>
                                </div>
                            </div>
                        </div>
                        <div class="col-xl-3 col-md-6 fade-up delay-5">
                            <div class="stat-card d-flex align-items-center">
                                <div class="stat-icon me-3">
                                    <i class="fas fa-times-circle"></i>
                                </div>
                                <div>
                                    <p class="text-muted mb-1 small fw-semibold">REJECTED</p>
                                    <h3 class="fw-bold mb-0">
                                        <%= rejectedCount %>
                                    </h3>
                                    <span class="text-danger small">cancelled</span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row mb-4 fade-up delay-3">
                        <div class="col-lg-12">
                            <div class="filter-bar d-flex align-items-center justify-content-between">
                                <div class="d-flex align-items-center flex-grow-1">
                                    <i class="fas fa-search text-secondary me-2"></i>
                                    <input type="text" class="form-control-plaintext"
                                        placeholder="Search by customer, service or therapist..." style="flex:1;">
                                </div>
                                <div class="d-flex gap-2">
                                    <select class="form-select-sm border-0 bg-transparent text-secondary fw-semibold">
                                        <option>All Status</option>
                                        <option>Pending</option>
                                        <option>Approved</option>
                                        <option>Rejected</option>
                                    </select>
                                    <button class="btn btn-sm btn-outline-dark rounded-pill px-4">
                                        <i class="fas fa-download me-1"></i> Export
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-12 fade-up delay-4">
                            <div class="table-card p-3 p-lg-4">
                                <div class="d-flex justify-content-between align-items-center mb-4">
                                    <h5 class="fw-bold mb-0"><i class="fas fa-list-alt me-2"
                                            style="color: #d4af37;"></i> All Appointment Requests</h5>
                                    <span class="text-muted small"><i class="fas fa-sync-alt me-1"></i> Updated just
                                        now</span>
                                </div>

                                <div class="table-responsive">
                                    <table class="table table-hover align-middle mb-0">
                                        <thead>
                                            <tr>
                                                <th>ID</th>
                                                <th>Customer</th>
                                                <th>Service</th>
                                                <th>Therapist</th>
                                                <th>Date</th>
                                                <th>Time</th>
                                                <th>Status</th>
                                                <th>Action</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <% if (allBookings.isEmpty()) { %>
                                                <tr>
                                                    <td colspan="8" class="text-center py-5 text-muted">
                                                        <i class="fas fa-inbox fa-3x mb-3"></i><br>
                                                        No appointment requests found.
                                                    </td>
                                                </tr>
                                                <% } else { for (Booking b : allBookings) { String badgeClass="" ;
                                                    String status=b.getStatus(); if ("Pending".equals(status))
                                                    badgeClass="badge-pending" ; else if ("Approved".equals(status))
                                                    badgeClass="badge-approved" ; else if ("Rejected".equals(status))
                                                    badgeClass="badge-rejected" ; %>
                                                    <tr>
                                                        <td><span class="fw-semibold">
                                                                <%= b.getId() %>
                                                            </span></td>
                                                        <td>
                                                            <i class="fas fa-user-circle me-2 text-secondary"></i>
                                                            <%= b.getCustomerName() %>
                                                        </td>
                                                        <td>
                                                            <%= b.getServiceName() %>
                                                        </td>
                                                        <td>
                                                            <i class="fas fa-user-tie me-1 text-secondary"></i>
                                                            <%= b.getTherapistName() %>
                                                        </td>
                                                        <td>
                                                            <%= b.getBookingDate() %>
                                                        </td>
                                                        <td><span class="badge bg-light text-dark">
                                                                <%= b.getTimeSlot() %>
                                                            </span></td>
                                                        <td>
                                                            <span class="badge <%= badgeClass %>">
                                                                <i class="fas fa-<%= " Pending".equals(status)
                                                                    ? "hourglass-half" : "Approved" .equals(status)
                                                                    ? "check-circle" : "times-circle" %> me-1"></i>
                                                                <%= status %>
                                                            </span>
                                                        </td>
                                                        <td>
                                                            <% if ("Pending".equals(status)) { %>
                                                                <form action="ApprovalServlet" method="post"
                                                                    style="display:inline;">
                                                                    <input type="hidden" name="bookingId"
                                                                        value="<%= b.getId() %>">
                                                                    <input type="hidden" name="customerEmail"
                                                                        value="<%= b.getCustomerEmail() %>">
                                                                    <input type="hidden" name="status" value="Approved">
                                                                    <button type="submit"
                                                                        class="btn btn-approve btn-sm me-1">
                                                                        <i class="fas fa-check me-1"></i>Approve
                                                                    </button>
                                                                </form>
                                                                <form action="ApprovalServlet" method="post"
                                                                    style="display:inline;">
                                                                    <input type="hidden" name="bookingId"
                                                                        value="<%= b.getId() %>">
                                                                    <input type="hidden" name="customerEmail"
                                                                        value="<%= b.getCustomerEmail() %>">
                                                                    <input type="hidden" name="status" value="Rejected">
                                                                    <button type="submit" class="btn btn-reject btn-sm">
                                                                        <i class="fas fa-times me-1"></i>Reject
                                                                    </button>
                                                                </form>
                                                                <% } else if ("Approved".equals(status)) { %>
                                                                    <a href="CancelBookingServlet?id=<%= b.getId() %>"
                                                                        class="btn btn-reject btn-sm"
                                                                        onclick="return confirm('Are you sure you want to cancel this approved appointment?');">
                                                                        <i class="fas fa-times me-1"></i>Cancel
                                                                    </a>
                                                                    <% } else { %>
                                                                        <span class="btn-processed btn-sm">
                                                                            <i
                                                                                class="fas fa-check-double me-1"></i>Processed
                                                                        </span>
                                                                        <% } %>
                                                        </td>
                                                    </tr>
                                                    <% } } %>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <%@ include file="footer.jsp" %>