package View;

import Model.DataBaseModel;
import Model.SQLConnection;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.image.Image;
import javafx.stage.Stage;
import sample.Controller;

import java.io.IOException;
import java.sql.SQLException;

/**
 * Created by bpanay on 24-01-2017.
 */
public class Stages {
    private static Stages ourInstance = new Stages();
    private static Stage primaryStage;
    private static FXMLLoader fxmlLoader;

    public static Stages getInstance() {
        return ourInstance;
    }

    public void setPrimaryStage(Stage primaryStage) {
        this.primaryStage = primaryStage;

    }

    public void createScene(Stage primaryStage) throws IOException, SQLException {
        fxmlLoader = new FXMLLoader(getClass().getResource("../sample/main.fxml"));
        this.primaryStage = primaryStage;
        Parent root = fxmlLoader.load();
        primaryStage.getIcons().add(new Image("file:src/Images/MeeseeksLogo.png"));
        primaryStage.setTitle("Hello World");


        DataBaseModel myModel = new DataBaseModel();
        Controller myController = fxmlLoader.getController();
        myController.initModel(myModel, primaryStage, fxmlLoader);

        SQLConnection connection = new SQLConnection();
        primaryStage.setScene(new Scene(root, 800, 600));
        //Stages stages = Stages.getInstance();
        primaryStage.setResizable(true);
        primaryStage.show();

    }

    private Stages() {



    }

    public Stage getPrimaryStage() {
        return primaryStage;
    }

}
