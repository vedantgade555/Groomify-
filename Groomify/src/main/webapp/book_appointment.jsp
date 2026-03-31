<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <%@ include file="header.jsp" %>
            <%@ page import="dao.ServiceDAO, dao.TherapistDAO, model.Service, model.Therapist, java.util.List" %>

                <% /* --- SESSION CHECK --- */ if (session.getAttribute("user")==null) {
                    response.sendRedirect("customer_login.jsp"); return; } /* --- FETCH SERVICES & THERAPISTS --- */
                    ServiceDAO serviceDAO=new ServiceDAO(); List<Service> services = serviceDAO.getAllServices();

                    TherapistDAO therapistDAO = new TherapistDAO();
                    List<Therapist> therapists = therapistDAO.getAllTherapists();
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
                                background: linear-gradient(135deg, rgba(0, 0, 0, 0.6), rgba(0, 0, 0, 0.4)),
                                    url('https://images.unsplash.com/photo-1560066984-138dadb4c035?ixlib=rb-4.0.3&auto=format&fit=crop&w=2070&q=80');
                                background-size: cover;
                                background-position: center;
                                background-attachment: fixed;
                                font-family: 'Inter', sans-serif;
                            }

                            .welcome-panel {
                                background: linear-gradient(145deg, rgba(0, 0, 0, 0.75), rgba(0, 0, 0, 0.85)),
                                    url('https://images.unsplash.com/photo-1585747860715-2ba37f78886c?ixlib=rb-4.0.3&auto=format&fit=crop&w=2074&q=80');
                                background-size: cover;
                                background-position: center;
                                border-radius: 32px;
                                padding: 2.5rem;
                                height: 100%;
                                min-height: 600px;
                                display: flex;
                                flex-direction: column;
                                justify-content: center;
                                color: white;
                                border: 1px solid rgba(255, 255, 255, 0.1);
                                box-shadow: 0 30px 50px rgba(0, 0, 0, 0.3);
                            }

                            .welcome-panel h1 {
                                font-size: 3.2rem;
                                font-weight: 800;
                                animation: float 6s infinite ease-in-out;
                            }

                            .gold-text {
                                color: #d4af37;
                                text-shadow: 0 0 15px rgba(212, 175, 55, 0.5);
                            }

                            .feature-badge {
                                background: rgba(255, 255, 255, 0.1);
                                backdrop-filter: blur(4px);
                                padding: 0.7rem 1.2rem;
                                border-radius: 60px;
                                font-weight: 500;
                                border: 1px solid rgba(255, 255, 255, 0.2);
                            }

                            .booking-card {
                                background: rgba(255, 255, 255, 0.9);
                                backdrop-filter: blur(12px);
                                border-radius: 32px;
                                border: 1px solid rgba(255, 255, 255, 0.3);
                                box-shadow: 0 25px 50px rgba(0, 0, 0, 0.1);
                                overflow: hidden;
                            }

                            .booking-header {
                                background: linear-gradient(145deg, #ff6b6b, #ee5253);
                                padding: 2rem 1.5rem;
                                border-bottom: 5px solid #d4af37;
                                position: relative;
                            }

                            .form-floating>.form-control,
                            .form-floating>.form-select {
                                border-radius: 50px !important;
                                border: 2px solid #e9ecef;
                                padding: 1.2rem 1.2rem;
                                height: calc(3.8rem + 2px);
                                font-weight: 500;
                            }

                            .form-floating>label {
                                padding-left: 1.2rem;
                                font-weight: 500;
                                color: #6c757d;
                            }

                            .btn-gradient {
                                background: linear-gradient(145deg, #ff6b6b, #ee5253);
                                border: none;
                                color: white;
                                font-weight: 700;
                                padding: 16px 28px;
                                border-radius: 60px;
                            }

                            .token-box {
                                background: rgba(212, 175, 55, 0.1);
                                border: 2px dashed #d4af37;
                                border-radius: 20px;
                                padding: 20px;
                                text-align: center;
                                margin-bottom: 2rem;
                            }

                            .token-amount {
                                font-size: 2.5rem;
                                font-weight: 800;
                                color: #d4af37;
                                display: block;
                            }

                            .token-label {
                                font-size: 1rem;
                                font-weight: 600;
                                color: #6c757d;
                                text-transform: uppercase;
                                letter-spacing: 1px;
                            }
                        </style>

                        <div class="container-fluid py-5 px-4">
                            <div class="row justify-content-center align-items-stretch g-5">

                                <div class="col-lg-5 d-flex fade-up delay-1">
                                    <div class="welcome-panel w-100">
                                        <h1 class="display-3 fw-bold">Book Your<br><span
                                                class="gold-text">Pampering</span></h1>
                                        <p class="lead fs-3 mt-3" style="font-weight: 500;">Hey,
                                            <span style="color: #ff6b6b;">
                                                <%= session.getAttribute("user") !=null ? session.getAttribute("user")
                                                    : "Guest" %>
                                            </span>!
                                        </p>
                                        <div class="mt-5 d-flex flex-column gap-3">
                                            <div class="feature-badge"><i class="fas fa-check-circle me-3"
                                                    style="color: #d4af37;"></i> 100% hygienic &amp; organic products
                                            </div>
                                            <div class="feature-badge"><i class="fas fa-user-tie me-3"
                                                    style="color: #d4af37;"></i> Expert therapists (avg. 8+ years)</div>
                                            <div class="feature-badge"><i class="fas fa-clock me-3"
                                                    style="color: #d4af37;"></i> Flexible scheduling &amp; instant
                                                confirmation</div>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-lg-7 d-flex fade-up delay-2">
                                    <div class="booking-card w-100">
                                        <div class="booking-header text-white text-center">
                                            <h2 class="h2 fw-bold mb-0">Book Appointment</h2>
                                        </div>

                                        <div class="card-body p-4 p-xl-5">
                                            <c:if test="${not empty errorMessage}">
                                                <div class="alert alert-danger rounded-pill mb-4">${errorMessage}</div>
                                            </c:if>

                                            <form action="BookingServlet" method="post" id="bookingForm">

                                                <div id="bookingDetails">
                                                    <div class="form-floating mb-4 fade-up delay-2">
                                                        <select class="form-select" id="serviceId" name="serviceId"
                                                            required>
                                                            <option value="" selected disabled>-- Choose Service --
                                                            </option>
                                                            <% for(Service s : services) { %>
                                                                <option value="<%= s.getId() %>">
                                                                    <%= s.getServiceName() %> - Rs <%=
                                                                            String.format("%.0f", s.getPrice()) %> (<%=
                                                                                s.getDuration() %> mins)
                                                                </option>
                                                                <% } %>
                                                        </select>
                                                        <label for="serviceId">Select Service</label>
                                                    </div>

                                                    <div class="form-floating mb-4 fade-up delay-3">
                                                        <select class="form-select" id="therapistId" name="therapistId"
                                                            required>
                                                            <option value="" selected disabled>-- Choose Therapist --
                                                            </option>
                                                            <% for(Therapist t : therapists) { %>
                                                                <option value="<%= t.getId() %>">
                                                                    <%= t.getName() %> - Rating: <%=
                                                                            String.format("%.1f", t.getRating()) %> /
                                                                            5.0
                                                                </option>
                                                                <% } %>
                                                        </select>
                                                        <label for="therapistId">Select Therapist</label>
                                                    </div>

                                                    <div class="form-floating mb-4 fade-up delay-4">
                                                        <input type="date" class="form-control" id="bookingDate"
                                                            name="bookingDate" required>
                                                        <label for="bookingDate">Date</label>
                                                    </div>

                                                    <div class="form-floating mb-4 fade-up delay-5">
                                                        <select class="form-select" id="timeSlot" name="timeSlot"
                                                            required>
                                                            <option value="09:00 AM">09:00 AM</option>
                                                            <option value="10:00 AM">10:00 AM</option>
                                                            <option value="11:00 AM">11:00 AM</option>
                                                            <option value="12:00 PM">12:00 PM</option>
                                                            <option value="01:00 PM">01:00 PM</option>
                                                            <option value="02:00 PM">02:00 PM</option>
                                                            <option value="03:00 PM">03:00 PM</option>
                                                            <option value="04:00 PM">04:00 PM</option>
                                                            <option value="05:00 PM">05:00 PM</option>
                                                        </select>
                                                        <label for="timeSlot">Time Slot</label>
                                                    </div>

                                                    <div class="d-grid gap-2 mt-5 fade-up delay-5">
                                                        <button class="btn btn-gradient btn-lg" type="button"
                                                            onclick="showPayment()">Proceed to Payment</button>
                                                    </div>
                                                </div>

                                                <div id="paymentDetails" style="display: none;" class="fade-up">
                                                    <div class="text-center mb-4">
                                                        <h4 class="fw-bold">Secure Payment</h4>
                                                        <p class="text-muted">Pay a small token amount to confirm your
                                                            booking.</p>
                                                    </div>

                                                    <div class="token-box">
                                                        <span class="token-label">Amount to Pay</span>
                                                        <span class="token-amount" id="displayPrice">₹ 0</span>
                                                        <input type="hidden" name="tokenAmount" id="tokenAmountInput"
                                                            value="0">
                                                    </div>

                                                    <%-- <div
                                                        class="alert alert-info border-0 rounded-4 mb-4 text-center">
                                                        <i class="fas fa-info-circle me-2"></i> This is a secure dummy
                                                        payment for demonstration.
                                                </div>
                                                --%>
                                                <div class="d-grid gap-2">
                                                    <button class="btn btn-gradient btn-lg" type="submit">
                                                        <i class="fas fa-lock me-2"></i> Pay Now & Book
                                                    </button>
                                                    <button class="btn btn-link text-muted" type="button"
                                                        onclick="hidePayment()">
                                                        Go Back
                                                    </button>
                                                </div>
                                        </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                        </div>

                        <script>
                            /* Prevent users from selecting past dates */
                            document.getElementById('bookingDate').min = new Date().toISOString().split("T")[0];

                            /* Handle form transitions */
                            function showPayment() {
                                const form = document.getElementById('bookingForm');
                                const serviceSelect = document.getElementById('serviceId');
                                const selectedOption = serviceSelect.options[serviceSelect.selectedIndex];

                                if (selectedOption.value) {
                                    const text = selectedOption.text;
                                    const priceMatch = text.match(/Rs (\d+)/);
                                    if (priceMatch) {
                                        const price = priceMatch[1];
                                        document.getElementById('displayPrice').innerText = '₹ ' + price;
                                        document.getElementById('tokenAmountInput').value = price;
                                    }
                                }

                                if (form.checkValidity()) {
                                    document.getElementById('bookingDetails').style.display = 'none';
                                    document.getElementById('paymentDetails').style.display = 'block';
                                    document.querySelector('.booking-header h2').innerText = 'Secure Payment';
                                } else {
                                    form.reportValidity();
                                }
                            }

                            function hidePayment() {
                                document.getElementById('bookingDetails').style.display = 'block';
                                document.getElementById('paymentDetails').style.display = 'none';
                                document.querySelector('.booking-header h2').innerText = 'Book Appointment';
                            }
                        </script>

                        <%@ include file="footer.jsp" %>