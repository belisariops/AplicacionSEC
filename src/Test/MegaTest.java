package Test;

import Model.DatabaseCreator;
import Model.SQLConnection;
import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.sql.DatabaseMetaData;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;

/**
 * Created by bpanay on 25-01-2017.
 */
public class MegaTest {

  private SQLConnection connection;

  @Before
  public void setUp() {
    try {
      connection = new SQLConnection();
    } catch (SQLException e) {
      e.printStackTrace();
    }
    DatabaseCreator creator = new DatabaseCreator(connection);
    creator.run();


  }

  @Test
  public void allTablesCreatedTest() {
      List<String> tableListFromText = new ArrayList<String>();
      List<String> realTableList = new ArrayList<String>();
      String line;
    try (BufferedReader bufferedReader = new BufferedReader(new FileReader("src/Test/TablesNames.txt"))) {
      while ((line = bufferedReader.readLine()) != null) {
        tableListFromText.add(line);

      }
    }
    catch (FileNotFoundException e) {
      System.out.println("El archivo TablesNames.txt no fue encontrado");

    }
    catch (IOException e) {
      System.out.println("Algo salio mal");

    }
    try {

      DatabaseMetaData dbmd = connection.getConnection().getMetaData();
      String[] types = {"TABLE"};
      ResultSet rs = dbmd.getTables(null, null, "%", types);
      while (rs.next()) {
        //System.out.println(rs.getString("TABLE_NAME"));
        realTableList.add(rs.getString("TABLE_NAME"));
      }
    }
    catch (SQLException e) {
      e.printStackTrace();
    }

    for (int i=0; i<tableListFromText.size();i++) {
      Assert.assertTrue(realTableList.contains(tableListFromText.get(i)));
    }



  }

  @Test
  public void simpleInsertandSelect() {
    String query = "CREATE TABLE COMPANY " +
        "(ID INT PRIMARY KEY     NOT NULL," +
        " NAME           TEXT    NOT NULL, " +
        " AGE            INT     NOT NULL, " +
        " ADDRESS        CHAR(50), " +
        " SALARY         REAL)";

    try {
      connection.executeCreationQuery(query);
    } catch (SQLException e) {
      e.printStackTrace();
    }
    String sql;
    Statement stmt = null;
    try {
      stmt = connection.getConnection().createStatement();
      sql = "INSERT INTO COMPANY (ID,NAME,AGE,ADDRESS,SALARY) " +
          "VALUES (1, 'Paul', 32, 'California', 20000.00 );";
      stmt.executeUpdate(sql);
      sql = "INSERT INTO COMPANY (ID,NAME,AGE,ADDRESS,SALARY) " +
          "VALUES (2, 'Allen', 25, 'Texas', 15000.00 );";
      stmt.executeUpdate(sql);

      stmt = connection.getConnection().createStatement();
      ResultSet rs = stmt.executeQuery( "SELECT * FROM COMPANY;" );
      rs.next();
      int id = rs.getInt("id");
      String  name = rs.getString("name");
      int age  = rs.getInt("age");
      String  address = rs.getString("address");
      float salary = rs.getFloat("salary");
      Assert.assertEquals(1,id);
      Assert.assertEquals("Paul",name);
      Assert.assertEquals(32,age);
      Assert.assertEquals("California",address);
      Assert.assertEquals(20000.0,salary,0.0);

      rs.next();
      id = rs.getInt("id");
      name = rs.getString("name");
      age  = rs.getInt("age");
      address = rs.getString("address");
      salary = rs.getFloat("salary");
      Assert.assertEquals(2,id);
      Assert.assertEquals("Allen",name);
      Assert.assertEquals(25,age);
      Assert.assertEquals("Texas",address);
      Assert.assertEquals(15000.0,salary,0.0);


      rs.close();
      stmt.close();
      connection.closeConnection();

    } catch (SQLException e) {
      e.printStackTrace();
    }



  }
  }


