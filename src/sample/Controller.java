package sample;

import View.Stages;
import javafx.fxml.FXML;
import javafx.scene.control.Button;
import javafx.scene.control.TextField;
import javafx.scene.text.Text;
import javafx.stage.FileChooser;

public class Controller {

    @FXML
    private Button myButton;

    @FXML
    private TextField text;

    @FXML void buttonPressed() {
        FileChooser fileChooser  = new FileChooser();
        fileChooser.setTitle("Seleccionar archivo");
        fileChooser.showOpenDialog(Stages.getInstance().getFirstStage());
    }




}
