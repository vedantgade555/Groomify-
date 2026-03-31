package controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import dao.TherapistDAO;
import model.Therapist;

@WebServlet("/TherapistServlet")
public class TherapistServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private TherapistDAO therapistDAO;

    @Override
    public void init() {
        therapistDAO = new TherapistDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String role = (String) session.getAttribute("role");
        String action = request.getParameter("action");

        if ("view".equals(action)) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                Therapist therapist = therapistDAO.getTherapistById(id);
                request.setAttribute("therapist", therapist);
                request.getRequestDispatcher("therapist_details.jsp").forward(request, response);
            } catch (NumberFormatException e) {
                response.sendRedirect("index.jsp");
            }
        } else if ("delete".equals(action) && "admin".equals(role)) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                therapistDAO.deleteTherapist(id);
                response.sendRedirect("admin_dashboard.jsp?msg=Therapist deleted successfully");
            } catch (NumberFormatException e) {
                response.sendRedirect("admin_dashboard.jsp?err=Invalid ID");
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String role = (String) session.getAttribute("role");
        String action = request.getParameter("action");

        if ("login".equals(action)) {
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            Therapist therapist = therapistDAO.loginTherapist(email, password);
            if (therapist != null) {
                session.setAttribute("therapist", therapist);
                session.setAttribute("role", "therapist");
                response.sendRedirect("therapist_dashboard.jsp");
            } else {
                request.setAttribute("errorMessage", "Invalid credentials.");
                request.getRequestDispatcher("therapist_login.jsp").forward(request, response);
            }
        } else if ("add".equals(action) && "admin".equals(role)) {
            Therapist t = new Therapist();
            t.setName(request.getParameter("name"));
            t.setEmail(request.getParameter("email"));
            t.setPassword(request.getParameter("password"));
            t.setPhone(request.getParameter("phone"));
            t.setAvailability(request.getParameter("availability"));
            t.setSpecialty(request.getParameter("specialty"));
            t.setRating(5.0);

            if (therapistDAO.addTherapist(t)) {
                response.sendRedirect("admin_dashboard.jsp?msg=Therapist added successfully");
            } else {
                response.sendRedirect("admin_dashboard.jsp?err=Failed to add therapist");
            }
        } else if ("edit".equals(action) && "admin".equals(role)) {
            Therapist t = new Therapist();
            t.setId(Integer.parseInt(request.getParameter("id")));
            t.setName(request.getParameter("name"));
            t.setEmail(request.getParameter("email"));
            t.setPhone(request.getParameter("phone"));
            t.setAvailability(request.getParameter("availability"));
            t.setSpecialty(request.getParameter("specialty"));

            if (therapistDAO.updateTherapist(t)) {
                response.sendRedirect("admin_dashboard.jsp?msg=Therapist updated successfully");
            } else {
                response.sendRedirect("admin_dashboard.jsp?err=Failed to update therapist");
            }
        }
    }
}