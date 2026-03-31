package util;

import java.sql.Driver;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Enumeration;
import java.util.logging.Level;
import java.util.logging.Logger;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

import com.mysql.cj.jdbc.AbandonedConnectionCleanupThread;

@WebListener
public class AppContextListener implements ServletContextListener {

    private static final Logger LOGGER =
            Logger.getLogger(AppContextListener.class.getName());

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        // No initialization required
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {

        // Deregister JDBC drivers (prevents memory leak on redeploy)
        Enumeration<Driver> drivers = DriverManager.getDrivers();

        while (drivers.hasMoreElements()) {
            Driver driver = drivers.nextElement();
            try {
                DriverManager.deregisterDriver(driver);
                LOGGER.log(Level.INFO,
                        "Deregistered JDBC driver: {0}", driver);
            } catch (SQLException ex) {
                LOGGER.log(Level.SEVERE,
                        "Error deregistering driver: {0}",
                        ex.getMessage());
            }
        }

        // Shutdown MySQL cleanup thread
        try {
            AbandonedConnectionCleanupThread.checkedShutdown();
            LOGGER.info("MySQL AbandonedConnectionCleanupThread shut down.");
        } catch (Throwable t) {
            LOGGER.log(Level.WARNING,
                    "Could not shutdown AbandonedConnectionCleanupThread: {0}",
                    t.getMessage());
        }
    }
}