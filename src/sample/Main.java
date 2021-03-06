package sample;

import Model.DataBaseModel;
import Zip.ZipCreator;
import java.io.File;
import java.util.ArrayList;
import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.image.Image;
import javafx.stage.Stage;
import net.lingala.zip4j.exception.ZipException;

/**
 * Toda aplicacion de JavaFx debe extender Application.
 * @author Belisario Panay, Joaquin Torres
 */
public class Main extends Application {

    /**
     * Luego de ejecutar el metodo main, lo primero que hara la aplicacion es ejecutar este metodo,
     * el cual cargara el archivo fxml encargado de la vista, el controlador, el modelo y creara la
     * base de datos local (SQLite) en memoria.
     * @param primaryStage
     * @throws Exception
     */
    @Override
    public void start(Stage primaryStage) throws Exception{
        /*Se carga la vista*/
        FXMLLoader fxmlLoader = new FXMLLoader(getClass().getResource("main.fxml"));
        Parent root = fxmlLoader.load();
        primaryStage.getIcons().add(new Image("file:src/Images/Logo2.png"));
        primaryStage.setTitle("Data checker");

        /*Se crea el modelo*/
        DataBaseModel myModel = new DataBaseModel();
        /*Se crea el controller y se le entrega el modelo*/
        Controller myController = fxmlLoader.getController();
        myController.initModel(myModel,primaryStage,fxmlLoader);



        Scene scene = new Scene(root, 800, 600);

        primaryStage.setScene(scene);

        //Stages stages = Stages.getInstance();
        //primaryStage.setResizable(false);
        primaryStage.show();

        /*
         * Script para probar encriptación de datos.
         *
        DataCryptor crypting = new DataCryptor("SEC_INTERRUPCIONES2016");
        String encrypt = crypting.encrypt("ALIMENTADOR;PROVIDENCIA;1342");
        String dencrypt = crypting.decrypt(encrypt);

        System.out.println( encrypt);
        System.out.println( dencrypt);
        */
        /* Ejemplo que crea un archivo zip con clave.
        try {
            ArrayList<File> files = new ArrayList<File>();
            files.add(new File("src/sample/test.txt"));
            files.add(new File("src/sample/test2.txt"));

            ZipCreator zip = new ZipCreator(files);
        }
        catch (ZipException e) {
            e.printStackTrace();
        }
        */



    }


    public static void main(String[] args) {
        launch(args);
    }
}
