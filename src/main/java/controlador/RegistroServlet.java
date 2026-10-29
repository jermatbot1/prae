/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controlador;

/**
 *
 * @author Jermat
 */
import modelo.conexion;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/RegistroServlet")
public class RegistroServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");
        
        // 1. Capturar parámetros enviados desde registro.jsp 
        String nombre = request.getParameter("nombre");
        String apellido = request.getParameter("apellido");
        String correo = request.getParameter("correo");
        String cedula = request.getParameter("cedula");
        String fechaNacimiento = request.getParameter("fechaNacimiento");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        // 2. Validación básica de contraseñas coincidentes
        if (password == null || !password.equals(confirmPassword)) {
            response.sendRedirect("registro.jsp?error=ContraseñasNoCoinciden");
            return;
        }

        // 3. Sentencia SQL mapeada a la estructura de la tabla 'usuarios' prae
        // Se asigna por defecto el id_rol = 9 (docente urol base) o el correspondiente de la BD
        String sql = "INSERT INTO usuarios (tipo_documento, numero_documento, nombres, apellidos, correo, contrasenia, id_rol, estado) " +
                     "VALUES ('CC', ?, ?, ?, ?, ?, 8, 'ACTIVO')";

        // 4. Ejecución segura con JDBC y try-with-resources
        try (Connection con = conexion.conectar()) {
            if (con == null) {
                throw new SQLException("No se pudo establecer la conexión con la base de datos.");
            }

            try (PreparedStatement pst = con.prepareStatement(sql)) {
                pst.setString(1, cedula);
                pst.setString(2, nombre);
                pst.setString(3, apellido);
                pst.setString(4, correo);
                pst.setString(5, password); 

                int filasAfectadas = pst.executeUpdate();

                if (filasAfectadas > 0) {
                    // Registro exitoso, redirigir al login (index.jsp)
                    response.sendRedirect("index.jsp?registro=exito");
                } else {
                    response.sendRedirect("registro.jsp?error=ErrorAlRegistrar");
                }
            }
        } catch (SQLException e) {
            throw new ServletException("Error de base de datos en RegistroServlet: " + e.getMessage(), e);
        }
    }
}