package util;

import java.util.HashSet;
import java.util.Random;
import java.util.Set;

public class dataGenerator {

    private static final String[] PREFIJOS = {"Ana", "Luis", "Juan", "Sofi", "Carlos", "Marta", "Pedro", "Lucia"};
    private static final String[] SUFIJOS = {"Garcia", "Lopez", "Martinez", "Perez", "Sanchez", "Torres", "Diaz", "Ruiz"};
    private static final Set<String> nombresGenerados = new HashSet<>();
    private static final Random random = new Random();

    public static String generarNombreUsuario() {
        String nombre;
        do {
            String prefijo = PREFIJOS[random.nextInt(PREFIJOS.length)];
            String sufijo = SUFIJOS[random.nextInt(SUFIJOS.length)];
            int numero = random.nextInt(1000);
            nombre = prefijo + sufijo + numero;
        } while (!nombresGenerados.add(nombre));
        return nombre;
    }


}
