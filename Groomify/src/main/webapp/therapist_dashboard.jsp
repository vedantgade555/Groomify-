<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ include file="header.jsp" %>
        <%@ page import="dao.BookingDAO, model.Booking, model.Therapist, java.util.List, java.util.ArrayList" %>

            <% /* --- SESSION CHECK --- */ Therapist therapist=(Therapist) session.getAttribute("therapist"); if
                (therapist==null) { response.sendRedirect("therapist_login.jsp"); return; } /* --- FETCH ALL BOOKINGS &
                FILTER BY THERAPIST ID --- */ BookingDAO bookingDAO=new BookingDAO(); List<Booking> allBookings =
                bookingDAO.getAllBookings();
                List<Booking> mySchedule = new ArrayList<>();

                        for (Booking b : allBookings) {
                        if (b.getTherapistId() == therapist.getId()) {
                        mySchedule.add(b);
                        }
                        }

                        /* --- STATISTICS --- */
                        int total = mySchedule.size();
                        int pending = 0, approved = 0, rejected = 0, completed = 0;
                        double totalRevenue = 0;
                        double expectedRevenue = 0;

                        for (Booking b : mySchedule) {
                        String status = b.getStatus();
                        if ("Pending".equals(status)) {
                        pending++;
                        } else if ("Approved".equals(status) || "Confirmed".equals(status)) {
                        approved++;
                        expectedRevenue += b.getServicePrice();
                        } else if ("Rejected".equals(status) || "Cancelled".equals(status)) {
                        rejected++;
                        } else if ("Completed".equals(status)) {
                        completed++;
                        totalRevenue += b.getServicePrice();
                        }
                        }
                        %>

                        <style>
                            /* ----- KEYFRAMES ----- */
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

                            @keyframes fadeIn {
                                0% {
                                    opacity: 0;
                                }

                                100% {
                                    opacity: 1;
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

                            .fade-up {
                                opacity: 0;
                                animation: fadeUp 0.8s cubic-bezier(0.23, 1, 0.32, 1) forwards;
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
                                background: linear-gradient(145deg, #f9f5f0, #f0ebe5);
                                font-family: 'Inter', sans-serif;
                                position: relative;
                            }

                            body::before {
                                content: '';
                                position: fixed;
                                top: 0;
                                left: 0;
                                width: 100%;
                                height: 100%;
                                background-image: url('https://images.unsplash.com/photo-1560066984-138dadb4c035?ixlib=rb-4.0.3&auto=format&fit=crop&w=2070&q=80');
                                background-size: cover;
                                background-position: center;
                                opacity: 0.03;
                                pointer-events: none;
                                z-index: -1;
                            }

                            /* ----- THERAPIST PROFILE HEADER ----- */
                            .profile-header {
                                background: linear-gradient(105deg, rgba(212, 175, 55, 0.15), rgba(255, 255, 255, 0.7)),
                                    url('https://images.unsplash.com/photo-1585747860715-2ba37f78886c?ixlib=rb-4.0.3&auto=format&fit=crop&w=2074&q=80');
                                background-size: cover;
                                background-position: center 30%;
                                border-radius: 28px;
                                padding: 2rem 2.5rem;
                                margin-bottom: 2rem;
                                box-shadow: 0 15px 30px rgba(0, 0, 0, 0.05);
                                border-left: 12px solid #d4af37;
                                transition: all 0.3s;
                            }

                            .profile-header:hover {
                                transform: scale(1.01);
                                box-shadow: 0 20px 40px rgba(212, 175, 55, 0.15);
                                border-left-color: #b8942e;
                            }

                            .therapist-avatar {
                                width: 90px;
                                height: 90px;
                                border-radius: 50%;
                                border: 4px solid #d4af37;
                                box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
                                object-fit: cover;
                                transition: transform 0.3s;
                            }

                            .therapist-avatar:hover {
                                transform: scale(1.1);
                            }

                            .specialty-badge {
                                background: rgba(212, 175, 55, 0.2);
                                backdrop-filter: blur(4px);
                                border: 1px solid #d4af37;
                                color: #2c3e50;
                                padding: 0.5rem 1.5rem;
                                border-radius: 60px;
                                font-weight: 600;
                                display: inline-block;
                            }

                            /* ----- STATISTICS CARDS ----- */
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
                                transform: translateY(-8px);
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

                            /* ----- QUICK ACTIONS ----- */
                            .quick-action-btn {
                                background: white;
                                border: 1px solid rgba(0, 0, 0, 0.05);
                                border-radius: 60px;
                                padding: 0.8rem 1.8rem;
                                font-weight: 600;
                                color: #2c3e50;
                                text-decoration: none;
                                transition: all 0.3s;
                                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.02);
                            }

                            .quick-action-btn:hover {
                                background: linear-gradient(145deg, #d4af37, #b8942e);
                                color: black;
                                border-color: transparent;
                                transform: translateY(-3px);
                                box-shadow: 0 12px 25px rgba(212, 175, 55, 0.3);
                            }

                            /* ----- SCHEDULE CARD & TABLE ----- */
                            .schedule-card {
                                background: rgba(255, 255, 255, 0.9);
                                backdrop-filter: blur(10px);
                                border-radius: 28px;
                                border: 1px solid rgba(255, 255, 255, 0.6);
                                box-shadow: 0 25px 40px -10px rgba(0, 0, 0, 0.08);
                                transition: all 0.3s;
                                overflow: hidden;
                            }

                            .schedule-card:hover {
                                box-shadow: 0 30px 50px -10px rgba(212, 175, 55, 0.15);
                                border-color: rgba(212, 175, 55, 0.3);
                            }

                            .card-header-gradient {
                                background: linear-gradient(145deg, #2c3e50, #1e2b37);
                                padding: 1.5rem 2rem;
                                border-bottom: 5px solid #d4af37;
                            }

                            .table thead th {
                                background: linear-gradient(145deg, #f8f9fa, #e9ecef);
                                color: #2c3e50;
                                font-weight: 700;
                                text-transform: uppercase;
                                font-size: 0.8rem;
                                letter-spacing: 1px;
                                border-bottom: 3px solid #d4af37;
                            }

                            .table tbody tr:hover {
                                background: rgba(212, 175, 55, 0.05);
                                transform: scale(1.01);
                            }

                            /* ----- CUSTOM BADGES ----- */
                            .badge-pending {
                                background: linear-gradient(145deg, #f39c12, #e67e22);
                                color: white;
                                padding: 8px 16px;
                                border-radius: 50px;
                                font-weight: 600;
                                font-size: 0.8rem;
                            }

                            .badge-approved {
                                background: linear-gradient(145deg, #2ecc71, #27ae60);
                                color: white;
                                padding: 8px 16px;
                                border-radius: 50px;
                                font-weight: 600;
                                font-size: 0.8rem;
                            }

                            .badge-rejected {
                                background: linear-gradient(145deg, #e74c3c, #c0392b);
                                color: white;
                                padding: 8px 16px;
                                border-radius: 50px;
                                font-weight: 600;
                                font-size: 0.8rem;
                            }

                            .badge-completed {
                                background: linear-gradient(145deg, #3498db, #2980b9);
                                color: white;
                                padding: 8px 16px;
                                border-radius: 50px;
                                font-weight: 600;
                                font-size: 0.8rem;
                            }

                            .empty-state {
                                padding: 4rem 2rem;
                                text-align: center;
                                color: #6c757d;
                            }

                            .empty-state i {
                                font-size: 4rem;
                                color: #d4af37;
                                opacity: 0.5;
                                margin-bottom: 1rem;
                            }

                            /* ----- BUTTON GRADIENT ----- */
                            .btn-gradient {
                                background: linear-gradient(145deg, #d4af37, #b8942e);
                                border: none;
                                color: black;
                                font-weight: 700;
                                padding: 12px 28px;
                                border-radius: 60px;
                                letter-spacing: 1px;
                                transition: all 0.3s;
                                text-decoration: none;
                            }

                            .btn-gradient:hover {
                                background: linear-gradient(145deg, #e6c468, #c9a341);
                                transform: scale(1.05);
                                color: black;
                            }

                            @media (max-width: 768px) {
                                .profile-header {
                                    padding: 1.5rem;
                                    flex-direction: column;
                                    text-align: center;
                                }
                            }
                        </style>

                        <div class="container-fluid py-4 px-lg-5">

                            <div
                                class="profile-header d-flex flex-wrap align-items-center justify-content-between fade-up delay-1">
                                <div class="d-flex align-items-center gap-4 mb-3 mb-md-0">
                                    <img src="img/user-male-1.jpg" alt="<%= therapist.getName() %>"
                                        class="therapist-avatar" onerror="this.src='https://via.placeholder.com/90'">
                                    <div>
                                        <h1 class="display-6 fw-bold mb-1" style="color: #1e2b37;">
                                            Welcome, <%= therapist.getName() %>!
                                        </h1>
                                        <div class="d-flex flex-wrap align-items-center gap-3 mt-2">
                                            <span class="specialty-badge">
                                                <i class="fas fa-user-tie me-2" style="color: #d4af37;"></i>
                                                <%= therapist.getSpecialty() !=null ? therapist.getSpecialty()
                                                    : "Therapist" %>
                                            </span>
                                            <span class="specialty-badge">
                                                <i class="fas fa-star text-warning me-2"></i>
                                                Rating: <%= therapist.getRating() !=0 ? String.format("%.1f",
                                                    therapist.getRating()) : "4.9" %>/5.0
                                            </span>
                                        </div>
                                    </div>
                                </div>
                                <div>
                                    <span class="badge bg-dark bg-opacity-75 p-3 px-4 rounded-pill shadow-sm fs-6">
                                        <i class="fas fa-calendar-alt me-2" style="color: #d4af37;"></i>
                                        <%= new java.text.SimpleDateFormat("EEEE, MMM d, yyyy").format(new
                                            java.util.Date()) %>
                                    </span>
                                </div>
                            </div>

                            <div class="row g-4 mb-5">
                                <div class="col-xl-3 col-md-6 fade-up delay-2">
                                    <div class="stat-card d-flex align-items-center">
                                        <div class="stat-icon me-3"><i class="fas fa-calendar-check"></i></div>
                                        <div>
                                            <p class="text-muted mb-1 small fw-semibold">TOTAL APPOINTMENTS</p>
                                            <h3 class="fw-bold mb-0">
                                                <%= total %>
                                            </h3>
                                            <span class="text-success small">assigned to you</span>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-xl-3 col-md-6 fade-up delay-3">
                                    <div class="stat-card d-flex align-items-center">
                                        <div class="stat-icon me-3"
                                            style="background: linear-gradient(145deg, #cdfcd3, #99f7a7); color: #155724;">
                                            <i class="fas fa-coins"></i>
                                        </div>
                                        <div>
                                            <p class="text-muted mb-1 small fw-semibold">EARNED REVENUE</p>
                                            <h3 class="fw-bold mb-0">₹<%= String.format("%.0f", totalRevenue) %>
                                            </h3>
                                            <span class="text-success small">excluding tokens</span>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-xl-3 col-md-6 fade-up delay-4">
                                    <div class="stat-card d-flex align-items-center">
                                        <div class="stat-icon me-3"
                                            style="background: linear-gradient(145deg, #d4ebf2, #aedef4); color: #0c5460;">
                                            <i class="fas fa-hand-holding-usd"></i>
                                        </div>
                                        <div>
                                            <p class="text-muted mb-1 small fw-semibold">EXPECTED</p>
                                            <h3 class="fw-bold mb-0">₹<%= String.format("%.0f", expectedRevenue) %>
                                            </h3>
                                            <span class="text-info small">from confirmed</span>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Additional Stats Row -->
                            <div class="row g-4 mb-5">
                                <div class="col-xl-3 col-md-6 fade-up delay-2">
                                    <div class="stat-card d-flex align-items-center">
                                        <div class="stat-icon me-3"><i class="fas fa-hourglass-half"></i></div>
                                        <div>
                                            <p class="text-muted mb-1 small fw-semibold">PENDING</p>
                                            <h3 class="fw-bold mb-0">
                                                <%= pending %>
                                            </h3>
                                            <span class="text-warning small">awaiting confirmation</span>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-xl-3 col-md-6 fade-up delay-3">
                                    <div class="stat-card d-flex align-items-center">
                                        <div class="stat-icon me-3"><i class="fas fa-check-circle"></i></div>
                                        <div>
                                            <p class="text-muted mb-1 small fw-semibold">APPROVED</p>
                                            <h3 class="fw-bold mb-0">
                                                <%= approved %>
                                            </h3>
                                            <span class="text-success small">to be served</span>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-xl-3 col-md-6 fade-up delay-4">
                                    <div class="stat-card d-flex align-items-center">
                                        <div class="stat-icon me-3"
                                            style="background: linear-gradient(145deg, #d1ecf1, #bee5eb);"><i
                                                class="fas fa-flag-checkered"></i></div>
                                        <div>
                                            <p class="text-muted mb-1 small fw-semibold">COMPLETED</p>
                                            <h3 class="fw-bold mb-0">
                                                <%= completed %>
                                            </h3>
                                            <span class="text-info small">work done</span>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-xl-3 col-md-6 fade-up delay-5">
                                    <div class="stat-card d-flex align-items-center">
                                        <div class="stat-icon me-3"><i class="fas fa-times-circle"></i></div>
                                        <div>
                                            <p class="text-muted mb-1 small fw-semibold">REJECTED</p>
                                            <h3 class="fw-bold mb-0">
                                                <%= rejected %>
                                            </h3>
                                            <span class="text-danger small">cancelled</span>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div
                                class="d-flex flex-wrap justify-content-between align-items-center mb-4 fade-up delay-3">
                                <h5 class="fw-bold mb-3 mb-md-0"><i class="fas fa-bolt me-2"
                                        style="color: #d4af37;"></i> Quick Actions</h5>
                                <div class="d-flex gap-3">
                                    <a href="therapist_availability.jsp" class="quick-action-btn">
                                        <i class="fas fa-clock me-2"></i> Mark Availability
                                    </a>
                                    <a href="therapist_calendar.jsp" class="quick-action-btn">
                                        <i class="fas fa-calendar-alt me-2"></i> View Calendar
                                    </a>
                                </div>
                            </div>

                            <div class="row fade-up delay-4">
                                <div class="col-12">
                                    <div class="schedule-card">
                                        <div
                                            class="card-header-gradient d-flex justify-content-between align-items-center">
                                            <h5 class="fw-bold mb-0 text-white">
                                                <i class="fas fa-list-alt me-2" style="color: #d4af37;"></i> My
                                                Appointment Schedule
                                            </h5>
                                            <span class="text-white-50 small">
                                                <i class="fas fa-sync-alt me-1"></i> Live updates
                                            </span>
                                        </div>

                                        <div class="card-body p-0 p-md-4">
                                            <div class="table-responsive">
                                                <table class="table table-hover align-middle mb-0">
                                                    <thead>
                                                        <tr>
                                                            <th>Date</th>
                                                            <th>Time</th>
                                                            <th>Service</th>
                                                            <th>Customer</th>
                                                            <th>Status</th>
                                                            <th>Action</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <% if(mySchedule.isEmpty()) { %>
                                                            <tr>
                                                                <td colspan="5" class="empty-state">
                                                                    <i class="fas fa-calendar-times"></i>
                                                                    <h5 class="mt-3">No appointments scheduled</h5>
                                                                    <p class="text-muted">Your schedule is clear. Mark
                                                                        your availability to receive bookings.</p>
                                                                    <a href="therapist_availability.jsp"
                                                                        class="btn btn-gradient mt-2 d-inline-block">
                                                                        <i class="fas fa-plus-circle me-2"></i>Set
                                                                        Availability
                                                                    </a>
                                                                </td>
                                                            </tr>
                                                            <% } else { for(Booking b : mySchedule) { String
                                                                badgeClass="" ; String iconClass="" ; String
                                                                status=b.getStatus(); if ("Pending".equals(status)) {
                                                                badgeClass="badge-pending" ;
                                                                iconClass="fa-hourglass-half" ; } else if
                                                                ("Approved".equals(status) || "Confirmed"
                                                                .equals(status)) { badgeClass="badge-approved" ;
                                                                iconClass="fa-check-circle" ; } else if
                                                                ("Completed".equals(status)) {
                                                                badgeClass="badge-completed" ;
                                                                iconClass="fa-check-double" ; } else {
                                                                badgeClass="badge-rejected" ;
                                                                iconClass="fa-times-circle" ; } %>
                                                                <tr>
                                                                    <td>
                                                                        <i
                                                                            class="fas fa-calendar-day me-2 text-secondary"></i>
                                                                        <%= b.getBookingDate() %>
                                                                    </td>
                                                                    <td>
                                                                        <span class="badge bg-light text-dark border">
                                                                            <i class="fas fa-clock me-1"></i>
                                                                            <%= b.getTimeSlot() %>
                                                                        </span>
                                                                    </td>
                                                                    <td>
                                                                        <span class="fw-semibold">
                                                                            <%= b.getServiceName() %>
                                                                        </span>
                                                                    </td>
                                                                    <td>
                                                                        <i
                                                                            class="fas fa-user-circle me-2 text-secondary"></i>
                                                                        <%= b.getCustomerName() %>
                                                                    </td>
                                                                    <td>
                                                                        <span class="badge <%= badgeClass %>">
                                                                            <i class="fas <%= iconClass %> me-1"></i>
                                                                            <%= status %>
                                                                        </span>
                                                                    </td>
                                                                    <td>
                                                                        <% if ("Approved".equals(status) || "Confirmed"
                                                                            .equals(status)) { %>
                                                                            <form action="WorkDoneServlet"
                                                                                method="POST">
                                                                                <input type="hidden" name="bookingId"
                                                                                    value="<%= b.getId() %>">
                                                                                <button type="submit"
                                                                                    class="btn btn-sm btn-success rounded-pill px-3 fw-bold">
                                                                                    <i class="fas fa-check me-1"></i>
                                                                                    Work Done
                                                                                </button>
                                                                            </form>
                                                                            <% } else if ("Completed".equals(status)) {
                                                                                %>
                                                                                <span
                                                                                    class="text-success small fw-bold"><i
                                                                                        class="fas fa-check-double me-1"></i>
                                                                                    Finished</span>
                                                                                <% } else { %>
                                                                                    <span
                                                                                        class="text-muted small">N/A</span>
                                                                                    <% } %>
                                                                    </td>
                                                                </tr>
                                                                <% } } %>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>

                                        <% if(!mySchedule.isEmpty()) { %>
                                            <div class="card-footer bg-light border-0 text-end p-3">
                                                <small class="text-muted fw-semibold">
                                                    <i class="fas fa-info-circle me-1"></i>
                                                    <span class="text-success">
                                                        <%= completed %> completed
                                                    </span> &middot;
                                                    <span class="text-primary">
                                                        <%= approved %> to be served
                                                    </span> &middot;
                                                    <span class="text-warning">
                                                        <%= pending %> pending
                                                    </span> &middot;
                                                    <span class="text-danger">
                                                        <%= rejected %> rejected
                                                    </span>
                                                </small>
                                            </div>
                                            <% } %>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <%@ include file="footer.jsp" %>