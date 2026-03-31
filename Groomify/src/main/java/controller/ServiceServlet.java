package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import dao.ServiceDAO;
import model.Service;

@WebServlet("/ServiceServlet")
public class ServiceServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ServiceDAO serviceDAO;

    @Override
    public void init() {
        serviceDAO = new ServiceDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session.getAttribute("admin") == null) {
            response.sendRedirect("admin_login.jsp");
            return;
        }

        String action = request.getParameter("action");
        if (action == null) {
            response.sendRedirect("admin_dashboard.jsp?err=No action specified");
            return;
        }

        boolean success = false;
        try {
            if ("add".equals(action)) {
                String name = request.getParameter("name");
                double price = Double.parseDouble(request.getParameter("price"));
                int duration = Integer.parseInt(request.getParameter("duration"));

                Service service = new Service();
                service.setServiceName(name);
                service.setPrice(price);
                service.setDuration(duration);
                success = serviceDAO.addService(service);
            } else if ("edit".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                String name = request.getParameter("name");
                double price = Double.parseDouble(request.getParameter("price"));
                int duration = Integer.parseInt(request.getParameter("duration"));

                Service service = new Service(id, name, price, duration);
                success = serviceDAO.updateService(service);
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("admin_dashboard.jsp?err=Invalid number format");
            return;
        }

        if (success) {
            response.sendRedirect("admin_dashboard.jsp?msg=Service " + (action.equals("add") ? "added" : "updated")
                    + " successfully");
        } else {
            response.sendRedirect("admin_dashboard.jsp?err=Failed to " + action + " service");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session.getAttribute("admin") == null) {
            response.sendRedirect("admin_login.jsp");
            return;
        }

        String action = request.getParameter("action");
        if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            if (serviceDAO.deleteService(id)) {
                response.sendRedirect("admin_dashboard.jsp?msg=Service removed successfully");
            } else {
                response.sendRedirect("admin_dashboard.jsp?err=Failed to remove service");
            }
        }
    }
}
