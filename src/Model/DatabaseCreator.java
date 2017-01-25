package Model;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.sql.SQLException;

/**
 * Created by bpanay on 25-01-2017.
 */
public class DatabaseCreator implements Runnable {
    SQLConnection connection;

    public DatabaseCreator(SQLConnection connection) {
        this.connection = connection;
    }

    @Override
    public void run() {
        StringBuilder builder = new StringBuilder();
        String line;
        try (BufferedReader bufferedReader = new BufferedReader(new FileReader("src/Model/TablasCompleto.sql"))) {
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
                connection.executeQuery(s[j]);
            }
            catch (SQLException e) {
                System.out.println(s[j]);
            }
        }
    }
}
