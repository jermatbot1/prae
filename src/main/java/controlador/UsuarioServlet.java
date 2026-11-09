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

// servlet para todo lo de usuarios (listar, crear, registrar, editar y eliminar)
@WebServlet(name = "UsuarioServlet", urlPatterns = {"/UsuarioServlet"})
public class UsuarioServlet extends HttpServlet {

    // el get solo se usa para mostrar la lista de usuarios
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String accion = request.getParameter("accion");
        if (accion == null) accion = "listar";

        try {
            switch (accion) {
                default:
                    listarUsuarios(request, response);
                    break;
            }
        } catch (SQLException e) {
            throw new ServletException("Error en UsuarioServlet (GET): " + e.getMessage(), e);
        }
    }

    // en el post se mira la accion que viene del formulario y se llama el metodo que toca
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
                case "editar":
                    editarUsuario(request, response);
                    break;
                case "eliminar":
                    eliminarUsuario(request, response);
                    break;
                default:
                    response.sendRedirect(request.getContextPath() + "/UsuarioServlet?accion=listar");
                    break;
            }
        } catch (SQLException e) {
            throw new ServletException("Error en UsuarioServlet (POST): " + e.getMessage(), e);
        }
    }

    // aqui se traen todos los usuarios con su rol para la tabla de gestion
    private void listarUsuarios(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        List<Map<String, Object>> lista = new ArrayList<>();
        // el left join es para traer el nombre del rol
        String sql = "SELECT u.id_usuario, u.nombres, u.apellidos, u.correo, u.id_rol, r.nombre_rol"
                + " FROM usuarios u LEFT JOIN roles r ON r.id_rol = u.id_rol";

        try (Connection con = conexion.conectar()) {
            if (con == null) {
                throw new SQLException("no se pudo establecer la conexion con la bade de datos");
            }

            try (PreparedStatement pst = con.prepareStatement(sql); ResultSet rs = pst.executeQuery()) {
                // se recorre cada fila y se guarda en un map
                while (rs.next()) {
                    Map<String, Object> u = new HashMap<>();
                    u.put("id_usuario", rs.getInt("id_usuario"));
                    u.put("nombres", rs.getString("nombres"));
                    u.put("apellidos", rs.getString("apellidos"));
                    u.put("nombre", rs.getString("nombres") + " " + rs.getString("apellidos"));
                    u.put("correo", rs.getString("correo"));
                    u.put("id_rol", rs.getInt("id_rol"));
                    u.put("rol", rs.getString("nombre_rol"));
                    u.put("rol", rs.getString("nombre_rol"));
                    lista.add(u);      //  para crear la liskta
                }
            }
            // se manda la lista al jsp
            request.setAttribute("listaUsuarios", lista);
            request.getRequestDispatcher("/gestion-usuario.jsp").forward(request, response);
        }
    }

    // aqui va la creacion de usuario desde el panel del admin
    private void crearUsuario(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {

        // datos que llegan del formulario
        String tipoDocumento   = request.getParameter("tipo_documento");
        String numeroDocumento = request.getParameter("numero_documento");
        String nombres         = request.getParameter("nombres");
        String apellidos       = request.getParameter("apellidos");
        String correo          = request.getParameter("correo");
        String contrasena      = request.getParameter("contrasena");
        String telefono        = request.getParameter("telefono");
        int idRol              = Integer.parseInt(request.getParameter("id_rol"));

        // el estado queda ACTIVO y la fecha se pone sola con NOW()
        String sql = "INSERT INTO usuarios (tipo_documento, numero_documento, nombres, apellidos, "
                + "correo, contrasenia, telefono, id_rol, estado, fecha_registro) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, 'ACTIVO', NOW())";

        try (Connection con = conexion.conectar()) {
            if (con == null) {
                throw new SQLException("No se pudo establecer la conexión con la base de datos.");
            }
            // si el correo ya esta no se deja crear
            if (correoExiste(con, correo)) {
                response.sendRedirect(request.getContextPath() + "/UsuarioServlet?accion=listar&error=CorreoExiste");
                return;
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
        response.sendRedirect(request.getContextPath() + "/UsuarioServlet?accion=listar");
    }

    // aqui se elimina el usuario por el id
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
        response.sendRedirect(request.getContextPath() + "/UsuarioServlet?accion=listar");
    }

    // registro publico desde registro.jsp, el usuario queda como docente
    private void registrarUsuario(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {

        String nombres    = request.getParameter("nombres");
        String apellidos  = request.getParameter("apellidos");
        String correo     = request.getParameter("correo");
        String numeroDoc  = request.getParameter("numero_documento");
        String contrasena = request.getParameter("contrasena");
        String confirmar  = request.getParameter("confirmar");

        // se revisa que las dos contrasenas sean iguales
        if (contrasena == null || !contrasena.equals(confirmar)) {
            response.sendRedirect(request.getContextPath() + "/registro.jsp?error=ContraseniasNoCoinciden");
            return;
        }

        // el rol se busca por nombre para no dejar el id fijo
        String sql = "INSERT INTO usuarios (tipo_documento, numero_documento, nombres, apellidos, "
                + "correo, contrasenia, id_rol, estado, fecha_registro) "
                + "VALUES ('CC', ?, ?, ?, ?, ?, "
                + "(SELECT id_rol FROM roles WHERE nombre_rol = 'Docente' LIMIT 1), "
                + "'ACTIVO', NOW())";

        try (Connection con = conexion.conectar()) {
            if (con == null) {
                throw new SQLException("No se pudo establecer la conexión con la base de datos.");
            }
            if (correoExiste(con, correo)) { // para comprobar que el correo no tiene la duplicidad en la base de datos
                response.sendRedirect(request.getContextPath() + "/registro.jsp?error=CorreoExiste");
                return;
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
        // despues de registrarse lo manda al login
        response.sendRedirect(request.getContextPath() + "/login.jsp?registro=ok");
    }

    // aqui se actualizan los datos del usuario desde el modal de editar
    private void editarUsuario(HttpServletRequest request, HttpServletResponse response)
            throws IOException, SQLException {
        int id = Integer.parseInt(request.getParameter("id_usuario"));
        String sql = "UPDATE usuarios SET nombres = ?, apellidos = ?, correo = ?, id_rol = ? WHERE id_usuario = ?";
        try (Connection con = conexion.conectar()) {
            if (con == null) throw new SQLException("No se pudo conectar.");
            try (PreparedStatement pst = con.prepareStatement(sql)) {
                pst.setString(1, request.getParameter("nombres"));
                pst.setString(2, request.getParameter("apellidos"));
                pst.setString(3, request.getParameter("correo"));
                pst.setInt(4, Integer.parseInt(request.getParameter("id_rol")));
                pst.setInt(5, id);
                pst.executeUpdate();
            }
        }
        response.sendRedirect(request.getContextPath() + "/UsuarioServlet?accion=listar");
    }

    // revisa si el correo ya existe en la tabla usuarios
    private boolean correoExiste(Connection con, String correo) throws SQLException {
        String sql = "SELECT COUNT(*) FROM usuarios WHERE correo = ?";
        try (PreparedStatement pst = con.prepareStatement(sql)) {
            pst.setString(1, correo);
            try (ResultSet rs = pst.executeQuery()) {
                rs.next();
                return rs.getInt(1) > 0;
            }
        }
    }
}
