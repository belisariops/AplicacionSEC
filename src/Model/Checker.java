package Model;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import javafx.scene.control.ProgressBar;
import javafx.scene.control.ProgressIndicator;
import javafx.scene.paint.Color;

/**
 * @author Belisario Panay
 */
public class Checker implements  Runnable {
  private SQLConnection connection;
  private List<Error> errors;
  private ProgressBar indicator;
  private double progress;
  public Checker(SQLConnection connection)  {
    this.connection = connection;
    progress = 0.0;
  }
  public List<Error> getErrors(ProgressBar indicator) {
      this.indicator = indicator;
      indicator.setProgress(0);
      executeCheck("resultsCheckQueries");
      //indicator.setProgress(1.0/7.0);
      executeCheck("resultsPrimaryKey");
      //indicator.setProgress(2.0/7.0);
      executeCheck("resultUpdatingTables");
      //indicator.setProgress(3.0/7.0);
      executeCheck("resultForeignKey");
      //indicator.setProgress(4.0/7.0);
      executeCheck("resultUpdatingTables");
     // indicator.setProgress(5.0/7.0);
      executeCheck("resultsRecursiveError");
      ///indicator.setProgress(6.0/7.0);
      executeCheck("resultsPeriodoStarId");
      //indicator.setProgress(7.0/7.0);
      run();
      setBarColor(indicator, new Color(34.0/255.0,139.0/255.0,34.0/255.0, 1));
      return errors;
  }

    /**
     * Se realizan las query para poblar las tabla de errores, las cuales son todas las filas que no cumplen con las
     * constraints que existian en la base de datos Oracle.
     * @param fileName
     */
  private void executeCheck(String fileName) {
    StringBuilder builder = new StringBuilder();
    String line;
    progress = 0;
    indicator.setProgress(progress);
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
        progress += 1.0/((double)s.length);
        indicator.setProgress(progress);
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

  public synchronized double getProgress() {
      return progress;
  }

    private void setBarColor(ProgressBar bar, Color newColor) {
        bar.lookup(".bar").setStyle("-fx-background-color: -fx-box-border, " + createGradientAttributeValue(newColor));
    }

    private String createGradientAttributeValue(Color newColor) {
        String hsbAttribute = createHsbAttributeValue(newColor);
        return "linear-gradient(to bottom, derive(" + hsbAttribute+ ",30%) 5%, derive(" + hsbAttribute + ",-17%))";
    }

    private String createHsbAttributeValue(Color newColor) {
        return
            "hsb(" +
                (int)  newColor.getHue()               + "," +
                (int) (newColor.getSaturation() * 100) + "%," +
                (int) (newColor.getBrightness() * 100) + "%)";
    }

}
