package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Therapist;
import util.DBConnection;

public class TherapistDAO {

    public List<Therapist> getAllTherapists() {
        List<Therapist> therapists = new ArrayList<>();
        String sql = "SELECT * FROM therapists";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                therapists.add(new Therapist(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("email"),
                        rs.getString("phone"),
                        rs.getDouble("rating"),
                        rs.getString("availability"),
                        rs.getString("specialty")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return therapists;
    }

    public Therapist getTherapistById(int id) {
        String sql = "SELECT * FROM therapists WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Therapist(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("email"),
                        rs.getString("phone"),
                        rs.getDouble("rating"),
                        rs.getString("availability"),
                        rs.getString("specialty"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public Therapist loginTherapist(String email, String password) {
        String sql = "SELECT * FROM therapists WHERE email = ? AND password = ?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, email);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Therapist t = new Therapist(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("email"),
                        rs.getString("phone"),
                        rs.getDouble("rating"),
                        rs.getString("availability"),
                        rs.getString("specialty"));
                t.setPassword(rs.getString("password"));
                return t;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean addTherapist(Therapist t) {
        String sql = "INSERT INTO therapists (name, email, password, phone, rating, availability, specialty) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, t.getName());
            ps.setString(2, t.getEmail());
            ps.setString(3, t.getPassword());
            ps.setString(4, t.getPhone());
            ps.setDouble(5, t.getRating());
            ps.setString(6, t.getAvailability());
            ps.setString(7, t.getSpecialty());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateTherapist(Therapist t) {
        String sql = "UPDATE therapists SET name=?, email=?, phone=?, availability=?, specialty=? WHERE id=?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, t.getName());
            ps.setString(2, t.getEmail());
            ps.setString(3, t.getPhone());
            ps.setString(4, t.getAvailability());
            ps.setString(5, t.getSpecialty());
            ps.setInt(6, t.getId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteTherapist(int id) {
        String sql = "DELETE FROM therapists WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public int getTotalTherapistsCount() {
        String sql = "SELECT COUNT(*) FROM therapists";
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
}
