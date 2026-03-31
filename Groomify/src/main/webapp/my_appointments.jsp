<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<%@ page import="dao.BookingDAO, model.Booking, model.Customer, java.util.List" %>

<%
    // --- SESSION CHECK ---
    Customer user = (Customer) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("customer_login.jsp");
        return;
    }

    // --- FETCH BOOKINGS ---
    BookingDAO bookingDAO = new BookingDAO();
    List<Booking> bookings = bookingDAO.getBookingsByCustomer(user.getId());
%>

<style>
    /* ----- KEYFRAMES & ANIMATIONS ----- */
    @keyframes fadeUp { 0% { opacity: 0; transform: translateY(30px); } 100% { opacity: 1; transform: translateY(0); } }
    .fade-up { opacity: 0; animation: fadeUp 0.8s cubic-bezier(0.23, 1, 0.32, 1) forwards; }
    .delay-1 { animation-delay: 0.1s; }
    .delay-2 { animation-delay: 0.2s; }

    /* ----- GLOBAL & BACKGROUND ----- */
    body { background: linear-gradient(145deg, #f9f5f0, #f0ebe5); font-family: 'Inter', sans-serif; }

    .page-header {
        background: linear-gradient(105deg, rgba(212,175,55,0.15), rgba(0,0,0,0.5)),
                    url('https://images.unsplash.com/photo-1560066984-138dadb4c035?ixlib=rb-4.0.3&auto=format&fit=crop&w=2070&q=80');
        background-size: cover; background-position: center 30%; padding: 1.8rem 2rem;
        border-radius: 28px; margin-bottom: 2rem; border-left: 10px solid #ff6b6b; color: white;
    }
    .page-header h1 { font-weight: 800; text-shadow: 1px 1px 3px rgba(0,0,0,0.5); }

    .table-card {
        background: rgba(255,255,255,0.85); backdrop-filter: blur(10px);
        border-radius: 28px; border: 1px solid rgba(255,255,255,0.6);
        box-shadow: 0 25px 40px -10px rgba(0,0,0,0.08); overflow: hidden;
    }

    .table thead th { background: linear-gradient(145deg, #2c3e50, #1e2b37); color: white; padding: 1rem; border: none; }
    .table tbody tr:hover { background: rgba(255,107,107,0.05); transform: scale(1.01); }
    .table td { padding: 1rem; font-weight: 500; color: #495057; }

    .badge-status { padding: 6px 12px; border-radius: 50px; font-weight: 600; text-transform: capitalize; }
    .status-pending { background: rgba(241, 196, 15, 0.1); color: #f39c12; border: 1px solid rgba(241, 196, 15, 0.3); }
    .status-approved { background: rgba(46, 204, 113, 0.1); color: #27ae60; border: 1px solid rgba(46, 204, 113, 0.3); }
    .status-completed { background: rgba(52, 152, 219, 0.1); color: #2980b9; border: 1px solid rgba(52, 152, 219, 0.3); }
    .status-cancelled { background: rgba(231, 76, 60, 0.1); color: #c0392b; border: 1px solid rgba(231, 76, 60, 0.3); }
</style>

<div class="container-fluid py-4 px-lg-5">
    <div class="page-header d-flex justify-content-between align-items-center fade-up delay-1">
        <div>
            <h1 class="display-6 fw-bold mb-2">📅 My Appointments</h1>
            <p class="text-light mb-0" style="font-size: 1.1rem; text-shadow: 1px 1px 2px rgba(0,0,0,0.5);">View and track your salon bookings.</p>
        </div>
        <div>
            <a href="index.jsp" class="btn btn-light rounded-pill fw-bold"><i class="fas fa-home me-2"></i>Back to Home</a>
        </div>
    </div>

    <div class="row fade-up delay-2">
        <div class="col-12">
            <div class="table-card p-4">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h5 class="fw-bold mb-0"><i class="fas fa-history me-2" style="color: #ff6b6b;"></i> Booking History</h5>
                    <a href="book_appointment.jsp" class="btn btn-primary rounded-pill"><i class="fas fa-plus me-1"></i> New Booking</a>
                </div>

                <%-- Display Messages --%>
                <% if (session.getAttribute("message") != null) { %>
                    <div class="alert alert-success alert-dismissible fade show rounded-pill px-4 mb-4" role="alert">
                        <strong>Success!</strong> <%= session.getAttribute("message") %>
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                <% session.removeAttribute("message"); } %>
                <% if (session.getAttribute("error") != null) { %>
                    <div class="alert alert-danger alert-dismissible fade show rounded-pill px-4 mb-4" role="alert">
                        <strong>Error!</strong> <%= session.getAttribute("error") %>
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                <% session.removeAttribute("error"); } %>

                <div class="table-responsive rounded-3">
                    <table class="table table-hover mb-0">
                        <thead>
                            <tr>
                                <th>Booking ID</th>
                                <th>Service</th>
                                <th>Therapist</th>
                                <th>Date</th>
                                <th>Time</th>
                                <th>Status</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% if (bookings == null || bookings.isEmpty()) { %>
                                <tr>
                                    <td colspan="7" class="text-center py-5 text-muted">
                                        <i class="fas fa-calendar-times fa-3x mb-3 opacity-50"></i><br>
                                        You don't have any appointments booked yet.
                                    </td>
                                </tr>
                            <% } else { 
                                for(Booking b : bookings) { 
                                    String statusClass = "status-pending";
                                    if ("Approved".equalsIgnoreCase(b.getStatus()) || "Confirmed".equalsIgnoreCase(b.getStatus())) statusClass = "status-approved";
                                    else if ("Completed".equalsIgnoreCase(b.getStatus())) statusClass = "status-completed";
                                    else if ("Cancelled".equalsIgnoreCase(b.getStatus()) || "Declined".equalsIgnoreCase(b.getStatus())) statusClass = "status-cancelled";
                            %>
                                <tr>
                                    <td><span class="badge bg-light text-dark border border-secondary">#<%= b.getId() %></span></td>
                                    <td class="fw-bold text-dark"><%= b.getServiceName() %></td>
                                    <td><i class="fas fa-user-md me-2 text-secondary"></i><%= b.getTherapistName() %></td>
                                    <td><i class="fas fa-calendar-day me-2 text-primary"></i><%= b.getBookingDate() %></td>
                                    <td><i class="fas fa-clock me-2 text-info"></i><%= b.getTimeSlot() %></td>
                                    <td><span class="badge-status <%= statusClass %>"><%= b.getStatus() %></span></td>
                                    <td>
                                        <% if (!"Cancelled".equalsIgnoreCase(b.getStatus()) && !"Completed".equalsIgnoreCase(b.getStatus())) { %>
                                            <a href="CancelBookingServlet?id=<%= b.getId() %>" 
                                               class="btn btn-sm btn-outline-danger rounded-pill fw-bold px-3"
                                               onclick="return confirm('Are you sure you want to cancel this appointment? Note: Full refund if within 30 mins, 50% refund after 30 mins.');">
                                                <i class="fas fa-times me-1"></i> Cancel
                                            </a>
                                        <% } else { %>
                                            <span class="text-muted small">No action</span>
                                        <% } %>
                                    </td>
                                </tr>
                            <%  } 
                               } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="footer.jsp" %>