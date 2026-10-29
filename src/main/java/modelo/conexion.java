package modelo;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class conexion {
    
    // Parámetros basados en el volcado de la base de datos 'prae'
    private static final String URL = "jdbc:mysql://localhost:3306/prae?useSSL=false&serverTimezone=UTC";
    private static final String USER = "root";
    private static final String PASSWORD = ""; // Coloca tu contraseña de MySQL si la tienes configurada

    public static Connection conectar() {
        Connection con = null;
        try {
            // Cargar el driver JDBC de MySQL 8
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (ClassNotFoundException e) {
            System.err.println("Error: No se encontró el Driver JDBC de MySQL: " + e.getMessage());
        } catch (SQLException e) {
            System.err.println("Error de SQL al conectar a la base de datos: " + e.getMessage());
        }
        return con;
    }
}
