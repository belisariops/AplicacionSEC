package sample;

import Model.DataBaseModel;
import Model.SQLConnection;
import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.image.Image;
import javafx.scene.layout.AnchorPane;
import javafx.stage.Stage;

public class Main extends Application {
    public static Stage myStage;

    @Override
    public void start(Stage primaryStage) throws Exception{
        FXMLLoader fxmlLoader = new FXMLLoader(getClass().getResource("main.fxml"));
        Parent root = fxmlLoader.load();
        primaryStage.getIcons().add(new Image("file:src/Images/MeeseeksLogo.png"));
        primaryStage.setTitle("Hello World");


        DataBaseModel myModel = new DataBaseModel();
        Controller myController = fxmlLoader.getController();
        myController.initModel(myModel,primaryStage,fxmlLoader);

        new Thread(new SQLConnection()).start();
        //SQLConnection connection = new SQLConnection();
        //connection.closeConnection();



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



    }


    public static void main(String[] args) {
        launch(args);
    }
}
