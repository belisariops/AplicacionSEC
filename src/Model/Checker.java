package Model;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

/**
 * @author Belisario Panay
 */
public class Checker implements  Runnable {
  private SQLConnection connection;
  private List<Error> errors;

  public Checker(SQLConnection connection)  {
    this.connection = connection;
    executeCheck("resultsCheckQueries");
    executeCheck("resultsPrimaryKey");
    executeCheck("resultUpdatingTables");
    executeCheck("resultForeignKey");
    executeCheck("resultUpdatingTables");
    executeCheck("resultsRecursiveError");
    executeCheck("resultsPeriodoStarId");
  }
  public List<Error> getErrors() {
      run();
      return errors;
  }

  private void executeCheck(String fileName) {
    StringBuilder builder = new StringBuilder();
    String line;
    try (BufferedReader bufferedReader = new BufferedReader(new FileReader("src/Model/CheckScripts/" + fileName+".txt"))) {
      while ((line = bufferedReader.readLine()) != null) {
        builder.append(line);
      }
    }
    catch (FileNotFoundException e) {
      System.out.println("El archivo " +fileName+ " no fue encontrado");

    }
    catch (IOException e) {
      System.out.println("Algo salio mal");

    }
    int a = 0;
    String[] s = builder.toString().split(";");
    for (int j=0;j<s.length;j++) {
      try {
        connection.executeCreationQuery(s[j]);
      }
      catch (SQLException e) {
        a++;
        //e.printStackTrace();
        System.out.println(s[j]);
      }
    }

    System.out.println("Se tienen "+s.length+" consultas de las cuales "+a+" tienen errores.");

  }


  @Override
  public void run() {
    this.connection = connection;
    try {
      errors = connection.executeCheckQuery("SELECT * FROM errores;");
    }
    catch (SQLException e) {
      System.out.println("La query probablemente \"SELECT * FROM errores;\" esta incorrecta");
    }


  }
}
