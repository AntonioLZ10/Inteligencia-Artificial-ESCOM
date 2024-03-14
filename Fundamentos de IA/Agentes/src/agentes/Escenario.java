package agentes;

import java.awt.Color;
import java.awt.event.ActionEvent;
import java.awt.event.ItemEvent;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.awt.event.WindowAdapter;
import java.awt.event.WindowEvent;
import javax.swing.BorderFactory;
import javax.swing.ButtonGroup;
import javax.swing.ImageIcon;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JMenu;
import javax.swing.JMenuBar;
import javax.swing.JMenuItem;
import javax.swing.JOptionPane;
import javax.swing.JRadioButtonMenuItem;

public class Escenario extends JFrame {
    
    private JLabel[][] tablero;
    private int[][] matrix;
    private final int dim = 15;
    private boolean motherShipPlaced = false; // Variable para rastrear si se colocó la nave nodriza
    private JLabel motherShipLabel;
    private ImageIcon robot1;
    private ImageIcon robot2;
    private ImageIcon obstacleIcon;
    private ImageIcon sampleIcon;
    private ImageIcon motherIcon;
    private ImageIcon actualIcon;
    
    private Agente wallE;
    private Agente eva;
    
    private final BackGroundPanel fondo = new BackGroundPanel(new ImageIcon("imagenes/surface.jpg"));
    
    private final JMenu settings = new JMenu("Settings");
    private final JRadioButtonMenuItem obstacle = new JRadioButtonMenuItem("Obstacle");
    private final JRadioButtonMenuItem sample = new JRadioButtonMenuItem("Sample");
    private final JRadioButtonMenuItem motherShip = new JRadioButtonMenuItem("MotherShip");
    
    public Escenario() {
        this.setContentPane(fondo);
        this.setTitle("Agentes");
        this.setDefaultCloseOperation(JFrame.DO_NOTHING_ON_CLOSE);
        this.setBounds(50, 50, dim * 50 + 35, dim * 50 + 85);
        initComponents();
    }
    
    private void initComponents() {
        ButtonGroup settingsOptions = new ButtonGroup();
        settingsOptions.add(sample);
        settingsOptions.add(obstacle);
        settingsOptions.add(motherShip);
        motherShipLabel = new JLabel();
        motherShipLabel.setIcon(motherIcon);
        motherShipLabel.setBounds(10, 10, 50, 50);
        this.add(motherShipLabel);
        
        JMenuBar barraMenus = new JMenuBar();
        JMenu file = new JMenu("File");
        JMenuItem run = new JMenuItem("Run");
        JMenuItem exit = new JMenuItem("Exit");
        
        this.setJMenuBar(barraMenus);
        barraMenus.add(file);
        barraMenus.add(settings);
        file.add(run);
        file.add(exit);
        settings.add(motherShip);
        settings.add(obstacle);
        settings.add(sample);
        
        robot1 = new ImageIcon("imagenes/wall-e.png");
        robot1 = new ImageIcon(robot1.getImage().getScaledInstance(50, 50, java.awt.Image.SCALE_SMOOTH));
        
        robot2 = new ImageIcon("imagenes/eva.png");
        robot2 = new ImageIcon(robot2.getImage().getScaledInstance(50, 50, java.awt.Image.SCALE_SMOOTH));
        
        obstacleIcon = new ImageIcon("imagenes/brick.png");
        obstacleIcon = new ImageIcon(obstacleIcon.getImage().getScaledInstance(50, 50, java.awt.Image.SCALE_SMOOTH));
        
        sampleIcon = new ImageIcon("imagenes/sample.png");
        sampleIcon = new ImageIcon(sampleIcon.getImage().getScaledInstance(50, 50, java.awt.Image.SCALE_SMOOTH));
        
        motherIcon = new ImageIcon("imagenes/mothership.png");
        motherIcon = new ImageIcon(motherIcon.getImage().getScaledInstance(50, 50, java.awt.Image.SCALE_SMOOTH));
        
        this.setLayout(null);
        formaPlano();
        
        exit.addActionListener(evt -> gestionaSalir(evt));
        run.addActionListener(evt -> gestionaRun(evt));
        obstacle.addItemListener(evt -> gestionaObstacle(evt));
        sample.addItemListener(evt -> gestionaSample(evt));
        motherShip.addItemListener(evt -> gestionaMotherShip(evt));
        
        class MyWindowAdapter extends WindowAdapter {
            @Override
            public void windowClosing(WindowEvent eventObject) {
                goodBye();
            }
        }
        addWindowListener(new MyWindowAdapter());
        
        // Crear 2 agentes
        wallE = new Agente("Wall-E", robot1, matrix, tablero, motherShipLabel); 
        eva = new Agente("Eva", robot2, matrix, tablero, motherShipLabel);
 
    }
    
