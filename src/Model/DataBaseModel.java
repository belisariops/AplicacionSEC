package Model;

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
        StringBuilder insertQuery = new StringBuilder();
        StringBuilder insertValues = new StringBuilder();
        int count = 0;

        try(BufferedReader br = new BufferedReader(new FileReader(file))) {
            String line = br.readLine();

            while (line != null) {

                /* Debemos ir insertando valores aunque tenga valores nulos en algunos campos,
                 * por lo que se insertarán valor a valor y con los campor respectivos
                 * que no tengan valor nulo.
                 */
                int insertedValues = 0;
                insertQuery = new StringBuilder();
                insertValues = new StringBuilder();

                /* Query insert into de sqlite. */
                insertQuery.append("INSERT INTO ");
                insertQuery.append(tableName);
                insertQuery.append(" (");

                /* Separamos la línea por los valores entre las comas. */
                List<String> list = new ArrayList<String>(Arrays.asList(line.split(",")));

                insertValues.append(" (");

                /* Iteramos sobre los valores a insertar. */
                for (int i = 1; i < list.size(); i++) {
                    if(!list.get(i).equals("")){
                        if(!isNumeric(list.get(i)))
                            list.set(i, "'" + list.get(i) + "'");

                        if(insertedValues == 0){
                            insertQuery.append(columnNames.get(i));
                            insertValues.append(list.get(i));
                            insertedValues++;
                            continue;
                        }
                        insertQuery.append(",");
                        insertQuery.append(columnNames.get(i));
                        insertValues.append(",");
                        insertValues.append(list.get(i));
                    }
                }
                insertQuery.append(") VALUES \n");
                insertValues.append(");\n");
                count++;
                if(count == 100) {
                    try {
                        connection.executeAddQuery(insertQuery.toString() + insertValues.toString());
                    } catch (SQLException e) {
                        System.out.println(insertQuery.toString() + insertValues.toString());
                    }
                }
                line = br.readLine();
            }
            try {
                if(!insertQuery.toString().equals(""))
                    connection.executeAddQuery(insertQuery.toString() + insertValues.toString());
            } catch (SQLException e){
                System.out.println(insertQuery.toString() + insertValues.toString());
            }
        }
    }

    private boolean isNumeric(String str)
    {
        try
        {
            double d = Double.parseDouble(str);
        }
        catch(NumberFormatException nfe)
        {
            return false;
        }
        return true;
    }

    /**
     * Crea la base de datos en una tabla a partir de un archivo csv.
     * @return retorna un hash con los datos de cada tabla.
     * Llave nombre de la tabla, valores una lista con las columnas de ella.
     */
    private Map<String,ArrayList<String>> createDataBaseModel() {
        Map<String, ArrayList<String>> myMap = new HashMap<>();

        String csvFile = "src/Model/DataBaseCsv/DataBase.csv";

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

        String csvFile = "src/Model/DataBaseCsv/Empresas.csv";

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
     * Para obtener las 100 primeras filas de una tabla.
     */
    public List<Error> getTable(){
        List<Error> errors = new ArrayList<>();
        try {
                errors = connection.executeCheckQuery("SELECT * FROM VERTICE_TRAMO_BT;");
        }
        catch (SQLException e) {
            System.out.println("La query probablemente esta incorrecta");
        }

        return errors;
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
