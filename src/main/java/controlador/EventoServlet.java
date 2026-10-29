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
import java.sql.Date;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/EventoServlet")
public class EventoServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");
        
        // 1. Capturar los parámetros enviados desde el modal "Crear evento" en dashboard.jsp 
        String titulo = request.getParameter("titulo");
        String descripcion = request.getParameter("descripcion");
        String fechaStr = request.getParameter("fecha"); // Formato YYYY-MM-DD
        String estado = request.getParameter("estado");
        String idProyectoStr = request.getParameter("idProyecto");

        // Valores por defecto si algún campo opcional llega vacío
        if (estado == null || estado.trim().isEmpty()) {
            estado = "Pendiente";
        }
        
        int idProyecto = 3; // Valor por defecto basado en los proyectos existentes en db_prae.sql (id_proyecto 3 o 4)listo para cmabiar
        
        if (idProyectoStr != null && !idProyectoStr.trim().isEmpty()) {
            try {
                idProyecto = Integer.parseInt(idProyectoStr);
            } catch (NumberFormatException e) {
                // Mantiene el valor por defecto en caso de error de formato
            }
        }

        // 2. Sentencia SQL mapeada estrictamente a la tabla 'actividades' (db_prae.sql)[cite: 12]
        String sql = "INSERT INTO actividades (nombre_actividad, descripcion, fecha_programada, estado, id_proyecto) " +
                     "VALUES (?, ?, ?, ?, ?)";

        // 3. Ejecución segura mediante JDBC con try-with-resources
        try (Connection con = conexion.conectar()) {
            if (con == null) {
                throw new SQLException("No se pudo establecer la conexión con la base de datos.");
            }

            try (PreparedStatement pst = con.prepareStatement(sql)) {
                pst.setString(1, titulo);
                pst.setString(2, descripcion);
                pst.setDate(3, Date.valueOf(fechaStr)); // Conversión segura a java.sql.Date
                pst.setString(4, estado);
                pst.setInt(5, idProyecto);

                int filasAfectadas = pst.executeUpdate();

                if (filasAfectadas > 0) {
                    // Creación exitosa Redirigir al dashboard institucional
                    response.sendRedirect("dashboard.jsp?exito=eventoCreado");
                } else {
                    response.sendRedirect("dashboard.jsp?error=NoSePudoCrearEvento");
                }
            }
        } catch (IllegalArgumentException e) {
            response.sendRedirect("dashboard.jsp?error=FormatoFechaInvalido");
        } catch (SQLException e) {
            throw new ServletException("Error de base de datos en EventoServlet: " + e.getMessage(), e);
        }
    }
}
