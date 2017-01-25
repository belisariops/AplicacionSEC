package Model;

import java.sql.SQLException;
import java.util.List;

/**
 * Created by bpanay on 25-01-2017.
 */
public class Checker {
  private SQLConnection connection;
  private List<Error> errors;

  public Checker(SQLConnection connection) {
    this.connection = connection;
    try {
      errors = connection.executeCheckQuery("SELECT * FROM errores;");
    }
    catch (SQLException e) {
      System.out.println("La query probablemente \"SELECT * FROM errores;\" esta incorrecta");
    }
  }

  public List<Error> getErrors() {
    return errors;
  }


}
