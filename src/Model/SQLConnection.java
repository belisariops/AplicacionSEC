package Model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/**
 * SQLConnection se encargara de conversar con la base de datos,
 * esta base de datos se alamcenara en memoria.
 * @author Belisario Panay
 */
public class SQLConnection {
    Connection connection;
    private String path;

    /**
     * Constructor de la clase, este crea la conexion que sera usada
     * mientras la aplicacion se encuentra abierta.
     * @throws SQLException
     */
    public SQLConnection() throws SQLException {
        connection = DriverManager.getConnection("jdbc:sqlite::memory:");
    }

    /**
     * Metodo para cerrar la conexion, solo sera invocado cuando se cierre la aplicacion.
     * @throws SQLException
     */
    public void closeConnection() throws SQLException {
        connection.close();
    }


    /**
     * Este metodo ejecutara la query que se le envie (solo para insertar, sin respuesta de la BD),
     * es un metodo syncronyzed para que solo un thread pueda usar el metodo.
     * @param SQLquery
     * @throws SQLException
     */
    public synchronized void executeCreationQuery(String SQLquery) throws SQLException {
        Statement s = connection.createStatement();
        s.executeUpdate(SQLquery);
        s.close();
    }

    /**
     * Metodo que recibe la query para chequear errores y retorna la tabla de errores en forma de una
     * lista de objetos "Error", el cual posee getters y setters de los columnas de la tabla.
     * @param SQLquery
     * @return List<Error>
     * @throws SQLException
     */
    public synchronized List<Error> executeCheckQuery(String SQLquery) throws  SQLException {
        Statement s = connection.createStatement();
        ResultSet result = s.executeQuery(SQLquery);
        List<Error> errorList = new ArrayList<>();
        while (result.next()) {
            int rowId = result.getInt("d_rowid");
            String tableName = result.getString("table_name");
            String constraintName = result.getString("constraint_name");
            char type = result.getString("type").toCharArray()[0];
            errorList.add(new Error(rowId,tableName,constraintName,type));
        }
        return errorList;
    }

    public Connection getConnection() {
        return connection;
    }

}