    private void gestionaSalir(ActionEvent eventObject) {
        goodBye();
    }
    
    private void goodBye() {
        int respuesta = JOptionPane.showConfirmDialog(rootPane, "¿Desea salir?", "Aviso", JOptionPane.YES_NO_OPTION);
        if (respuesta == JOptionPane.YES_OPTION) System.exit(0);
    }
    
    private void formaPlano() {
        tablero = new JLabel[dim][dim];
        matrix = new int[dim][dim];
        
        for (int i = 0; i < dim; i++) {
            for (int j = 0; j < dim; j++) {
                matrix[i][j] = 0;
                tablero[i][j] = new JLabel();
                tablero[i][j].setBounds(j * 50 + 10, i * 50 + 10, 50, 50);
                tablero[i][j].setBorder(BorderFactory.createDashedBorder(Color.white));
                tablero[i][j].setOpaque(false);
                this.add(tablero[i][j]);
                
                tablero[i][j].addMouseListener(new MouseAdapter() {
                    @Override
                    public void mousePressed(MouseEvent e) {
                        insertaObjeto(e);
                    }
                    
                    @Override
                    public void mouseReleased(MouseEvent e) {
                        insertaObjeto(e);
                    }
                });
            }
        }
    }
    
    private void gestionaObstacle(ItemEvent eventObject) {
        JRadioButtonMenuItem opt = (JRadioButtonMenuItem) eventObject.getSource();
        if (opt.isSelected()) {
            actualIcon = obstacleIcon;
        } else {
            actualIcon = null;
        }
    }
    
    private void gestionaSample(ItemEvent eventObject) {
        JRadioButtonMenuItem opt = (JRadioButtonMenuItem) eventObject.getSource();
        if (opt.isSelected()) {
            actualIcon = sampleIcon;
        } else {
            actualIcon = null;
        }
    }
    
    private void gestionaMotherShip(ItemEvent eventObject) {
        JRadioButtonMenuItem opt = (JRadioButtonMenuItem) eventObject.getSource();
        if (opt.isSelected()) {
            actualIcon = motherIcon;
        } else {
            actualIcon = null;
        }
    }
    
    private void gestionaRun(ActionEvent eventObject) {
        if (!wallE.isAlive()) wallE.start();
        if (!eva.isAlive()) eva.start();
        settings.setEnabled(false);
    }
    
public void insertaObjeto(MouseEvent e) {
    JLabel casilla = (JLabel) e.getSource();
    int i = casilla.getY() / 50;
    int j = casilla.getX() / 50;

    // Si el clic fue de tipo "presionado"
        if (i == motherShipLabel.getY() / 50 && j == motherShipLabel.getX() / 50) {
        return;
    }
            if (i == motherShipLabel.getY() / 50 && j == motherShipLabel.getX() / 50) {
        return;
    }
    if (e.getID() == MouseEvent.MOUSE_PRESSED) {
        // Verificar si hay un icono presente en la casilla
        if (casilla.getIcon() != null) {
            // Si hay un icono presente y es un obstáculo, marcarlo para eliminarlo
            if (casilla.getIcon() == obstacleIcon) {
                casilla.setIcon(null);
                matrix[i][j] = 0;
                return;
            }
        }
        // Si no hay icono presente o si el icono no es un obstáculo, establecer el icono actual
        if (actualIcon != null) {
            if (actualIcon == motherIcon && motherShipPlaced) {
                JOptionPane.showMessageDialog(rootPane, "Solo se permite una nave nodriza por ejecución", "Aviso", JOptionPane.WARNING_MESSAGE);
                return;
            } else if (actualIcon == motherIcon && !motherShipPlaced) {
                motherShipPlaced = true;
            }
            casilla.setIcon(actualIcon);
            matrix[i][j] = (actualIcon == obstacleIcon) ? 1 : (actualIcon == sampleIcon) ? 2 : 0;
        }
    }
}
}
