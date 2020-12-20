package app.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseIO {

    Connection connection;

    public Connection getConnection() {
        return connection;
    }

    public void setConnection(Connection connection) {
        this.connection = connection;
    }

    // for real apply on project
    public void openConnectionCloud() throws Exception {
        Class.forName(DatabaseInfo.driverName);
        connection = DriverManager.getConnection(DatabaseInfo.url, DatabaseInfo.name, DatabaseInfo.pass);
    }

    public void closeConnection() {
        try {
            connection.close();
        } catch (SQLException e) {
            //NOTHING WE CAN DO
        }
    }
}
