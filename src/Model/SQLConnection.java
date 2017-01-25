package Model;

import com.sun.xml.internal.bind.v2.model.annotation.RuntimeAnnotationReader;

import java.io.*;
import java.sql.*;
/**
 * Created by bpanay on 23-01-2017.
 */
public class SQLConnection {
    Connection connection;
    private String path;

    public SQLConnection() throws SQLException {
       connection = DriverManager.getConnection("jdbc:sqlite::memory:");
    }

    public synchronized void closeConnection() throws SQLException {
        connection.close();
    }




    public synchronized void executeQuery(String SQLquery) throws SQLException {
        Statement s = connection.createStatement();
        s.executeUpdate(SQLquery);
        s.close();
    }

}
