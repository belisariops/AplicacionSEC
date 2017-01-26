package Model;

/**
 * Clase para la encriptación de texto plano.
 * @author Joaquín Torres
 */
public class DataCryptor {

    public int[] key;
    public int n;
    private String alphabet;

    /**
     * @param criptingKey Clave de encriptación.
     */
    public DataCryptor(String criptingKey) {

        /* Todos los simbolos ASCII. */
        StringBuilder ascii = new StringBuilder();
        for (int c=1; c<255; c++) {
            ascii.append((char)c);
        }
        alphabet = ascii.toString();

        n = criptingKey.length();
        /* Dado largo de string se definen las llaves que existirán en esta encriptación. */
        key = new int[n];
        for (int i = 0; i < n; i++) {
            key[i] = alphabet.indexOf(criptingKey.charAt(i));
        }
    }

    /**
     * Encripta los datos usando la llave de encriptación. Usa un hash
     * @param msg Mensaje a encriptar.
     * @return Retorna código encriptado.
     */
    public String encrypt(String msg) {
        StringBuilder builder = new StringBuilder();
        /* Se encriptan los datos buscando su codigo en la tabla de llaves.
         * Simplemente se traslada el número en su número de llave veces.
         */
        for (int i = 0; i < msg.length(); i++) {
            builder.append(alphabet.charAt((alphabet.indexOf(msg.charAt(i))+key[i%n])%alphabet.length()));
        }
        return builder.toString();
    }

    /**
     * Desencripta el mensaje que se entrega.
     * @param msg Mensaje encriptado.
     * @return Retorna el mensaje desencriptado.
     */
    public String decrypt(String msg) {
        StringBuilder builder = new StringBuilder();

        /*
         * Se resta su número de llave para buscar su simbolo antes de que fuera encriptado.
         */
        for (int i = 0; i < msg.length(); i++) {
            builder.append(alphabet.charAt((alphabet.indexOf(msg.charAt(i))-key[i%n]+alphabet.length())%alphabet.length()));
        }
        return builder.toString();
    }
}
