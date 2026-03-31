package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Booking;
import util.DBConnection;

public class BookingDAO {

    public boolean bookAppointment(Booking booking) {
        String sql = "INSERT INTO appointments (customer_id, therapist_id, service_id, booking_date, time_slot, status, token_amount) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, booking.getCustomerId());
            ps.setInt(2, booking.getTherapistId());
            ps.setInt(3, booking.getServiceId());
            ps.setDate(4, booking.getBookingDate());
            ps.setString(5, booking.getTimeSlot());
            ps.setString(6, booking.getStatus());
            ps.setDouble(7, booking.getTokenAmount());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public Booking getBookingById(int id) {
        String sql = "SELECT a.*, s.service_name, s.price as service_price, t.name as therapist_name " +
                "FROM appointments a " +
                "JOIN services s ON a.service_id = s.id " +
                "JOIN therapists t ON a.therapist_id = t.id " +
                "WHERE a.id = ?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Booking b = new Booking();
                b.setId(rs.getInt("id"));
                b.setCustomerId(rs.getInt("customer_id"));
                b.setTherapistId(rs.getInt("therapist_id"));
                b.setServiceId(rs.getInt("service_id"));
                b.setBookingDate(rs.getDate("booking_date"));
                b.setTimeSlot(rs.getString("time_slot"));
                b.setStatus(rs.getString("status"));
                b.setCreatedAt(rs.getTimestamp("created_at"));
                b.setTokenAmount(rs.getDouble("token_amount"));
                b.setServicePrice(rs.getDouble("service_price"));
                b.setServiceName(rs.getString("service_name"));
                b.setTherapistName(rs.getString("therapist_name"));
                b.setRefundAmount(rs.getDouble("refund_amount"));
                return b;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Booking> getBookingsByCustomer(int customerId) {
        List<Booking> list = new ArrayList<>();
        String sql = "SELECT a.*, s.service_name, s.price as service_price, t.name as therapist_name " +
                "FROM appointments a " +
                "JOIN services s ON a.service_id = s.id " +
                "JOIN therapists t ON a.therapist_id = t.id " +
                "WHERE a.customer_id = ? ORDER BY a.id DESC";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, customerId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Booking b = new Booking();
                b.setId(rs.getInt("id"));
                b.setCustomerId(rs.getInt("customer_id"));
                b.setTherapistId(rs.getInt("therapist_id"));
                b.setServiceId(rs.getInt("service_id"));
                b.setBookingDate(rs.getDate("booking_date"));
                b.setTimeSlot(rs.getString("time_slot"));
                b.setStatus(rs.getString("status"));
                b.setCreatedAt(rs.getTimestamp("created_at"));
                b.setTokenAmount(rs.getDouble("token_amount"));
                b.setServicePrice(rs.getDouble("service_price"));

                b.setServiceName(rs.getString("service_name"));
                b.setTherapistName(rs.getString("therapist_name"));
                b.setRefundAmount(rs.getDouble("refund_amount"));

                list.add(b);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Booking> getAllBookings() {
        List<Booking> list = new ArrayList<>();
        String sql = "SELECT a.*, c.name as customer_name, c.email as customer_email, s.service_name, s.price as service_price, t.name as therapist_name "
                +
                "FROM appointments a " +
                "JOIN customers c ON a.customer_id = c.id " +
                "JOIN services s ON a.service_id = s.id " +
                "JOIN therapists t ON a.therapist_id = t.id ORDER BY a.id DESC";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Booking b = new Booking();
                b.setId(rs.getInt("id"));
                b.setCustomerId(rs.getInt("customer_id"));
                b.setTherapistId(rs.getInt("therapist_id"));
                b.setServiceId(rs.getInt("service_id"));
                b.setBookingDate(rs.getDate("booking_date"));
                b.setTimeSlot(rs.getString("time_slot"));
                b.setStatus(rs.getString("status"));
                b.setCreatedAt(rs.getTimestamp("created_at"));
                b.setTokenAmount(rs.getDouble("token_amount"));
                b.setServicePrice(rs.getDouble("service_price"));

                b.setCustomerName(rs.getString("customer_name"));
                b.setCustomerEmail(rs.getString("customer_email"));
                b.setServiceName(rs.getString("service_name"));
                b.setTherapistName(rs.getString("therapist_name"));
                b.setRefundAmount(rs.getDouble("refund_amount"));

                list.add(b);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean updateStatus(int id, String status) {
        String sql = "UPDATE appointments SET status = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, status);
            ps.setInt(2, id);

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean cancelBooking(int id, double refundAmount) {
        String sql = "UPDATE appointments SET status = 'Cancelled', refund_amount = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setDouble(1, refundAmount);
            ps.setInt(2, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public double[] getRevenueStats() {
        double[] stats = new double[3]; // [Total Collected, Total Refunded, Net Profit]
        String sql = "SELECT SUM(token_amount), SUM(refund_amount) FROM appointments";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                stats[0] = rs.getDouble(1); // Total Collected
                stats[1] = rs.getDouble(2); // Total Refunded (Loss)
                stats[2] = stats[0] - stats[1]; // Net Profit
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return stats;
    }

    public int getPendingBookingsCount() {
        String sql = "SELECT COUNT(*) FROM appointments WHERE status = 'Pending'";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {
            if (rs.next())
                return rs.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public int getCompletedBookingsCount() {
        String sql = "SELECT COUNT(*) FROM appointments WHERE status = 'Completed'";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {
            if (rs.next())
                return rs.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public boolean completeBooking(int id, double refundAmount) {
        String sql = "UPDATE appointments SET status = 'Completed', refund_amount = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setDouble(1, refundAmount);
            ps.setInt(2, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
