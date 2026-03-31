package controller;

import java.io.IOException;
import java.sql.Timestamp;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import dao.BookingDAO;
import model.Booking;
import model.Customer;

@WebServlet("/CancelBookingServlet")
public class CancelBookingServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private BookingDAO bookingDAO;

    @Override
    public void init() {
        bookingDAO = new BookingDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idStr = request.getParameter("id");
        if (idStr == null) {
            request.getSession().setAttribute("error", "Booking ID is missing.");
            response.sendRedirect("my_appointments.jsp");
            return;
        }

        int bookingId = Integer.parseInt(idStr);
        Booking booking = bookingDAO.getBookingById(bookingId);

        if (booking != null) {
            java.sql.Date bookingDate = booking.getBookingDate();
            String timeSlot = booking.getTimeSlot();

            // Combine Date and Time Slot to get appointment timestamp
            long appointmentTime = 0;
            try {
                java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd hh:mm a");
                java.util.Date parsedDate = sdf.parse(bookingDate.toString() + " " + timeSlot);
                appointmentTime = parsedDate.getTime();
            } catch (Exception e) {
                e.printStackTrace();
            }

            long now = System.currentTimeMillis();
            long diffInMillis = appointmentTime - now;
            long diffInMinutes = diffInMillis / (60 * 1000);

            double refundAmount = 0;
            String refundMessage = "";
            if (diffInMinutes >= 30) {
                // Refund allowed if cancelled more than 30 minutes BEFORE appointment
                refundAmount = booking.getTokenAmount();
                refundMessage = "Full refund of ₹" + refundAmount
                        + " processed (cancelled more than 30 mins before appointment).";
            } else {
                // 25% penalty (75% refund) if cancelled within 30 minutes of appointment
                refundAmount = booking.getTokenAmount() * 0.75;
                refundMessage = "75% refund of ₹" + refundAmount
                        + " processed (within 30 mins penalty - 25% deducted).";
            }

            boolean cancelled = bookingDAO.cancelBooking(bookingId, refundAmount);

            if (cancelled) {
                request.getSession().setAttribute("message", "Booking cancelled. " + refundMessage);
            } else {
                request.getSession().setAttribute("error", "Failed to cancel booking.");
            }
        } else {
            request.getSession().setAttribute("error", "Booking not found.");
        }

        // Redirect back to referring page (my_appointments or appointment_requests)
        String referer = request.getHeader("referer");
        if (referer != null && referer.contains("appointment_requests.jsp")) {
            response.sendRedirect("appointment_requests.jsp");
        } else {
            response.sendRedirect("my_appointments.jsp");
        }
    }
}
