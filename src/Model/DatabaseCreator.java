package Model;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.sql.SQLException;

/**
 * Clase que crea las tablas, con las respectivas constraints.
 * @author Belisario Panay
 */
public class DatabaseCreator implements Runnable {
    SQLConnection connection;


    /**
     * El constructor guarda la conexion a la base de datos.
     * @param connection
     */
    public DatabaseCreator(SQLConnection connection) {
        this.connection = connection;
    }

    /**
     *Se lee de un archivo de texto plano, el cual se pasa a String para poder hacer la query en la base de datos.
     */
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
            System.out.println("El archivo Tablas.txt no fue encontrado");

        }
        catch (IOException e) {
            System.out.println("Algo salio mal");

        }

        String[] s = builder.toString().split(";");
        for (int j=0;j<s.length;j++) {
            try {
                connection.executeCreationQuery(s[j]);
            }
            catch (SQLException e) {
                System.out.println(s[j]);
            }
        }

    }

    public void addData(String lineOfData,String tableName) {

            try {
                connection.executeAddQuery(lineOfData,tableName);
            } catch (SQLException e) {
                e.printStackTrace();
            }

    }
}
