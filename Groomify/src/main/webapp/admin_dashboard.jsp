<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, dao.*, model.*" %>
<%@ include file="header.jsp" %>

<% 
    /* --- SESSION CHECK --- */ 
    if (session.getAttribute("admin") == null) {
        response.sendRedirect("admin_login.jsp"); 
        return; 
    } 

    /* --- INITIALIZE DAOs --- */ 
    BookingDAO bookingDAO = new BookingDAO(); 
    TherapistDAO therapistDAO = new TherapistDAO(); 
    CustomerDAO customerDAO = new CustomerDAO(); 
    ServiceDAO serviceDAO = new ServiceDAO(); 

    /* --- FETCH DASHBOARD METRICS --- */ 
    int pendingRequests = bookingDAO.getPendingBookingsCount(); 
    int activeServices = serviceDAO.getAllServices().size(); 
    int totalTherapists = therapistDAO.getTotalTherapistsCount(); 

    /* revenueStats indices: [0]=Total, [1]=Loss, [2]=Profit */ 
    double[] revenueStats = bookingDAO.getRevenueStats(); 

    /* --- FETCH LISTS --- */ 
    List<Booking> recentBookings = bookingDAO.getAllBookings();
    List<Therapist> allTherapists = therapistDAO.getAllTherapists();
    List<Customer> allCustomers = customerDAO.getAllCustomers();
    List<Service> allServices = serviceDAO.getAllServices();
%>

