package Zip;

import Model.DataCryptor;
import java.io.File;
import java.util.ArrayList;
import java.util.List;
import net.lingala.zip4j.core.ZipFile;
import net.lingala.zip4j.exception.ZipException;
import net.lingala.zip4j.model.ZipParameters;
import net.lingala.zip4j.util.Zip4jConstants;

/**
 * @author Belisario Panay
 */
public class ZipCreator {

    /**
     * Esta clase crea un archivo zip encriptado, que contiene todos los archivos que le
     * fueron entregados al crear un objeto de la clase.
     * @param filesToAdd
     * @throws ZipException
     */
    public ZipCreator(ArrayList<File> filesToAdd) throws ZipException {
        /*Archivo zip que sera creado*/
        ZipFile zipFile = new ZipFile("src/sample/test.zip");
        /*Parametros del archivo, como metodo de compresion,nivel de compresion y nivel de encriptacion*/
        ZipParameters zipParameters = new ZipParameters();
        zipParameters.setCompressionMethod(Zip4jConstants.COMP_DEFLATE);
        zipParameters.setCompressionLevel(Zip4jConstants.DEFLATE_LEVEL_NORMAL);
        zipParameters.setEncryptFiles(true);
        zipParameters.setEncryptionMethod(Zip4jConstants.ENC_METHOD_AES);
        zipParameters.setAesKeyStrength(Zip4jConstants.AES_STRENGTH_256);

        DataCryptor crypting = new DataCryptor("SEC_INTERRUPCIONES2016");
        String encrypt = crypting.encrypt("sec2016");
        System.out.println(encrypt);


        /*Se ingresa la clave*/
        zipParameters.setPassword(crypting.encrypt("sec2016"));

        /*Agregamos los archivos al zip*/
        zipFile.addFiles(filesToAdd, zipParameters);

    }

}
