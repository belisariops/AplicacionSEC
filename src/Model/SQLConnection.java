package Model;

import com.sun.xml.internal.bind.v2.model.annotation.RuntimeAnnotationReader;

import java.io.*;
import java.sql.*;
/**
 * Created by bpanay on 23-01-2017.
 */
public class SQLConnection implements Runnable {
    Connection connection;
    private String path;

    public SQLConnection() throws SQLException {
        //connection = new SQLConnection()
        path = "src/Model/database.db";
        File file = new File(path);
        System.out.println(file.delete());
        connection = DriverManager.getConnection("jdbc:sqlite:"+path);

        int i =0;


        try {
            executeQuery("CREATE TABLE COMPANY(\n" +
                    "   ID INT PRIMARY KEY     NOT NULL,\n" +
                    "   NAME           TEXT    NOT NULL,\n" +
                    "   AGE            INT     NOT NULL,\n" +
                    "   ADDRESS        CHAR(50),\n" +
                    "   SALARY         REAL\n" +
                    ");");
        } catch (SQLException e) {
            System.out.println(e.getLocalizedMessage());
            e.printStackTrace();
        }


    }

    public void closeConnection() throws SQLException {
        connection.close();
    }




    public void executeQuery(String SQLquery) throws SQLException {
        Statement s = connection.createStatement();
        s.executeUpdate(SQLquery);
        s.close();
    }

    @Override
    public void run() {
        StringBuilder builder = new StringBuilder();
        String line;
        try (BufferedReader bufferedReader = new BufferedReader(new FileReader("src/Model/Tablas.txt"))) {
            while ((line = bufferedReader.readLine()) != null) {
                builder.append(line);



            }
        }
        catch (FileNotFoundException e) {
            System.out.println("a");

        }
        catch (IOException e) {
            System.out.println("b");

        }

        String[] s = builder.toString().split(";");
        for (int j=0;j<s.length;j++) {
            try {
                executeQuery(s[j]);
            }
            catch (SQLException e) {
                System.out.println(s[j]);
            }
        }
    }
}
