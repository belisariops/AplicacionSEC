package Model;

/**
 * Representa una fila de la tabla de errores.
 * @autor Belisario Panay
 */
public class Error {
  private int rowId;
  private String tableName;
  private String constraintName;
  private char type;

  /**
   * Se guardan los datos en el objeto.
   * @param rowId
   * @param tableName
   * @param constraintName
   * @param type
   */
  public Error(int rowId,String tableName,String constraintName,char type) {
    this.rowId = rowId;
    this.tableName = tableName;
    this.constraintName = constraintName;
    this.type = type;
  }

  public int getRowId() {
    return rowId;
  }

  public String getTableName() {
    return tableName;
  }

  public String getConstraintName() {
    return constraintName;
  }

  public char getType() {
    return type;
  }

}
