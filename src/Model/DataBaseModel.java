package Model;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;


/**
 * @author Joaquin Torres
 */
public class DataBaseModel {
    private SQLConnection connection;
    private Checker checker;

    public DataBaseModel(){

         /*Se crea la conexion con la base de datos*/
        try {
            connection = new SQLConnection();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        DatabaseCreator creator = new DatabaseCreator(connection);
        creator.run();
        checker = new Checker(connection);



    }

    public void checkErrors() {
        List<Error> errors = new Checker(connection).getErrors();

    }

    public void loadData(File file) throws IOException{
        try(BufferedReader br = new BufferedReader(new FileReader(file))) {
            StringBuilder sb = new StringBuilder();
            String line = br.readLine();

            while (line != null) {
                sb.append(line);
                sb.append(System.lineSeparator());
                line = br.readLine();
            }
            String everything = sb.toString();
            System.out.println( everything);
        }
    }
}
