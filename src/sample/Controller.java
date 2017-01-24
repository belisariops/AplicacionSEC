package sample;

import Model.DataBaseModel;
import javafx.fxml.FXML;
import javafx.scene.control.Button;
import javafx.scene.control.TextField;
import javafx.stage.FileChooser;

import java.io.File;
import java.io.IOException;

import static sample.Main.myStage;

public class Controller {

    private DataBaseModel model;

    @FXML
    private Button myButton;

    public void initModel(DataBaseModel model) {
        if (this.model != null) {
            throw new IllegalStateException("Model can only be initialized once");
        }
        this.model = model ;
    }

    @FXML
    private TextField text;

    @FXML void buttonPressed() {
        FileChooser fileChooser  = new FileChooser();
        fileChooser.setTitle("Seleccionar archivo");
        File file = fileChooser.showOpenDialog(myStage);
        if (file != null) {
            try {
                model.loadData(file);
            } catch (IOException exc) {
                // handle exception...
            }
        }
    }




}
