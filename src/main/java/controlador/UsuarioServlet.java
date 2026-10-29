/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controlador;

/**
 *
 * @author Jermat
 */
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import modelo.conexion;

@WebServlet(name = "UsuarioServlet", urlPatterns = {"/UsuarioServlet"})
public class UsuarioServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String accion = request.getParameter("accion");
        if (accion == null) accion = "listar";

        try {
            switch (accion) {
                case "eliminar":
                    eliminarUsuario(request, response);
                    break;
                default:
                    listarUsuarios(request, response);
                    break;
            }
        } catch (SQLException e) {
            throw new ServletException("Error en UsuarioServlet (GET): " + e.getMessage(), e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String accion = request.getParameter("accion");
        if (accion == null) accion = "crear";

        try {
            switch (accion) {
                case "crear":
                    crearUsuario(request, response);
                    break;
                case "registrar":
                    registrarUsuario(request, response);                    
                    break;    
                default:
                    response.sendRedirect("UsuarioServlet?accion=listar");
                    break;
            }
        } catch (SQLException e) {
            throw new ServletException("Error en UsuarioServlet (POST): " + e.getMessage(), e);
        }
    }

    private void listarUsuarios(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        List<Map<String, Object>> lista = new ArrayList<>();
        String sql = "SELECT id_usuario, nombres, apellidos, id_rol FROM usuarios";

        try (Connection con = conexion.conectar();
             PreparedStatement pst = con.prepareStatement(sql);
             ResultSet rs = pst.executeQuery()) {
            while (rs.next()) {
                Map<String, Object> u = new HashMap<>();
                u.put("id_usuario", rs.getInt("id_usuario"));
                u.put("nombre", rs.getString("nombres") + " " + rs.getString("apellidos"));
                u.put("rol", rs.getInt("id_rol"));
                lista.add(u);
            }
        }
        request.setAttribute("listaUsuarios", lista);
        request.getRequestDispatcher("/gestion-usuario.jsp").forward(request, response);
    }

    private void crearUsuario(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException, SQLException {

    String tipoDocumento   = request.getParameter("tipo_documento");
    String numeroDocumento = request.getParameter("numero_documento");
    String nombres         = request.getParameter("nombres");
    String apellidos       = request.getParameter("apellidos");
    String correo          = request.getParameter("correo");
    String contrasena      = request.getParameter("contrasena");
    String telefono        = request.getParameter("telefono");
    int idRol              = Integer.parseInt(request.getParameter("id_rol"));

    String sql = "INSERT INTO usuarios (tipo_documento, numero_documento, nombres, apellidos, "
               + "correo, contrasena, telefono, id_rol, estado, fecha_registro) "
               + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, 'ACTIVO', NOW())";

    try (Connection con = conexion.conectar()) {
        if (con == null) {
            throw new SQLException("No se pudo establecer la conexión con la base de datos.");
        }
        try (PreparedStatement pst = con.prepareStatement(sql)) {
            pst.setString(1, tipoDocumento);
            pst.setString(2, numeroDocumento);
            pst.setString(3, nombres);
            pst.setString(4, apellidos);
            pst.setString(5, correo);
            pst.setString(6, contrasena);
            pst.setString(7, telefono);
            pst.setInt(8, idRol);
            pst.executeUpdate();
        }
    }
    response.sendRedirect("UsuarioServlet?accion=listar");
}

    private void eliminarUsuario(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {

        int id = Integer.parseInt(request.getParameter("id"));
        String sql = "DELETE FROM usuarios WHERE id_usuario = ?";

        try (Connection con = conexion.conectar()) {
            if (con == null) {
                throw new SQLException("No se pudo establecer la conexión con la base de datos.");
            }
            try (PreparedStatement pst = con.prepareStatement(sql)) {
                pst.setInt(1, id);
                pst.executeUpdate();
            }
        }
        response.sendRedirect("UsuarioServlet?accion=listar");
    }
   private void registrarUsuario(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException, SQLException {

    String nombres    = request.getParameter("nombres");
    String apellidos  = request.getParameter("apellidos");
    String correo     = request.getParameter("correo");
    String numeroDoc  = request.getParameter("numero_documento");
    String contrasena = request.getParameter("contrasena");
    String confirmar  = request.getParameter("confirmar");

    if (contrasena == null || !contrasena.equals(confirmar)) {
        throw new IllegalArgumentException("Las contraseñas no coinciden.");
    }

    String sql = "INSERT INTO usuarios (tipo_documento, numero_documento, nombres, apellidos, "
               + "correo, contrasenia, id_rol, estado, fecha_registro) "
               + "VALUES ('CC', ?, ?, ?, ?, ?, "
               + "(SELECT id_rol FROM roles WHERE nombre_rol = 'Docente' LIMIT 1), "
               + "'ACTIVO', NOW())";

    try (Connection con = conexion.conectar()) {
        if (con == null) {
            throw new SQLException("No se pudo establecer la conexión con la base de datos.");
        }
        try (PreparedStatement pst = con.prepareStatement(sql)) {
            pst.setString(1, numeroDoc);
            pst.setString(2, nombres);
            pst.setString(3, apellidos);
            pst.setString(4, correo);
            pst.setString(5, contrasena);
            pst.executeUpdate();
        }
    }
    response.sendRedirect(request.getContextPath() + "/login.jsp?registro=ok");
}
}