package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Service;
import util.DBConnection;

public class ServiceDAO {

    public List<Service> getAllServices() {
        List<Service> services = new ArrayList<>();
        String sql = "SELECT * FROM services";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                services.add(new Service(
                        rs.getInt("id"),
                        rs.getString("service_name"),
                        rs.getDouble("price"),
                        rs.getInt("duration")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return services;
    }

    public Service getServiceById(int id) {
        String sql = "SELECT * FROM services WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Service(
                        rs.getInt("id"),
                        rs.getString("service_name"),
                        rs.getDouble("price"),
                        rs.getInt("duration"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean addService(Service service) {
        String sql = "INSERT INTO services (service_name, price, duration) VALUES (?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, service.getServiceName());
            ps.setDouble(2, service.getPrice());
            ps.setInt(3, service.getDuration());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateService(Service service) {
        String sql = "UPDATE services SET service_name = ?, price = ?, duration = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, service.getServiceName());
            ps.setDouble(2, service.getPrice());
            ps.setInt(3, service.getDuration());
            ps.setInt(4, service.getId());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public int getServiceCount() {
        String sql = "SELECT COUNT(*) FROM services";
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

    public boolean deleteService(int id) {
        String sql = "DELETE FROM services WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
