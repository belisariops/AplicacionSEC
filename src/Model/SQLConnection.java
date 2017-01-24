package Model;

import java.sql.*;
/**
 * Created by bpanay on 23-01-2017.
 */
public class SQLConnection {
    Connection connection;

    public SQLConnection() throws SQLException {
        //connection = new SQLConnection()

        connection = DriverManager.getConnection("jdbc:sqlite:src/Model/database.db");

    }
}
