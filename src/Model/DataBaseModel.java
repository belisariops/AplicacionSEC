package Model;

import Model.CheckScripts.Empresa;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;


/**
 * @author Joaquin Torres
 */
public class DataBaseModel {
    private SQLConnection connection;
    private Checker checker;
    DatabaseCreator creator;
    private Map<String, ArrayList<String>> database;
    private List<Empresa> companies;

    /**
     * Se setea la coneccion y se crea la base de datos vacia.
     */
    public DataBaseModel(){

        /* Creamos un hash para guardar el modelo de la base de datos. */
        database = createDataBaseModel();
        /* Cargamos las empresas existentes. */
        loadCompanies();

         /*Se crea la conexion con la base de datos*/
        try {
            connection = new SQLConnection();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        creator = new DatabaseCreator(connection);
        creator.run();
        checker = new Checker(connection);

    }

    /**
     * Primero se agregan los datos a la BD, luego se realizan las query para poblar errores y
     * finalmente se devuelven los errores.
     * @return filas de la tabla de errores
     */
    public List<Error> getErrors() {
        //creator.addData(data)
        return checker.getErrors();
    }

    /**
     * Se lee el archivo linea a linea, (esto falta)cada vez que se lea una linea se agregara a la base de datos.
     * @param file
     * @throws IOException
     */
    public void loadData(File file, String tableName) throws IOException{
        List<String> columnNames = new ArrayList<>();
        columnNames.addAll(database.get(tableName));
        StringBuilder query = new StringBuilder();

        query.append("INSERT INTO ");
        query.append(tableName);
        query.append(" (");
        query.append(columnNames.get(0));
        for(int i = 1; i < columnNames.size(); i++){
            query.append(",");
            query.append(columnNames.get(i));
        }
        query.append(") VALUES \n");

        try(BufferedReader br = new BufferedReader(new FileReader(file))) {
            String line = br.readLine();

            while (line != null) {
                List<String> list = new ArrayList<String>(Arrays.asList(line.split(",")));

                query.append(" (");
                query.append(list.get(0));
                for (int i = 1; i < list.size(); i++) {
                    query.append(",");
                    query.append(list.get(i));
                }
                query.append("),\n");
                line = br.readLine();
            }
            query.replace(query.length()-2, query.length()-1, ";");

            try {
                connection.executeAddQuery(query.toString());
            } catch (SQLException e){
                System.out.println(query.toString());
            }
        }


    }

    /**
     * Crea la base de datos en una tabla a partir de un archivo csv.
     * @return retorna un hash con los datos de cada tabla.
     * Llave nombre de la tabla, valores una lista con las columnas de ella.
     */
    private Map<String,ArrayList<String>> createDataBaseModel() {
        Map<String, ArrayList<String>> myMap = new HashMap<>();

        String csvFile = "src/Model/DataBase.csv";

        BufferedReader br = null;
        String line;
        String cvsSplitBy = ";";

        try {

            br = new BufferedReader(new FileReader(csvFile));
            while ((line = br.readLine()) != null) {

                // usando punto y coma como separador
                String[] column = line.split(cvsSplitBy);

                if (!myMap.containsKey(column[0]))
                    myMap.put(column[0], new ArrayList<>());

                myMap.get(column[0]).add(column[1]);
            }

        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (br != null) {
                try {
                    br.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }

        return myMap;
    }

    /**
     * Carga las empresas existentes en este modelo.
     */
    public void loadCompanies(){
        companies = new ArrayList<>();

        String csvFile = "src/Model/Empresas.csv";

        BufferedReader br = null;
        String line;
        String cvsSplitBy = ";";

        try {

            br = new BufferedReader(new FileReader(csvFile));
            while ((line = br.readLine()) != null) {

                // usando punto y coma como separador
                String[] column = line.split(cvsSplitBy);

                companies.add(new Empresa(Integer.parseInt(column[0]), column[1]));

            }

        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (br != null) {
                try {
                    br.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    /**
     * Para obtener nombres de las tablas.
     * @return retorna una lista con los nombres de las tablas.
     */
    public Set<String> getTables(){
        return database.keySet();
    }

    /**
     * Devuelve las empresas existentes dentro del modelo.
     * @return devuelve una lista con las empresas.
     */
    public List<Empresa> getCompanies(){
        return companies;
    }

}
