<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="header.jsp" %>
<%@ page import="dao.ServiceDAO, model.Service, java.util.List" %>

<% 
    // --- SESSION CHECK --- 
    if (session.getAttribute("admin") == null) {
        response.sendRedirect("admin_login.jsp"); 
        return; 
    } 

    // --- FETCH SERVICES --- 
    ServiceDAO serviceDAO = new ServiceDAO(); 
    List<Service> services = serviceDAO.getAllServices();
%>

<style>
    /* ----- KEYFRAMES & ANIMATIONS ----- */
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

    .fade-up {
        opacity: 0;
        animation: fadeUp 0.8s cubic-bezier(0.23, 1, 0.32, 1) forwards;
    }

    .delay-1 { animation-delay: 0.1s; }
    .delay-2 { animation-delay: 0.2s; }
    .delay-3 { animation-delay: 0.3s; }

    /* ----- GLOBAL & BACKGROUND ----- */
    body {
        background: linear-gradient(145deg, #f9f5f0, #f0ebe5);
        font-family: 'Inter', sans-serif;
    }

    /* ----- PAGE HEADER ----- */
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

    .page-header h1 {
        font-weight: 800;
        background: linear-gradient(145deg, #1a1a1a, #333);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
    }

    /* ----- TABLE CARD (GLASSMORPHISM) ----- */
    .table-card {
        background: rgba(255, 255, 255, 0.85);
        backdrop-filter: blur(10px);
        border-radius: 28px;
        border: 1px solid rgba(255, 255, 255, 0.6);
        box-shadow: 0 25px 40px -10px rgba(0, 0, 0, 0.08);
        overflow: hidden;
    }

    /* ----- TABLE STYLES ----- */
    .table thead th {
        background: linear-gradient(145deg, #2c3e50, #1e2b37);
        color: white;
        font-weight: 600;
        text-transform: uppercase;
        font-size: 0.85rem;
        letter-spacing: 1px;
        padding: 1rem;
        border: none;
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

    .table td {
        padding: 1rem;
        font-weight: 500;
        color: #495057;
    }

    /* ----- BUTTONS ----- */
    .btn-gradient {
        background: linear-gradient(145deg, #d4af37, #b8942e);
        border: none;
        color: black;
        font-weight: 600;
        border-radius: 50px;
        padding: 10px 24px;
        transition: all 0.3s;
    }

    .btn-gradient:hover {
        background: linear-gradient(145deg, #e6c468, #c9a341);
        transform: scale(1.05);
    }

    .btn-outline-dark-custom {
        border-radius: 50px;
        font-weight: 600;
        padding: 10px 24px;
    }
</style>

<div class="container-fluid py-4 px-lg-5">

    <div class="page-header d-flex justify-content-between align-items-center fade-up delay-1">
        <div>
            <h1 class="display-6 fw-bold mb-2"><i class="fas fa-cut me-2" style="color: #d4af37;"></i> Manage Services</h1>
            <p class="text-dark-50 mb-0" style="font-size: 1.1rem;">
                View and update your salon's premium service offerings.
            </p>
        </div>
        <div>
            <a href="admin_dashboard.jsp" class="btn btn-outline-dark btn-outline-dark-custom bg-white">
                <i class="fas fa-arrow-left me-2"></i>Back to Dashboard
            </a>
        </div>
    </div>

    <div class="row fade-up delay-2">
        <div class="col-12">
            <div class="table-card p-4">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h5 class="fw-bold mb-0"><i class="fas fa-spa me-2" style="color: #d4af37;"></i>
                        Active Services Directory</h5>
                    <button class="btn btn-gradient btn-sm">
                        <i class="fas fa-plus me-1"></i> Add New Service
                    </button>
                </div>

                <div class="table-responsive rounded-3">
                    <table class="table table-hover mb-0">
                        <thead>
                            <tr>
                                <th>Service ID</th>
                                <th>Service Name</th>
                                <th>Price</th>
                                <th>Duration (Mins)</th>
                                <th class="text-center">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% if (services == null || services.isEmpty()) { %>
                                <tr>
                                    <td colspan="5" class="text-center py-5 text-muted">
                                        <i class="fas fa-folder-open fa-3x mb-3 opacity-50"></i><br>
                                        No services found in the database.
                                    </td>
                                </tr>
                            <% } else { 
                                for(Service s : services) { 
                            %>
                                <tr>
                                    <td>
                                        <span class="badge bg-light text-dark border border-secondary">#
                                            <%= s.getId() %>
                                        </span>
                                    </td>
                                    <td class="fw-bold text-dark">
                                        <%= s.getServiceName() %>
                                    </td>
                                    <td class="text-success fw-bold">
                                        Rs <%= String.format("%.0f", s.getPrice()) %>
                                    </td>
                                    <td>
                                        <i class="fas fa-clock text-muted me-1"></i>
                                        <%= s.getDuration() %> mins
                                    </td>
                                    <td class="text-center">
                                        <button class="btn btn-sm btn-outline-primary rounded-pill px-3 me-1">
                                            <i class="fas fa-edit"></i> Edit
                                        </button>
                                        <button class="btn btn-sm btn-outline-danger rounded-pill px-3">
                                            <i class="fas fa-trash"></i>
                                        </button>
                                    </td>
                                </tr>
                            <% 
                                } 
                            } 
                            %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="footer.jsp" %>