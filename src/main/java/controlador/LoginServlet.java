package controlador;

import modelo.conexion;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author Jermat
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");
        
        // Capturar los parámetros enviados desde el formulario de index.jsp / index.html
        String correo = request.getParameter("email");
        String contrasenia = request.getParameter("password");

        String sql = "SELECT id_usuario, nombres, apellidos, id_rol FROM usuarios WHERE correo = ? AND contrasenia = ?";

        // Corrección de sintaxis en el try-with-resources y validación de nulidad
        try (Connection con = conexion.conectar()) {
            
            if (con == null) {
                throw new SQLException("No se pudo establecer la conexión con la base de datos. Verifique el servidor MySQL.");
            }
            
            try (PreparedStatement pst = con.prepareStatement(sql)) {
                pst.setString(1, correo);
                pst.setString(2, contrasenia);
                
                try (ResultSet rs = pst.executeQuery()) {
                    if (rs.next()) {
                        // Autenticación exitosa: Creamos la sesión del usuario
                        HttpSession session = request.getSession();
                        session.setAttribute("id_usuario", rs.getInt("id_usuario"));
                        session.setAttribute("nombres", rs.getString("nombres"));
                        session.setAttribute("id_rol", rs.getInt("id_rol"));
                        
                        // Redirigir al Dashboard institucional según el análisis de pantallas
                        response.sendRedirect("dashboard.jsp");
                    } else {
                        // Credenciales incorrectas: Redirigir de vuelta al index con error
                        response.sendRedirect("index.jsp?error=CredencialesInvalidas");
                    }
                }
            }
        } catch (SQLException e) {
            throw new ServletException("Error de base de datos en LoginServlet: " + e.getMessage(), e);
        }
    }
}