package controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import dao.BookingDAO;
import util.EmailUtil;

@WebServlet("/ApprovalServlet")
public class ApprovalServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private BookingDAO bookingDAO;

    @Override
    public void init() {
        bookingDAO = new BookingDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int bookingId = Integer.parseInt(request.getParameter("bookingId"));
        String status = request.getParameter("status"); // Approved / Rejected
        String customerEmail = request.getParameter("customerEmail");

        boolean updated = bookingDAO.updateStatus(bookingId, status);

        if (updated) {

            if ("Approved".equals(status)) {
                EmailUtil.sendEmail(customerEmail,
                        "Appointment Approved",
                        "Your appointment ID " + bookingId + " has been approved!");
            } else if ("Rejected".equals(status)) {
                EmailUtil.sendEmail(customerEmail,
                        "Appointment Rejected",
                        "Your appointment ID " + bookingId + " has been rejected.");
            }

            response.sendRedirect("appointment_requests.jsp");
        } else {
            response.sendRedirect("appointment_requests.jsp?error=true");
        }
    }
}