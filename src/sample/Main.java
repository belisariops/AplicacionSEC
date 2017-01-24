package sample;

import Model.SQLConnection;
import View.Stages;
import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.image.Image;
import javafx.stage.Stage;

public class Main extends Application {
    public static Stage myStage;
    @Override
    public void start(Stage primaryStage) throws Exception{
        Parent root = FXMLLoader.load(getClass().getResource("main.fxml"));
        primaryStage.getIcons().add(new Image("file:src/Images/MeeseeksLogo.png"));
        primaryStage.setTitle("Hello World");
        primaryStage.setScene(new Scene(root, 800, 600));
        //Stages stages = Stages.getInstance();
        myStage = primaryStage;
        primaryStage.show();


        SQLConnection connection = new SQLConnection();
    }


    public static void main(String[] args) {
        launch(args);
    }
}
