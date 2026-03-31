package controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import dao.CustomerDAO;
import model.Customer;

@WebServlet("/CustomerServlet")
public class CustomerServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private CustomerDAO customerDAO;

    @Override
    public void init() {
        customerDAO = new CustomerDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String role = (String) session.getAttribute("role");
        String action = request.getParameter("action");

        if ("delete".equals(action) && "admin".equals(role)) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                customerDAO.deleteCustomer(id);
                response.sendRedirect("admin_dashboard.jsp?msg=Customer removed successfully");
            } catch (NumberFormatException e) {
                response.sendRedirect("admin_dashboard.jsp?err=Invalid ID");
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        String role = (String) session.getAttribute("role");

        if ("register".equals(action)) {
            registerCustomer(request, response);
        } else if ("login".equals(action)) {
            loginCustomer(request, response);
        } else if ("edit".equals(action) && "admin".equals(role)) {
            Customer c = new Customer();
            c.setId(Integer.parseInt(request.getParameter("id")));
            c.setName(request.getParameter("name"));
            c.setEmail(request.getParameter("email"));
            c.setPhone(request.getParameter("phone"));
            c.setArea(request.getParameter("area"));

            if (customerDAO.updateCustomer(c)) {
                response.sendRedirect("admin_dashboard.jsp?msg=Customer updated successfully");
            } else {
                response.sendRedirect("admin_dashboard.jsp?err=Failed to update customer");
            }
        }
    }

    private void registerCustomer(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String phone = request.getParameter("phone");
        String area = request.getParameter("area");

        Customer customer = new Customer(0, name, email, password, phone, area);

        boolean registered = customerDAO.registerCustomer(customer);

        if (registered) {
            request.setAttribute("successMessage", "Registration successful! Please login.");
            request.getRequestDispatcher("customer_login.jsp")
                    .forward(request, response);
        } else {
            request.setAttribute("errorMessage", "Registration failed. Try again.");
            request.getRequestDispatcher("customer_register.jsp")
                    .forward(request, response);
        }
    }

    private void loginCustomer(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        Customer customer = customerDAO.loginCustomer(email, password);

        if (customer != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", customer);
            session.setAttribute("role", "customer");

            response.sendRedirect("index.jsp"); // or dashboard.jsp
        } else {
            request.setAttribute("errorMessage", "Invalid email or password.");
            request.getRequestDispatcher("customer_login.jsp")
                    .forward(request, response);
        }
    }
}