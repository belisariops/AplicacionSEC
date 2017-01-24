package View;

import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.image.Image;
import javafx.stage.Stage;

import java.io.IOException;

/**
 * Created by bpanay on 24-01-2017.
 */
public class Stages {
    private static Stages ourInstance = new Stages();
    private static Stage firstStage;

    public static Stages getInstance() {
        return ourInstance;
    }

    private Stages()  {
        Parent root;
        try {
            root = FXMLLoader.load(getClass().getResource("../sample/main.fxml"));
        }
        catch (IOException e) {
            root = null;
        }
        firstStage.getIcons().add(new Image("file:///C:/Users/bpanay/IdeaProjects/Meeseeks/src/sample/MeeseeksLogo.png"));
        firstStage.setTitle("Hello World");
        firstStage.setScene(new Scene(root, 800, 600));
    }

    public Stage getFirstStage() {
        return firstStage;
    }
}
