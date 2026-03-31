package controller;

import java.io.IOException;
import java.sql.Date;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import dao.BookingDAO;
import model.Booking;
import model.Customer;

@WebServlet("/BookingServlet")
public class BookingServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private BookingDAO bookingDAO;

    @Override
    public void init() {
        bookingDAO = new BookingDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute("user");

        if (customer == null) {
            response.sendRedirect("customer_login.jsp");
            return;
        }

        int therapistId = Integer.parseInt(request.getParameter("therapistId"));
        int serviceId = Integer.parseInt(request.getParameter("serviceId"));
        String dateStr = request.getParameter("bookingDate");
        String timeSlot = request.getParameter("timeSlot");

        double amountToPay = Double.parseDouble(request.getParameter("tokenAmount"));

        Booking booking = new Booking();
        booking.setCustomerId(customer.getId());
        booking.setTherapistId(therapistId);
        booking.setServiceId(serviceId);
        booking.setBookingDate(Date.valueOf(dateStr));
        booking.setTimeSlot(timeSlot);
        booking.setStatus("Pending");
        booking.setTokenAmount(amountToPay);

        boolean booked = bookingDAO.bookAppointment(booking);

        if (booked) {
            response.sendRedirect("my_appointments.jsp");
        } else {
            request.setAttribute("errorMessage", "Booking failed. Please try again.");
            request.getRequestDispatcher("book_appointment.jsp").forward(request, response);
        }
    }
}