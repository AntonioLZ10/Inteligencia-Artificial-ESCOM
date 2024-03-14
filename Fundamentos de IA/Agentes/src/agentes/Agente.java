package agentes;

import java.util.Random;
import javax.swing.ImageIcon;
import javax.swing.JLabel;

public class Agente extends Thread {
    private final String nombre;
    private int i;
    private int j;
    private final ImageIcon icon;
    private final int[][] matrix;
    private final JLabel[][] tablero;
    private boolean llevaMuestra = false;
    private final JLabel motherShipLabel; // etiqueta de la nave nodriza
    private boolean movimientoAleatorio = true;
    
    private final Random aleatorio = new Random(System.currentTimeMillis());
    
    public Agente(String nombre, ImageIcon icon, int[][] matrix, JLabel[][] tablero, JLabel motherShipLabel) {
        this.nombre = nombre;
        this.icon = icon;
        this.matrix = matrix;
        this.tablero = tablero;
        this.motherShipLabel = motherShipLabel;
        
        this.i = aleatorio.nextInt(matrix.length);
        this.j = aleatorio.nextInt(matrix.length);
        tablero[i][j].setIcon(icon);        
    }
    
    @Override
    public void run() {
        while(true) {
            if (movimientoAleatorio) {
                moverAleatoriamente();
            } else {
                moverHaciaNaveNodriza();
            }
            
            try {
                sleep(100 + aleatorio.nextInt(100));
            } catch (InterruptedException ex) {
                ex.printStackTrace(System.out);
            }
        }
    }
    
private void moverAleatoriamente() {
    if (!llevaMuestra) {
        int nuevaI, nuevaJ;

        do {
            int direccion = aleatorio.nextInt(4); // 0: arriba, 1: abajo, 2: izquierda, 3: derecha

            nuevaI = i;
            nuevaJ = j;

            switch (direccion) {
                case 0:
                    nuevaI--;
                    break;
                case 1:
                    nuevaI++;
                    break;
                case 2:
                    nuevaJ--;
                    break;
                case 3:
                    nuevaJ++;
                    break;
            }
        } while (!esCeldaValida(nuevaI, nuevaJ));

        mover(nuevaI, nuevaJ);
    } else {
        // Si lleva una muestra, mover hacia la nave nodriza
        moverHaciaNaveNodriza();
    }
}

private void moverHaciaNaveNodriza() {
    // Si está adyacente a la nave nodriza, dejar la muestra y volver a movimiento aleatorio
    if (distanciaNave(i, j) == 1) {
        dejarMuestra();
        movimientoAleatorio = true;
        return;
    }
    
    // Mover hacia la nave nodriza
    int nuevaI = i;
    int nuevaJ = j;
    int distanciaMenor = Integer.MAX_VALUE;

    if (esCeldaValida(i - 1, j) && distanciaNave(i - 1, j) < distanciaMenor && !(i - 1 == motherShipLabel.getY() / 50 && j == motherShipLabel.getX() / 50)) {
        nuevaI = i - 1;
        nuevaJ = j;
        distanciaMenor = distanciaNave(i - 1, j);
    }
    if (esCeldaValida(i + 1, j) && distanciaNave(i + 1, j) < distanciaMenor && !(i + 1 == motherShipLabel.getY() / 50 && j == motherShipLabel.getX() / 50)) {
        nuevaI = i + 1;
        nuevaJ = j;
        distanciaMenor = distanciaNave(i + 1, j);
    }
    if (esCeldaValida(i, j - 1) && distanciaNave(i, j - 1) < distanciaMenor && !(i == motherShipLabel.getY() / 50 && j - 1 == motherShipLabel.getX() / 50)) {
        nuevaI = i;
        nuevaJ = j - 1;
        distanciaMenor = distanciaNave(i, j - 1);
    }
    if (esCeldaValida(i, j + 1) && distanciaNave(i, j + 1) < distanciaMenor && !(i == motherShipLabel.getY() / 50 && j + 1 == motherShipLabel.getX() / 50)) {
        nuevaI = i;
        nuevaJ = j + 1;
        distanciaMenor = distanciaNave(i, j + 1);
    }

    mover(nuevaI, nuevaJ);
}

private void dejarMuestra() {
    // Dejar la muestra en la celda actual
    matrix[i][j] = 2; // Muestra
    llevaMuestra = false; // El agente ya no lleva una muestra
}


    
    private int distanciaNave(int i, int j) {
        // Calcular la distancia Manhattan entre la celda actual y la posición de la nave nodriza
        int distanciaI = Math.abs(i - motherShipLabel.getY() / 50);
        int distanciaJ = Math.abs(j - motherShipLabel.getX() / 50);
        return distanciaI + distanciaJ;
    }
    
    private void mover(int nuevaI, int nuevaJ) {
        tablero[i][j].setIcon(null); // Eliminar el icono de la celda actual
        i = nuevaI;
        j = nuevaJ;
        tablero[i][j].setIcon(icon); // Colocar el icono en la nueva celda
        
        if (matrix[i][j] == 2) { // Si la celda contiene una muestra
            if (!llevaMuestra) { // Si el agente no lleva una muestra
                llevaMuestra = true; // Recoger la muestra
                matrix[i][j] = 0; // Quitar la muestra del mapa
                // Cambiar el movimiento a hacia la nave nodriza
                movimientoAleatorio = false;
            }
        }
    }
    
    private boolean esCeldaValida(int i, int j) {
        return i >= 0 && i < matrix.length && j >= 0 && j < matrix[0].length && matrix[i][j] != 1;
    }
}