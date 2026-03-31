package dao;

import java.sql.*;
import model.Admin;
import util.DBConnection;

public class AdminDAO {

    public Admin loginAdmin(String username, String password) {
        String sql = "SELECT * FROM admin WHERE username = ? AND password = ?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, username);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Admin(
                        rs.getInt("id"),
                        rs.getString("username"),
                        rs.getString("password"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
