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
    DatabaseCreator creator;
    StringBuilder data;

    /**
     * Se setea la coneccion y se crea la base de datos vacia.
     */
    public DataBaseModel(){

         /*Se crea la conexion con la base de datos*/
        try {
            connection = new SQLConnection();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        creator = new DatabaseCreator(connection);
        creator.run();



    }

    /**
     * Primero se agregan los datos a la BD, luego se realizan las query para poblar errores y
     * finalmente se devuelven los errores.
     * @return filas de la tabla de errores
     */
    public List<Error> getErrors() {
        //creator.addData(data);
        Checker checker = new Checker(connection);
        return checker.getErrors();

    }

    /**
     * Se lee el archivo linea a linea, (esto falta)cada vez que se lea una linea se agregara a la base de datos.
     * @param file
     * @throws IOException
     */
    public void loadData(File file) throws IOException{
        try(BufferedReader br = new BufferedReader(new FileReader(file))) {
            data = new StringBuilder();
            String line = br.readLine();

            while (line != null) {
                data.append(line);
                data.append(System.lineSeparator());
                line = br.readLine();
            }

        }
    }
}
