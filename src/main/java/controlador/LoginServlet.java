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

        // se busca el usuario que tenga ese correo y esa contrasena
        String sql = "SELECT id_usuario, nombres, apellidos, id_rol FROM usuarios WHERE correo = ? AND contrasenia = ?";

        // Corrección de sintaxis en el try-with-resources y validación de nulidad
        try (Connection con = conexion.conectar()) {
            
            if (con == null) {
                throw new SQLException("No se pudo establecer la conexión con la base de datos. Verifique el servidor MySQL.");
            }
            
            try (PreparedStatement pst = con.prepareStatement(sql)) {
                pst.setString(1, correo);
                pst.setString(2, contrasenia);
                
                try (ResultSet rs = pst.executeQuery()) { //correccion 1
                    // si encontro el usuario se guardan sus datos en la sesion
                    if (rs.next()) {
                        HttpSession session = request.getSession();
                        request.changeSessionId();   // seguridad: id de sesión nuevo al iniciar sesión
                        session.setAttribute("id_usuario", rs.getInt("id_usuario"));
                        session.setAttribute("nombres", rs.getString("nombres"));
                        session.setAttribute("id_rol", rs.getInt("id_rol"));

                        // Pasar por el servlet para que cargue los eventos
                        response.sendRedirect(request.getContextPath() + "/ActividadesServlet?accion=listar");
                    } else {
                        // Ojo con la "/" antes de login.jsp
                        response.sendRedirect(request.getContextPath() + "/login.jsp?error=CredencialesInvalidas");
                    }
                }
            }
        } catch (SQLException e) {
            throw new ServletException("Error de base de datos en LoginServlet: " + e.getMessage(), e);
        }
    }
}