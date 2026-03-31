<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Groomify</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body { font-family: 'Poppins', sans-serif; background-color: #f8f9fa; }
        .hero-section { background: linear-gradient(rgba(0,0,0,0.5), rgba(0,0,0,0.5)), url('https://images.unsplash.com/photo-1560066984-138dadb4c035?ixlib=rb-4.0.3&auto=format&fit=crop&w=2070&q=80'); background-size: cover; height: 500px; color: white; display: flex; align-items: center; justify-content: center; text-align: center; }
        .navbar-brand { font-weight: bold; color: #ff6b6b !important; }
        .btn-custom { background-color: #ff6b6b; color: white; }
        .btn-custom:hover { background-color: #ff4757; color: white; }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm">
    <div class="container">
        <a class="navbar-brand" href="index.jsp"><i class="fas fa-scissors"></i> Groomify</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item"><a class="nav-link" href="index.jsp">Home</a></li>
                <li class="nav-item"><a class="nav-link" href="about.jsp">About</a></li>
                <li class="nav-item"><a class="nav-link" href="salon_list.jsp">Services</a></li>
                
                <c:choose>
                    <c:when test="${not empty sessionScope.user}">
                        <li class="nav-item"><a class="nav-link" href="book_appointment.jsp">Book Now</a></li>
                        <li class="nav-item"><a class="nav-link" href="my_appointments.jsp">My Appointments</a></li>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-bs-toggle="dropdown">
                                ${sessionScope.user.name}
                            </a>
                            <ul class="dropdown-menu">
                                <li><a class="dropdown-item" href="LogoutServlet">Logout</a></li>
                            </ul>
                        </li>
                    </c:when>
                    <c:when test="${not empty sessionScope.admin}">
                        <li class="nav-item"><a class="nav-link" href="admin_dashboard.jsp">Dashboard</a></li>
                        <li class="nav-item"><a class="nav-link" href="appointment_requests.jsp">Requests</a></li>
                        <li class="nav-item"><a class="nav-link" href="LogoutServlet">Logout (Admin)</a></li>
                    </c:when>
                    <c:when test="${not empty sessionScope.therapist}">
                        <li class="nav-item"><a class="nav-link" href="therapist_dashboard.jsp">Dashboard</a></li>
                         <li class="nav-item"><a class="nav-link" href="LogoutServlet">Logout (Therapist)</a></li>
                    </c:when>
                    <c:otherwise>
                        <li class="nav-item"><a class="nav-link" href="customer_login.jsp">Login</a></li>
                        <li class="nav-item"><a class="nav-link" href="customer_register.jsp">Register</a></li>
                        <li class="nav-item dropdown">
                             <a class="nav-link dropdown-toggle" href="#" id="staffDropdown" role="button" data-bs-toggle="dropdown">
                                Staff
                            </a>
                            <ul class="dropdown-menu">
                                <li><a class="dropdown-item" href="admin_login.jsp">Admin Login</a></li>
                                <li><a class="dropdown-item" href="therapist_login.jsp">Therapist Login</a></li>
                            </ul>
                        </li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>
    </div>
</nav>

<div class="container mt-4" style="min-height: 70vh;">