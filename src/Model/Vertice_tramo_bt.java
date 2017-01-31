package Model;

/**
 * Representa una fila de la tabla de errores.
 * @autor Belisario Panay
 */
public class Vertice_tramo_bt {
    private int empresa_id;
    private String periodo_star;
    private double TRAMO_BT_ID;

    /**
     * Se guardan los datos en el objeto.
     * @param empresa_id
     * @param periodo_star
     * @param TRAMO_BT_ID
     */
    public Vertice_tramo_bt(int empresa_id,String periodo_star,double TRAMO_BT_ID) {
        this.empresa_id = empresa_id;
        this.periodo_star = periodo_star;
        this.TRAMO_BT_ID = TRAMO_BT_ID;
    }

    public int getRowId() {
        return empresa_id;
    }

    public String getTableName() {
        return periodo_star;
    }

    public double getConstraintName() {
        return TRAMO_BT_ID;
    }

}
