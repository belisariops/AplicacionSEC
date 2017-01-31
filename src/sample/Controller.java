package sample;

import Model.Empresa;
import Model.DataBaseModel;
import Model.Error;
import Model.Tabla;
import Model.Vertice_tramo_bt;
import Zip.ZipCreator;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.Timer;
import java.util.TimerTask;
import javafx.animation.Animation;
import javafx.animation.KeyFrame;
import javafx.animation.Timeline;
import javafx.application.Platform;
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
import javafx.scene.control.ListView;
import javafx.scene.control.ProgressBar;
import javafx.scene.control.ProgressIndicator;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import javafx.scene.control.cell.PropertyValueFactory;
import javafx.scene.image.ImageView;
import javafx.scene.input.KeyCode;
import javafx.scene.input.KeyEvent;
import javafx.scene.layout.Pane;
import javafx.scene.text.Font;
import javafx.scene.text.Text;
import javafx.stage.FileChooser;
import javafx.stage.Stage;
import javafx.util.Duration;
import net.lingala.zip4j.exception.ZipException;


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
    private Button okButton;
    @FXML
    private Label textoArchivo;
    @FXML
    private Label textoErrores;
    @FXML
    private Label textoTabla;
    @FXML
    private ProgressBar insertingData;
    @FXML
    private TableView tableList;
    @FXML
    private Button errorCheck;
    @FXML
    private Label textoArchivoCargado;
    @FXML
    private ComboBox<String> comboBoxTablas;
    @FXML
    private ListView listView;
    @FXML
    private TableView myView;
    @FXML
    private ProgressBar indicator;
    @FXML
    private Text indicatorText;
    @FXML
    private Button export;
    @FXML
    private Button errores;

    private ObservableList<Error> data;
    private ObservableList<Vertice_tramo_bt> testData;
    private ObservableList<Tabla> listaTablasCargadas;
    private List<String> tablasCargadas;
    private List<Label> labels;
    private List<ComboBox> comboBoxes;
    private File loadedFile;
    private String fileChooserPath;
    private double fontComboBox;
    private ArrayList<File> filesToAdd;


    public void initModel(DataBaseModel model, Stage primaryStage, FXMLLoader fxmlLoader) {
        if (this.model != null) {
            throw new IllegalStateException("Model can only be initialized once");
        }
        this.model = model ;
        this.stage = primaryStage;
        this.fxmlLoader = fxmlLoader;
        comboBoxes = new ArrayList<>();
        fileChooserPath = "null";
        fontComboBox = 15;
        tablasCargadas = new ArrayList<>();

        /*stage.addEventHandler(KeyEvent.KEY_PRESSED, (key) -> {
            if(key.getCode()== KeyCode.ENTER) {
                testData = FXCollections.observableArrayList();
                testData.removeAll(testData);

                testData.addAll(model.getTable());

                myView.setItems(testData);

                // Para que automaticamente use el ancho de la tabla
                myView.setColumnResizePolicy(TableView.CONSTRAINED_RESIZE_POLICY);
            }
        });*/

        model.setProgressBar(insertingData);
        model.setProgressIndicator(indicator);

        // Datos a ingresar a la tabla de errores.
        data = FXCollections.observableArrayList();

        // juntar labels para ordenar
        labels = new ArrayList<>();
        labels.add(textoArchivo);
        labels.add(textoArchivoCargado);
        labels.add(textoErrores);
        labels.add(textoTabla);

        // juntar comboboxes
        comboBoxes.add(comboBoxTablas);

        // Tamaño minimo de la ventana.
        primaryStage.setMinWidth(400);
        primaryStage.setMinHeight(300);

        // Initializar tamaños y valores.
        secTile.fitWidthProperty().bind(stage.widthProperty());
        secTile.fitHeightProperty().bind(stage.heightProperty());
        myButton.setMinSize(24, 22);
        myButton.setMaxSize(24, 22);
        okButton.setMinSize(112, 22);
        okButton.setMaxSize(112, 22);
        errorCheck.setMinSize(152, 22);
        errorCheck.setMaxSize(152, 22);
        insertingData.setMinSize(181, 17);
        insertingData.setMaxSize(181, 17);

        for(Labeled label : labels){
            label.setMaxSize(300, 30);
            label.setMinSize(300, 30);
            label.setFont(new Font("Bodoni MT", 15));
        }

        textoArchivoCargado.setFont(new Font("Bodoni MT", 11));
        textoArchivoCargado.setMinSize(150, 30);
        textoArchivoCargado.setMaxSize(150, 30);

        for(ComboBox combo : comboBoxes){
            combo.setMinSize(181, 22);
            combo.setMaxSize(181, 22);
        }

        // Agregar las opciones de tablas.
        List<String> tables = new ArrayList<>();
        tables.addAll(model.getTables());
        // Ordenamos por comodidad al buscar en el combobox.
        tables.sort(new Comparator<String>() {
            @Override
            public int compare(String o1, String o2) {
                return o1.compareTo(o2);
            }
        });
        ObservableList<String> myTables = FXCollections.observableArrayList();

        for(String tableName : tables){
            myTables.add(tableName);
        }
        comboBoxTablas.setItems(myTables);
        comboBoxTablas.getSelectionModel().selectFirst();

        new AutoCompleteComboBoxListener<>(comboBoxTablas);

        listView.setMinSize(688,215);
        listView.setMaxSize(688,215);
        listView.setDisable(true);

        myView.setMinSize(688,188);
        myView.setMaxSize(688,188);
        tableList.setMinSize(265,171);
        tableList.setMaxSize(265,171);

        // Datos a ingresar a la tabla de errores.
        data = FXCollections.observableArrayList();
        listaTablasCargadas = FXCollections.observableArrayList();

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

        TableColumn tablasCargadas = new TableColumn("Tablas cargadas");
        tablasCargadas.setCellValueFactory(new PropertyValueFactory<Tabla, String>("name"));
        tablasCargadas.setStyle("-fx-alignment: CENTER;");

        myView.setItems(data);
        tableList.setItems(listaTablasCargadas);
        tableList.getColumns().add(tablasCargadas);
        myView.getColumns().addAll(rowiId, tableName, constraintName, type);

        // Para que automaticamente use el ancho de la tabla
        myView.setColumnResizePolicy(TableView.CONSTRAINED_RESIZE_POLICY);
        tableList.setColumnResizePolicy(TableView.CONSTRAINED_RESIZE_POLICY);

        /*
         * Aqui agregamos un listener a todos los objetos para que se redimensionen al crecer la ventana.
         * Este es para el alto de los objetos.
         */
        site.heightProperty().addListener(new ChangeListener<Number>() {

            @Override
            public void changed(ObservableValue<? extends Number> arg0,
                Number oldValue, Number newValue) {

                for(int i = 0; i < labels.size(); i++){
                    fixLabeledWithResize(labels.get(i), oldValue, newValue, false);
                }

                for(int i = 0; i < comboBoxes.size(); i++){
                    fixControlWithResize(comboBoxes.get(i), oldValue, newValue, false);
                }

                fixLabeledWithResize(myButton, oldValue, newValue, false);
                fixLabeledWithResize(okButton, oldValue, newValue, false);
                fixLabeledWithResize(errorCheck, oldValue, newValue, false);
                fixControlWithResize(myView, oldValue, newValue, false);
                fixControlWithResize(insertingData, oldValue, newValue, false);
                fixControlWithResize(listView, oldValue, newValue, false);
                fixControlWithResize(tableList, oldValue, newValue, false);
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

                for(int i = 0; i < labels.size(); i++){
                    fixLabeledWithResize(labels.get(i), oldValue, newValue, true);
                }

                for(int i = 0; i < comboBoxes.size(); i++){
                    fixControlWithResize(comboBoxes.get(i), oldValue, newValue, true);
                }

                fixLabeledWithResize(myButton, oldValue, newValue, true);
                fixLabeledWithResize(okButton, oldValue, newValue, true);
                fixLabeledWithResize(errorCheck, oldValue, newValue, true);
                fixControlWithResize(myView, oldValue, newValue, true);
                fixControlWithResize(insertingData, oldValue, newValue, true);
                fixControlWithResize(listView, oldValue, newValue, true);
                fixControlWithResize(tableList, oldValue, newValue, true);
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

        if (!fileChooserPath.equals("null")){
            File myFile = new File(fileChooserPath);
            filesToAdd.add(myFile);
            fileChooser.setInitialDirectory(myFile);
        }

        File file = fileChooser.showOpenDialog(stage);

        if (file != null) {
            textoArchivoCargado.setText(file.getName());
            loadedFile = file;
            fileChooserPath = file.getParentFile().getPath();
        }
    }

    /**
     * Carga archivo a la base de datos.
     */
    @FXML void okPressed() {
        String nombreTabla = comboBoxTablas.getValue();
        if (nombreTabla == null | tablasCargadas.contains(nombreTabla))
            return;

        okButton.setDisable(true);
        okButton.setText("Subiendo archivo...");
        Thread one = new Thread() {
            public void run() {
                System.out.println(nombreTabla);
                try {
                    model.loadData(loadedFile, nombreTabla);
                    tablasCargadas.add(nombreTabla);
                } catch (IOException e) {
                    System.out.println("algo salió mal en la lectura del archivo.");
                } finally {
                    listaTablasCargadas.removeAll(listaTablasCargadas);
                    listaTablasCargadas.addAll(getTablasCargadas());
                    Timeline timeline = new Timeline(new KeyFrame(Duration.seconds(1), ev -> {
                        okButton.setDisable(false);
                        okButton.setText("Subir archivo.");
                    }));
                    timeline.play();

                    System.out.println("insertados datos.");
                }
            }
        };
        one.start();

    }

    /**
     * Carga archivo a la base de datos.
     */
    @FXML void checkErrorPressed() {
        Thread two = new Thread() {
            public void run() {
                reinitializeData();
            }
        };
        two.start();
        indicatorText.setText("Revisando constraints ...");
    }

    /**
     * Reinicializa la tabla de errores para que no existan datos duplicados.
     */
    private  void reinitializeData() {
        // Datos a ingresar a la tabla de errores.
        data.removeAll(data);
        data.addAll(model.getErrors());
        if (data.size() == 0) {
            export.setVisible(true);
        }
        else
            errores.setVisible(true);

    }

    /**
     * Este metodo es llamado por el boton export (esto se define en el archivo main.fxml con SceneBuilder) y
     * se encarga de crear el archivo zip con los CSV entregados.
     */
    private void exportData() {
        try {
            ZipCreator zip = new ZipCreator(filesToAdd);
        } catch (ZipException e) {
            e.printStackTrace();
        }

    }

    /**
     * Retorna lista con las tablas cargadas.
     * @return lista con las tablas cargadas.
     */
    public List<Tabla> getTablasCargadas() {
        List<Tabla> tablas  = new ArrayList<>();

        for(String s : tablasCargadas){
            tablas.add(new Tabla(s));
        }
        return tablas;
    }
}
