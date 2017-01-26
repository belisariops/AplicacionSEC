package sample;

import Model.DataBaseModel;
import java.io.File;
import java.io.IOException;
import javafx.beans.value.ChangeListener;
import javafx.beans.value.ObservableValue;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.geometry.Bounds;
import javafx.geometry.Point2D;
import javafx.geometry.Pos;
import javafx.scene.Node;
import javafx.scene.control.Button;
import javafx.scene.control.ComboBox;
import javafx.scene.control.Label;
import javafx.scene.control.Labeled;
import javafx.scene.image.ImageView;
import javafx.scene.layout.Pane;
import javafx.scene.text.Font;
import javafx.stage.FileChooser;
import javafx.stage.Stage;

public class Controller {

    private DataBaseModel model;
    private Stage stage;
    private FXMLLoader fxmlLoader;

    @FXML
    private Pane site;
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
        myButton.setMinSize(130, 30);
        myButton.setMaxSize(130, 30);
        textoSeleccione.setMinSize(300, 30);
        textoSeleccione.setMaxSize(300, 30);
        textoSeleccione.setFont(new Font("Times new roman", 20));
        textoArchivo.setMinSize(300, 30);
        textoArchivo.setMaxSize(300, 30);
        textoArchivo.setFont(new Font("Times new roman", 20));
        myComboBox.setMinSize(130, 30);
        myComboBox.setMaxSize(130, 30);

        site.heightProperty().addListener(new ChangeListener<Number>() {

            @Override
            public void changed(ObservableValue<? extends Number> arg0,
                Number oldValue, Number newValue) {

                fixButtonWithResize(myButton, oldValue, newValue, false);
                fixButtonWithResize(textoSeleccione, oldValue, newValue, false);
                fixButtonWithResize(textoArchivo, oldValue, newValue, false);
                fixComboBoxWithResize(myComboBox, oldValue, newValue, false);


                //textoArchivo.setFont(new Font("Arial", alpha*textoArchivo.getFont().getSize()));
                //textoSeleccione.setFont(new Font("Arial", alpha*textoSeleccione.getFont().getSize()));
                //myButton.relocate(widthPane*0.5, heightPane*0.5);
            }
        });
        site.widthProperty().addListener(new ChangeListener<Number>() {



            @Override
            public void changed(ObservableValue<? extends Number> arg0,
                Number oldValue, Number newValue) {

                fixButtonWithResize(myButton, oldValue, newValue, true);
                fixButtonWithResize(textoSeleccione, oldValue, newValue, true);
                fixButtonWithResize(textoArchivo, oldValue, newValue, true);
                fixComboBoxWithResize(myComboBox, oldValue, newValue, true);
                //myButton.setFont(new Font("Arial", alpha*myButton.getFont().getSize()));

                //textoArchivo.setFont(new Font("Arial", alpha*20));
                //textoSeleccione.setFont(new Font("Arial", alpha*textoSeleccione.getFont().getSize()));
                //myButton.relocate(widthPane*0.5, heightPane*0.5);
            }
        });
    }


    private void fixLabelWithResize(Label label, Number oldValue, Number newValue){
        Point2D myPosition = getPosition(label);
        double xButton = myPosition.getX();
        double yButton = myPosition.getY();

        double alpha = newValue.doubleValue()/oldValue.doubleValue();
        if (oldValue.doubleValue() == 0){
            alpha = 1;
        }

        if(alpha > 1) {
            label.relocate(xButton/ (oldValue.doubleValue()/newValue.doubleValue()), yButton );
        }
        else
            label.relocate(xButton*alpha, yButton);

        label.setFont(new Font("Times New Roman", label.getFont().getSize()*Math.sqrt(alpha)));
    }

    private Point2D getPosition(Node node){
        double nodeMinY = node.getLayoutBounds().getMinY();
        double nodeMinX = node.getLayoutBounds().getMinX();

        return node.localToScene(nodeMinX, nodeMinY);
    }

    private void fixComboBoxWithResize(ComboBox button, Number oldValue, Number newValue, boolean side){
        Point2D myPosition = getPosition(button);
        double xButton = myPosition.getX();
        double yButton = myPosition.getY();

        double alpha = newValue.doubleValue()/oldValue.doubleValue();
        if (oldValue.doubleValue() == 0){
            alpha = 1;
        }

        if(side) {
            button.setMinWidth(button.getMaxWidth() * alpha);
            button.setMaxWidth(button.getMaxWidth() * alpha);
            if(alpha > 1) {
                button.relocate(xButton/ (oldValue.doubleValue()/newValue.doubleValue()), yButton );
            }
            else
                button.relocate(xButton*alpha, yButton);
        } else {
            button.setMinHeight(button.getMaxHeight()*alpha);
            button.setMaxHeight(button.getMaxHeight()*alpha);
            if(alpha > 1) {
                button.relocate(xButton, yButton / (oldValue.doubleValue()/newValue.doubleValue()));
            }
            else
                button.relocate(xButton, yButton*alpha);
        }

    }
    private void fixButtonWithResize(Labeled button, Number oldValue, Number newValue, boolean side){
        Point2D myPosition = getPosition(button);
        double xButton = myPosition.getX();
        double yButton = myPosition.getY();

        double alpha = newValue.doubleValue()/oldValue.doubleValue();
        if (oldValue.doubleValue() == 0){
            alpha = 1;
        }

        if(side) {
            button.setMinWidth(button.getMaxWidth() * alpha);
            button.setMaxWidth(button.getMaxWidth() * alpha);
            if(alpha > 1) {
                button.relocate(xButton/ (oldValue.doubleValue()/newValue.doubleValue()), yButton );
            }
            else
                button.relocate(xButton*alpha, yButton);
        } else {
            button.setMinHeight(button.getMaxHeight()*alpha);
            button.setMaxHeight(button.getMaxHeight()*alpha);
            if(alpha > 1) {
                button.relocate(xButton, yButton / (oldValue.doubleValue()/newValue.doubleValue()));
            }
            else
                button.relocate(xButton, yButton*alpha);
        }


        button.setFont(new Font("Times New Roman", button.getFont().getSize()*Math.sqrt(alpha)));
    }

    @FXML void buttonPressed() {
        FileChooser fileChooser  = new FileChooser();
        fileChooser.setTitle("Seleccionar archivo");
        File file = fileChooser.showOpenDialog(stage);
        if (file != null) {
            try {
                model.loadData(file);
            } catch (IOException exc) {

            }
        }
    }




}
