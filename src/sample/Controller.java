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

    /* Objetos de la ventana
     * Para agregar más objetos abrir archivo main.fxml con SceneBuilder
     * y agregar una variable más que sea la adecuada para el objeto creado en pantalla.
     */
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

        // Datos a ingresar a la tabla de errores.
        data = FXCollections.observableArrayList();

        // Tamaño minimo de la ventana.
        primaryStage.setMinWidth(400);
        primaryStage.setMinHeight(300);

        // Initializar tamaños y valores.
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

        // Agregar columnas de errores a la tabla.
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

        // Para que automaticamente use todo el ancho de la tabla
        myView.setColumnResizePolicy(TableView.CONSTRAINED_RESIZE_POLICY);

        /*
         * Aqui agregamos un listener a todos los objetos para que se redimensionen al crecer la ventana.
         * Este es para el alto de los objetos.
         */
        site.heightProperty().addListener(new ChangeListener<Number>() {

            @Override
            public void changed(ObservableValue<? extends Number> arg0,
                Number oldValue, Number newValue) {


                fixLabeledWithResize(myButton, oldValue, newValue, false);
                fixLabeledWithResize(textoSeleccione, oldValue, newValue, false);
                fixLabeledWithResize(textoArchivo, oldValue, newValue, false);
                fixControlWithResize(myComboBox, oldValue, newValue, false);
                fixControlWithResize(myView, oldValue, newValue, false);
                fixLabeledWithResize(textoErrores, oldValue, newValue, false);
            }
        });

        /*
         * Aqui agregamos un listener a todos los objetos para que se redimensionen al crecer la ventana.
         * Este es para el ancho de los objetos.
         */
        site.widthProperty().addListener(new ChangeListener<Number>() {
            @Override
            public void changed(ObservableValue<? extends Number> arg0,
                Number oldValue, Number newValue) {

                fixLabeledWithResize(myButton, oldValue, newValue, true);
                fixLabeledWithResize(textoSeleccione, oldValue, newValue, true);
                fixLabeledWithResize(textoArchivo, oldValue, newValue, true);
                fixControlWithResize(myComboBox, oldValue, newValue, true);
                fixLabeledWithResize(textoErrores, oldValue, newValue, true);
                fixControlWithResize(myView, oldValue, newValue, true);
            }
        });
    }

    /**
     * Dado el nodo en la ventana, retorna la posición de este nodo.
     * @param node Nodo en la ventana.
     * @return Retorna un objeto Point2D con las coordenadas en la ventana.
     */
    private Point2D getPosition(Node node){
        double nodeMinY = node.getLayoutBounds().getMinY();
        double nodeMinX = node.getLayoutBounds().getMinX();

        return node.localToScene(nodeMinX, nodeMinY);
    }

    /**
     * Método para redimensionar objetos de tipo control (ComboBox).
     * @param control objeto a redimensionar.
     * @param oldValue tamaño de la antigua ventana.
     * @param newValue tamaño de la nueva ventana.
     * @param side Verdadero si es para ancho, falso para alturas.
     */
    private void fixControlWithResize(Control control, Number oldValue, Number newValue, boolean side){
        Point2D myPosition = getPosition(control);
        double xButton = myPosition.getX();
        double yButton = myPosition.getY();

        double alpha = getAlpha(newValue.doubleValue(), oldValue.doubleValue());

        if(side) {
            control.setMinWidth(control.getMaxWidth() * alpha);
            control.setMaxWidth(control.getMaxWidth() * alpha);
            if(alpha > 1) {
                control.relocate(xButton/ (oldValue.doubleValue()/newValue.doubleValue()), yButton );
            }
            else
                control.relocate(xButton*alpha, yButton);
        } else {
            control.setMinHeight(control.getMaxHeight()*alpha);
            control.setMaxHeight(control.getMaxHeight()*alpha);
            if(alpha > 1) {
                control.relocate(xButton, yButton / (oldValue.doubleValue()/newValue.doubleValue()));
            }
            else
                control.relocate(xButton, yButton*alpha);
        }

    }

    /**
     * Esto sirve para setear las redimensiones de los objetos en pantalla, en este caso los de tipo Labeled.
     *
     * @param label Objeto que se debe redimensionar.
     * @param oldValue tamaño de la ventana antigua.
     * @param newValue tamaño de la nueva ventana.
     * @param side Verdadero si es para ancho, falso para alturas.
     */
    private void fixLabeledWithResize(Labeled label, Number oldValue, Number newValue, boolean side){
        fixControlWithResize(label, oldValue, newValue, side);

        double alpha = newValue.doubleValue()/oldValue.doubleValue();
        if (oldValue.doubleValue() == 0){
            alpha = 1;
        }

        label.setFont(new Font("Bodoni MT", label.getFont().getSize()*Math.sqrt(alpha)));
    }

    /**
     * Calcula la proporcion entre el tamaño de la ventana antigua
     *  vs el tamaño de la ventana nueva.
     * @param newValue tamaño de la nueva ventana.
     * @param oldValue tamaño de la antigua ventana.
     * @return Retorna la proporción de reajuste de la ventana.
     */
    private double getAlpha(double newValue, double oldValue){
        double alpha = newValue/oldValue;
        if (oldValue == 0){
            alpha = 1;
        }

        return alpha;
    }

    /**
     * Maneja las acciones del boton de cargado de archivos.
     */
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
