package Model;

import java.io.File;
import java.sql.*;
/**
 * Created by bpanay on 23-01-2017.
 */
public class SQLConnection {
    Connection connection;
    private String path;

    public SQLConnection() throws SQLException {
        //connection = new SQLConnection()
        path = "src/Model/database.db";
        File file = new File(path);
        System.out.println(file.delete());
        connection = DriverManager.getConnection("jdbc:sqlite:"+path);
        Statement statement = connection.createStatement();
        statement.close();



    }

    public void closeConnection() throws SQLException {
        connection.close();
    }




    public void executeQuery(String SQLquery) throws SQLException {
        Statement s = connection.createStatement();
        s.executeUpdate(SQLquery);
        s.close();
    }
}
