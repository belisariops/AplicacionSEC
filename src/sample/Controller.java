package sample;

import Model.DataBaseModel;
import Model.Error;
import java.io.File;
import java.io.IOException;
import java.util.List;
import javafx.beans.value.ChangeListener;
import javafx.beans.value.ObservableValue;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.geometry.Point2D;
import javafx.scene.Node;
import javafx.scene.control.Button;
import javafx.scene.control.ComboBox;
import javafx.scene.control.Control;
import javafx.scene.control.Label;
import javafx.scene.control.Labeled;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import javafx.scene.control.cell.PropertyValueFactory;
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
    private Label textoErrores;
    @FXML
    private ComboBox<String> myComboBox;
    @FXML
    private TableView<Error> myView;

    private ObservableList<Error> data;

    public void initModel(DataBaseModel model, Stage primaryStage, FXMLLoader fxmlLoader) {
        if (this.model != null) {
            throw new IllegalStateException("Model can only be initialized once");
        }
        this.model = model ;
        this.stage = primaryStage;
        this.fxmlLoader = fxmlLoader;

        data = FXCollections.observableArrayList();

        primaryStage.setMinWidth(400);
        primaryStage.setMinHeight(300);

        secTile.fitWidthProperty().bind(stage.widthProperty());
        secTile.fitHeightProperty().bind(stage.heightProperty());
        myButton.setMinSize(133, 22);
        myButton.setMaxSize(133, 22);
        textoSeleccione.setMinSize(300, 30);
        textoSeleccione.setMaxSize(300, 30);
        textoSeleccione.setFont(new Font("Times new roman", 20));
        textoArchivo.setMinSize(300, 30);
        textoArchivo.setMaxSize(300, 30);
        textoArchivo.setFont(new Font("Times new roman", 20));
        textoErrores.setMinSize(300, 27);
        textoErrores.setMaxSize(300, 27);
        textoErrores.setFont(new Font("Times new roman", 20));
        myComboBox.setMinSize(133, 22);
        myComboBox.setMaxSize(133, 22);
        myView.setMinSize(688,188);
        myView.setMaxSize(688,188);

        TableColumn rowiId = new TableColumn("d_rowid");
        rowiId.setCellValueFactory(new PropertyValueFactory<Error, Integer>("rowId"));
        rowiId.setStyle("-fx-alignment: CENTER;");
        TableColumn tableName = new TableColumn("table_name");
        tableName.setCellValueFactory(new PropertyValueFactory<Error, String>("tableName"));
        tableName.setStyle("-fx-alignment: CENTER;");
        TableColumn constraintName = new TableColumn("constraint_name");
        constraintName.setCellValueFactory(new PropertyValueFactory<Error, String>("constraintName"));
        constraintName.setStyle("-fx-alignment: CENTER;");
        TableColumn type = new TableColumn("type");
        type.setCellValueFactory(new PropertyValueFactory<Error, Character>("type"));
        type.setStyle("-fx-alignment: CENTER;");

        myView.setItems(data);
        myView.getColumns().addAll(rowiId, tableName, constraintName, type);
        myView.setColumnResizePolicy(TableView.CONSTRAINED_RESIZE_POLICY);

        site.heightProperty().addListener(new ChangeListener<Number>() {

            @Override
            public void changed(ObservableValue<? extends Number> arg0,
                Number oldValue, Number newValue) {

                fixButtonWithResize(myButton, oldValue, newValue, false);
                fixButtonWithResize(textoSeleccione, oldValue, newValue, false);
                fixButtonWithResize(textoArchivo, oldValue, newValue, false);
                fixComboBoxWithResize(myComboBox, oldValue, newValue, false);
                fixComboBoxWithResize(myView, oldValue, newValue, false);
                fixButtonWithResize(textoErrores, oldValue, newValue, false);
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
                fixButtonWithResize(textoErrores, oldValue, newValue, true);
                fixComboBoxWithResize(myView, oldValue, newValue, true);
            }
        });
    }

    public void addData(List<Error> newData){
        data.addAll(newData);
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

        label.setFont(new Font("Bodoni MT", label.getFont().getSize()*Math.sqrt(alpha)));
    }

    private Point2D getPosition(Node node){
        double nodeMinY = node.getLayoutBounds().getMinY();
        double nodeMinX = node.getLayoutBounds().getMinX();

        return node.localToScene(nodeMinX, nodeMinY);
    }

    private void fixComboBoxWithResize(Control button, Number oldValue, Number newValue, boolean side){
        Point2D myPosition = getPosition(button);
        double xButton = myPosition.getX();
        double yButton = myPosition.getY();

        double alpha = getAlpha(newValue.doubleValue(), oldValue.doubleValue());

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
        fixComboBoxWithResize(button, oldValue, newValue, side);

        double alpha = newValue.doubleValue()/oldValue.doubleValue();
        if (oldValue.doubleValue() == 0){
            alpha = 1;
        }

        button.setFont(new Font("Bodoni MT", button.getFont().getSize()*Math.sqrt(alpha)));
    }

    private double getAlpha(double newValue, double oldValue){
        double alpha = newValue/oldValue;
        if (oldValue == 0){
            alpha = 1;
        }

        return alpha;
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
