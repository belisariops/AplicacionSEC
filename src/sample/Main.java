package sample;

import Model.DataBaseModel;
import Model.SQLConnection;
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
        FXMLLoader fxmlLoader = new FXMLLoader(getClass().getResource("main.fxml"));
        Parent root = fxmlLoader.load();
        primaryStage.getIcons().add(new Image("file:src/Images/MeeseeksLogo.png"));
        primaryStage.setTitle("Hello World");


        DataBaseModel myModel = new DataBaseModel();
        Controller myController = fxmlLoader.getController();
        myController.initModel(myModel,primaryStage,fxmlLoader);

        SQLConnection connection = new SQLConnection();
        primaryStage.setScene(new Scene(root, 800, 600));
        //Stages stages = Stages.getInstance();
        primaryStage.show();



    }


    public static void main(String[] args) {
        launch(args);
    }
}
