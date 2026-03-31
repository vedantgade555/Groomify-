package controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import dao.BookingDAO;

@WebServlet("/WorkDoneServlet")
public class WorkDoneServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private BookingDAO bookingDAO;

    @Override
    public void init() {
        bookingDAO = new BookingDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int bookingId = Integer.parseInt(request.getParameter("bookingId"));

            // Fetch booking to get tokenAmount
            model.Booking booking = bookingDAO.getBookingById(bookingId);
            if (booking != null) {
                // No refund on completion (user paid full price upfront)
                boolean updated = bookingDAO.completeBooking(bookingId, 0.0);

                if (updated) {
                    response.sendRedirect("therapist_dashboard.jsp?msg=Work marked as done successfully.");
                } else {
                    response.sendRedirect("therapist_dashboard.jsp?err=Failed to update status");
                }
            } else {
                response.sendRedirect("therapist_dashboard.jsp?err=Booking not found");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("therapist_dashboard.jsp?err=Invalid booking ID");
        }
    }
}
