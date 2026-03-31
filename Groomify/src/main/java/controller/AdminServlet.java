package controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import dao.AdminDAO;
import model.Admin;

@WebServlet("/AdminServlet")
public class AdminServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private AdminDAO adminDAO;

    @Override
    public void init() {
        adminDAO = new AdminDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("login".equals(action)) {

            String username = request.getParameter("username");
            String password = request.getParameter("password");

            Admin admin = adminDAO.loginAdmin(username, password);

            if (admin != null) {
                HttpSession session = request.getSession();
                session.setAttribute("admin", admin);
                session.setAttribute("role", "admin");
                response.sendRedirect("admin_dashboard.jsp");
            } else {
                request.setAttribute("errorMessage", "Invalid credentials.");
                request.getRequestDispatcher("admin_login.jsp")
                       .forward(request, response);
            }
        }
    }
}

