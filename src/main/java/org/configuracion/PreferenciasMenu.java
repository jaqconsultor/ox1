package org.configuracion; // En el paquete 'util'
 
import java.io.*;
import java.util.*;

import org.apache.commons.logging.*;
import org.openxava.util.*;
 
public class PreferenciasMenu {
 
//    private final static String ARCHIVO_PROPIEDADES="menu.properties";
    private Log log = LogFactory.getLog(PreferenciasMenu.class);
 
    private Properties propiedades; // Almacenamos las propiedades aquí
 
    public Properties getPropiedades( String nombreArchivo ) {
    	String[] propiedad = null;
    	if (nombreArchivo == null ) {
    		nombreArchivo = "menu";
    	}
    	nombreArchivo = nombreArchivo + ".properties";
        if (propiedades == null) { // Usamos inicialización vaga
            PropertiesReader reader = // PropertiesReader es una clase de OpenXava
                new PropertiesReader(
                    PreferenciasMenu.class, nombreArchivo);
            try {
                propiedades = reader.get();
            }
            catch (IOException ex) {
                log.error(
                    XavaResources.getString( // Para leer un mensaje i18n
                        "properties_file_error",
                        nombreArchivo),
                    ex);
                  propiedades = new Properties();
             }
        }
        return propiedades;
    }
    
}