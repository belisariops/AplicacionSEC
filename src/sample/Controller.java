package sample;

import Model.DataBaseModel;
import javafx.beans.value.ChangeListener;
import javafx.beans.value.ObservableValue;
import javafx.collections.FXCollections;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.geometry.Bounds;
import javafx.geometry.Insets;
import javafx.scene.control.*;
import javafx.scene.image.ImageView;
import javafx.scene.layout.AnchorPane;
import javafx.scene.layout.Pane;
import javafx.scene.layout.TilePane;
import javafx.scene.text.Font;
import javafx.scene.text.Text;
import javafx.stage.FileChooser;
import javafx.stage.Stage;
import javafx.util.Callback;


import java.io.File;
import java.io.IOException;

public class Controller {

    private DataBaseModel model;
    private Stage stage;
    private FXMLLoader fxmlLoader;

    @FXML
    private Pane site;
    @FXML
    private Pane formulario;
    @FXML
    private ImageView secTile;
    @FXML
    private Button myButton;
    @FXML
    private Label textoSeleccione;
    @FXML
    private Label textoArchivo;
    @FXML
    private ComboBox<String> myComboBox;


    public void initModel(DataBaseModel model, Stage primaryStage, FXMLLoader fxmlLoader) {
        if (this.model != null) {
            throw new IllegalStateException("Model can only be initialized once");
        }
        this.model = model ;
        this.stage = primaryStage;
        this.fxmlLoader = fxmlLoader;
        secTile.fitWidthProperty().bind(stage.widthProperty());
        secTile.fitHeightProperty().bind(stage.heightProperty());

        site.heightProperty().addListener(new ChangeListener<Number>() {

            @Override
            public void changed(ObservableValue<? extends Number> arg0,
                                 Number oldValue, Number newValue) {
                Bounds boundsInScene = formulario.localToScene(formulario.getBoundsInLocal());
                int xPane = (int) boundsInScene.getMinX();
                int yPane = (int) boundsInScene.getMinY();
                boundsInScene = secTile.localToScene(secTile.getBoundsInLocal());
                int heightImage = (int) boundsInScene.getMaxY();

                double alpha = newValue.doubleValue()/oldValue.doubleValue();

                formulario.relocate(xPane, yPane);
                formulario.setMaxSize(formulario.getMaxWidth(), formulario.getMaxHeight() * alpha);
                formulario.setMinSize(formulario.getMaxWidth(), formulario.getMaxHeight() * alpha);

                myButton.setMinSize(myButton.getMaxWidth(), myButton.getMaxHeight()*alpha);
                myButton.setMaxSize(myButton.getMaxWidth(), myButton.getMaxHeight()*alpha);
                //myButton.setFont(new Font("Arial", alpha*myButton.getFont().getSize()));

                //textoArchivo.setFont(new Font("Arial", alpha*textoArchivo.getFont().getSize()));
                //textoSeleccione.setFont(new Font("Arial", alpha*textoSeleccione.getFont().getSize()));
                //myButton.relocate(widthPane*0.5, heightPane*0.5);
            }
        });
        site.widthProperty().addListener(new ChangeListener<Number>() {

            @Override
            public void changed(ObservableValue<? extends Number> arg0,
                                Number oldValue, Number newValue) {

                Bounds boundsInScene = formulario.localToScene(formulario.getBoundsInLocal());
                int yPane = (int) boundsInScene.getMinY();
                int xPane = (int) boundsInScene.getMinX();

                double alpha = newValue.doubleValue()/oldValue.doubleValue();

                formulario.relocate(xPane, yPane);
                formulario.setMaxSize(formulario.getMaxWidth()*alpha, formulario.getMaxHeight());
                formulario.setMinSize(formulario.getMaxWidth()*alpha, formulario.getMaxHeight());

                myButton.setMinSize(myButton.getMaxWidth()*alpha, myButton.getMaxHeight());
                myButton.setMaxSize(myButton.getMaxWidth()*alpha, myButton.getMaxHeight());
                //myButton.setFont(new Font("Arial", alpha*myButton.getFont().getSize()));

                //textoArchivo.setFont(new Font("Arial", alpha*20));
                //textoSeleccione.setFont(new Font("Arial", alpha*textoSeleccione.getFont().getSize()));
                //myButton.relocate(widthPane*0.5, heightPane*0.5);
            }
        });



    }

    @FXML void buttonPressed() {
        FileChooser fileChooser  = new FileChooser();
        fileChooser.setTitle("Seleccionar archivo");
        File file = fileChooser.showOpenDialog(stage);
        if (file != null) {
            try {
                model.loadData(file);
            } catch (IOException exc) {
                // handle exception...
            }
        }
    }




}
