package Model.CheckScripts;

/**
 * Created by juakotorres on 27-01-2017.
 * Clase que representa a las empresas, solo tiene su nombre e identificador.
 */
public class Empresa {
    private int id;
    private String name;

    public Empresa(int id, String name){
        this.id = id;
        this.name = name;
    }

    public int getId(){
        return id;
    }

    public String getName(){
        return name;
    }
}