<style>
    .dashboard-sidebar {
        background: linear-gradient(180deg, #1f2937, #111827);
        padding: 25px;
        border-radius: 20px;
        min-height: 100vh;
        color: white;
    }
    .admin-profile {
        display: flex;
        align-items: center;
        gap: 15px;
        margin-bottom: 30px;
    }
    .admin-avatar {
        width: 60px;
        height: 60px;
        border-radius: 50%;
        border: 2px solid #d4af37;
    }
    .nav-menu {
        list-style: none;
        padding: 0;
    }
    .nav-item {
        margin-bottom: 10px;
    }
    .nav-link-custom {
        display: block;
        padding: 12px 15px;
        border-radius: 10px;
        color: white;
        text-decoration: none;
        transition: 0.3s;
        cursor: pointer;
    }
    .nav-link-custom:hover,
    .nav-link-custom.active {
        background: #d4af37;
        color: #111827;
    }
    .main-dashboard {
        background: white;
        padding: 30px;
        border-radius: 20px;
        box-shadow: 0 8px 25px rgba(0, 0, 0, 0.05);
        min-height: 80vh;
    }
    .stat-card {
        border-radius: 15px;
        border: none;
        box-shadow: 0 6px 18px rgba(0, 0, 0, 0.05);
        transition: 0.3s;
    }
    .stat-card:hover {
        transform: translateY(-5px);
    }
    .activity-table {
        background: white;
        padding: 20px;
        border-radius: 15px;
        box-shadow: 0 6px 18px rgba(0, 0, 0, 0.05);
        margin-top: 30px;
    }
    .mgmt-section {
        margin-top: 20px;
        display: none; /* Hidden by default */
    }
    .mgmt-section.active {
        display: block; /* Show active section */
    }
    .btn-action {
        padding: 5px 10px;
        font-size: 12px;
    }
</style>

<body style="background: #f8f5f0;">
    <div class="container-fluid py-4">
        <div class="row g-4">

            <div class="col-md-2">
                <div class="dashboard-sidebar">
                    <div class="admin-profile">
                        <img src="img/vedant.jpg.jpeg" class="admin-avatar" alt="Admin Avatar">
                        <div class="admin-info">
                            <h6 class="mb-0">Vedant Gade</h6>
                            <small class="text-warning">Manager</small>
                        </div>
                    </div>
                    <ul class="nav-menu">
                        <li class="nav-item">
                            <a onclick="showSection('stats')" id="link-stats" class="nav-link-custom active"><i class="fas fa-chart-line me-2"></i> Stats</a>
                        </li>
                        <li class="nav-item">
                            <a onclick="showSection('therapists')" id="link-therapists" class="nav-link-custom"><i class="fas fa-user-md me-2"></i> Therapists</a>
                        </li>
                        <li class="nav-item">
                            <a onclick="showSection('services')" id="link-services" class="nav-link-custom"><i class="fas fa-cut me-2"></i> Services</a>
                        </li>
                        <li class="nav-item">
                            <a onclick="showSection('customers')" id="link-customers" class="nav-link-custom"><i class="fas fa-users me-2"></i> Customers</a>
                        </li>
                        <li class="nav-item">
                            <a href="appointment_requests.jsp" class="nav-link-custom"><i class="fas fa-calendar-check me-2"></i> Requests</a>
                        </li>
                    </ul>
                </div>
            </div>

            <div class="col-md-10">
                <div class="main-dashboard">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <h2 class="fw-bold">Admin Dashboard ✨</h2>
                        <span class="text-muted">
                            <%= new java.util.Date() %>
                        </span>
                    </div>

                    <% if (request.getParameter("msg") != null) { %>
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                            <%= request.getParameter("msg") %>
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    <% } %>

                    <% if (request.getParameter("err") != null) { %>
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <%= request.getParameter("err") %>
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    <% } %>

                    <div id="section-stats" class="mgmt-section active">
                        <h4 class="fw-bold mb-3"><i class="fas fa-chart-pie me-2"></i> Business Overview</h4>
                        <div class="row g-3 mb-4">
                            <div class="col-md-2">
                                <div class="stat-card card text-center p-3 h-100">
                                    <small class="text-muted">PENDING</small>
                                    <h4 class="fw-bold"><%= pendingRequests %></h4>
                                </div>
                            </div>
                            <div class="col-md-2">
                                <div class="stat-card card text-center p-3 h-100">
                                    <small class="text-muted">SERVICES</small>
                                    <h4 class="fw-bold"><%= activeServices %></h4>
                                </div>
                            </div>
                            <div class="col-md-2">
                                <div class="stat-card card text-center p-3 h-100">
                                    <small class="text-muted">THERAPISTS</small>
                                    <h4 class="fw-bold"><%= totalTherapists %></h4>
                                </div>
                            </div>
                            <div class="col-md-2">
                                <div class="stat-card card text-center p-3 border-success h-100">
                                    <small class="text-success">REVENUE</small>
                                    <h4 class="fw-bold">₹<%= (int)revenueStats[0] %></h4>
                                </div>
                            </div>
                            <div class="col-md-2">
                                <div class="stat-card card text-center p-3 border-danger h-100">
                                    <small class="text-danger">LOSS (REFUNDS)</small>
                                    <h4 class="fw-bold">₹<%= (int)revenueStats[1] %></h4>
                                </div>
                            </div>
                            <div class="col-md-2">
                                <div class="stat-card card text-center p-3 h-100" style="background:#f0fff4;">
                                    <small class="text-primary">NET PROFIT</small>
                                    <h4 class="fw-bold text-primary">₹<%= (int)revenueStats[2] %></h4>
                                </div>
                            </div>
                        </div>

                        <div class="activity-table">
                            <h4 class="fw-bold mb-3"><i class="fas fa-history me-2"></i> Recent Bookings</h4>
                            <table class="table table-hover align-middle">
                                <thead class="table-light">
                                    <tr>
                                        <th>Client</th>
                                        <th>Service</th>
                                        <th>Token</th>
                                        <th>Refund (Loss)</th>
                                        <th>Status</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% 
                                        int count = 0; 
                                        for (Booking b : recentBookings) { 
                                            if (count++ >= 5) break; 
                                    %>
                                        <tr>
                                            <td><%= b.getCustomerName() %></td>
                                            <td><%= b.getServiceName() %></td>
                                            <td>₹<%= (int)b.getTokenAmount() %></td>
                                            <td class="text-danger">
                                                <%= b.getStatus().equals("Cancelled") || b.getStatus().equals("Completed") ? "₹" + (int)b.getRefundAmount() : "-" %>
                                            </td>
                                            <td>
                                                <span class="badge <%= b.getStatus().equals("Approved") ? "bg-success" : (b.getStatus().equals("Pending") ? "bg-warning" : "bg-danger" ) %>">
                                                    <%= b.getStatus() %>
                                                </span>
                                            </td>
                                        </tr>
                                    <% } %>
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <div id="section-therapists" class="mgmt-section">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <h4 class="fw-bold"><i class="fas fa-user-md me-2"></i> Manage Therapists</h4>
                            <button class="btn btn-dark btn-sm" data-bs-toggle="modal" data-bs-target="#addTherapistModal">
                                <i class="fas fa-plus me-1"></i> Add Therapist
                            </button>
                        </div>
                        <div class="table-responsive bg-white p-3 rounded-4 shadow-sm">
                            <table class="table table-hover align-middle">
                                <thead>
                                    <tr>
                                        <th>Name</th>
                                        <th>Specialty</th>
                                        <th>Email</th>
                                        <th>Phone</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% for (Therapist t : allTherapists) { %>
                                        <tr>
                                            <td><strong><%= t.getName() %></strong></td>
                                            <td><span class="badge bg-info text-dark"><%= t.getSpecialty() %></span></td>
                                            <td><%= t.getEmail() %></td>
                                            <td><%= t.getPhone() %></td>
                                            <td>
                                                <button class="btn btn-outline-primary btn-sm btn-action" 
                                                        onclick="editTherapist('<%= t.getId() %>', '<%= t.getName() %>', '<%= t.getEmail() %>', '<%= t.getPhone() %>', '<%= t.getSpecialty() %>', '<%= t.getAvailability() %>')">
                                                    <i class="fas fa-edit"></i>
                                                </button>
                                                <a href="TherapistServlet?action=delete&id=<%= t.getId() %>" 
                                                   class="btn btn-outline-danger btn-sm btn-action" 
                                                   onclick="return confirm('Are you sure you want to remove this therapist?')">
                                                    <i class="fas fa-trash"></i>
                                                </a>
                                            </td>
                                        </tr>
                                    <% } %>
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <div id="section-customers" class="mgmt-section">
                        <h4 class="fw-bold mb-3"><i class="fas fa-users me-2"></i> Manage Customers</h4>
                        <div class="table-responsive bg-white p-3 rounded-4 shadow-sm">
                            <table class="table table-hover align-middle">
                                <thead>
                                    <tr>
                                        <th>Name</th>
                                        <th>Email</th>
                                        <th>Phone</th>
                                        <th>Area</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% for (Customer c : allCustomers) { %>
                                        <tr>
                                            <td><strong><%= c.getName() %></strong></td>
                                            <td><%= c.getEmail() %></td>
                                            <td><%= c.getPhone() %></td>
                                            <td><%= c.getArea() %></td>
                                            <td>
                                                <button class="btn btn-outline-primary btn-sm btn-action" 
                                                        onclick="editCustomer('<%= c.getId() %>', '<%= c.getName() %>', '<%= c.getEmail() %>', '<%= c.getPhone() %>', '<%= c.getArea() %>')">
                                                    <i class="fas fa-edit"></i>
                                                </button>
                                                <a href="CustomerServlet?action=delete&id=<%= c.getId() %>" 
                                                   class="btn btn-outline-danger btn-sm btn-action" 
                                                   onclick="return confirm('Remove this customer profile?')">
                                                    <i class="fas fa-trash"></i>
                                                </a>
                                            </td>
                                        </tr>
                                    <% } %>
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <div id="section-services" class="mgmt-section">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <h4 class="fw-bold"><i class="fas fa-cut me-2"></i> Manage Services</h4>
                            <button class="btn btn-dark btn-sm" data-bs-toggle="modal" data-bs-target="#addServiceModal">
                                <i class="fas fa-plus me-1"></i> Add Service
                            </button>
                        </div>
                        <div class="table-responsive bg-white p-3 rounded-4 shadow-sm">
                            <table class="table table-hover align-middle">
                                <thead>
                                    <tr>
                                        <th>Service Name</th>
                                        <th>Price</th>
                                        <th>Duration (Min)</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% for (Service s : allServices) { %>
                                        <tr>
                                            <td><strong><%= s.getServiceName() %></strong></td>
                                            <td>₹<%= (int)s.getPrice() %></td>
                                            <td><%= s.getDuration() %> mins</td>
                                            <td>
                                                <button class="btn btn-outline-primary btn-sm btn-action" 
                                                        onclick="editService('<%= s.getId() %>', '<%= s.getServiceName() %>', '<%= s.getPrice() %>', '<%= s.getDuration() %>')">
                                                    <i class="fas fa-edit"></i>
                                                </button>
                                                <a href="ServiceServlet?action=delete&id=<%= s.getId() %>" 
                                                   class="btn btn-outline-danger btn-sm btn-action" 
                                                   onclick="return confirm('Remove this service?')">
                                                    <i class="fas fa-trash"></i>
                                                </a>
                                            </td>
                                        </tr>
                                    <% } %>
                                </tbody>
                            </table>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="addTherapistModal" tabindex="-1">
        <div class="modal-dialog">
            <form action="TherapistServlet" method="post" class="modal-content">
                <input type="hidden" name="action" value="add">
                <div class="modal-header">
                    <h5 class="modal-title">Add New Therapist</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <div class="mb-3">
                        <label class="form-label">Full Name</label>
                        <input type="text" name="name" class="form-control" required>
                    </div>
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Email (Username)</label>
                            <input type="email" name="email" class="form-control" required>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Password</label>
                            <input type="password" name="password" class="form-control" required>
                        </div>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Phone</label>
                        <input type="text" name="phone" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Specialty</label>
                        <input type="text" name="specialty" class="form-control" placeholder="e.g. Hair Styling, Facial" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Availability</label>
                        <input type="text" name="availability" class="form-control" placeholder="e.g. 10 AM - 8 PM" required>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <button type="submit" class="btn btn-dark">Add Therapist</button>
                </div>
            </form>
        </div>
    </div>

    <div class="modal fade" id="editTherapistModal" tabindex="-1">
        <div class="modal-dialog">
            <form action="TherapistServlet" method="post" class="modal-content">
                <input type="hidden" name="action" value="edit">
                <input type="hidden" name="id" id="editTId">
                <div class="modal-header">
                    <h5 class="modal-title">Edit Therapist</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <div class="mb-3">
                        <label class="form-label">Full Name</label>
                        <input type="text" name="name" id="editTName" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Email</label>
                        <input type="email" name="email" id="editTEmail" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Phone</label>
                        <input type="text" name="phone" id="editTPhone" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Specialty</label>
                        <input type="text" name="specialty" id="editTSpecialty" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Availability</label>
                        <input type="text" name="availability" id="editTAvailability" class="form-control" required>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-dark">Save Changes</button>
                </div>
            </form>
        </div>
    </div>

    <div class="modal fade" id="editCustomerModal" tabindex="-1">
        <div class="modal-dialog">
            <form action="CustomerServlet" method="post" class="modal-content">
                <input type="hidden" name="action" value="edit">
                <input type="hidden" name="id" id="editCId">
                <div class="modal-header">
                    <h5 class="modal-title">Edit Customer</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <div class="mb-3">
                        <label class="form-label">Full Name</label>
                        <input type="text" name="name" id="editCName" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Email</label>
                        <input type="email" name="email" id="editCEmail" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Phone</label>
                        <input type="text" name="phone" id="editCPhone" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Area</label>
                        <input type="text" name="area" id="editCArea" class="form-control" required>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-dark">Save Changes</button>
                </div>
            </form>
        </div>
    </div>

    <div class="modal fade" id="addServiceModal" tabindex="-1">
        <div class="modal-dialog">
            <form action="ServiceServlet" method="post" class="modal-content">
                <input type="hidden" name="action" value="add">
                <div class="modal-header">
                    <h5 class="modal-title">Add New Service</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <div class="mb-3">
                        <label class="form-label">Service Name</label>
                        <input type="text" name="name" class="form-control" required>
                    </div>
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Price (₹)</label>
                            <input type="number" name="price" class="form-control" required>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Duration (Mins)</label>
                            <input type="number" name="duration" class="form-control" required>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <button type="submit" class="btn btn-dark">Add Service</button>
                </div>
            </form>
        </div>
    </div>

    <div class="modal fade" id="editServiceModal" tabindex="-1">
        <div class="modal-dialog">
            <form action="ServiceServlet" method="post" class="modal-content">
                <input type="hidden" name="action" value="edit">
                <input type="hidden" name="id" id="editSId">
                <div class="modal-header">
                    <h5 class="modal-title">Edit Service</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <div class="mb-3">
                        <label class="form-label">Service Name</label>
                        <input type="text" name="name" id="editSName" class="form-control" required>
                    </div>
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Price (₹)</label>
                            <input type="number" name="price" id="editSPrice" class="form-control" required>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Duration (Mins)</label>
                            <input type="number" name="duration" id="editSDuration" class="form-control" required>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-dark">Save Changes</button>
                </div>
            </form>
        </div>
    </div>

    <script>
        // Tab switching logic
        function showSection(sectionId) {
            // Hide all sections
            document.querySelectorAll('.mgmt-section').forEach(section => {
                section.classList.remove('active');
            });
            // Show the target section
            document.getElementById('section-' + sectionId).classList.add('active');

            // Remove active style from all sidebar links
            document.querySelectorAll('.nav-link-custom').forEach(link => {
                link.classList.remove('active');
            });
            // Add active style to the clicked link
            document.getElementById('link-' + sectionId).classList.add('active');
        }

        // Fill Edit Therapist Modal
        function editTherapist(id, name, email, phone, specialty, availability) {
            document.getElementById('editTId').value = id;
            document.getElementById('editTName').value = name;
            document.getElementById('editTEmail').value = email;
            document.getElementById('editTPhone').value = phone;
            document.getElementById('editTSpecialty').value = specialty;
            document.getElementById('editTAvailability').value = availability;
            new bootstrap.Modal(document.getElementById('editTherapistModal')).show();
        }

        // Fill Edit Customer Modal
        function editCustomer(id, name, email, phone, area) {
            document.getElementById('editCId').value = id;
            document.getElementById('editCName').value = name;
            document.getElementById('editCEmail').value = email;
            document.getElementById('editCPhone').value = phone;
            document.getElementById('editCArea').value = area;
            new bootstrap.Modal(document.getElementById('editCustomerModal')).show();
        }

        // Fill Edit Service Modal
        function editService(id, name, price, duration) {
            document.getElementById('editSId').value = id;
            document.getElementById('editSName').value = name;
            document.getElementById('editSPrice').value = price;
            document.getElementById('editSDuration').value = duration;
            new bootstrap.Modal(document.getElementById('editServiceModal')).show();
        }
    </script>
</body>
<%@ include file="footer.jsp" %>