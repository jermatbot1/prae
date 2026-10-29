package controlador;


import modelo.conexion;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "ActividadesServlet", urlPatterns = {"/ActividadesServlet"})

public class ActividadesServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");
        String accion = request.getParameter("accion");
        if (accion == null) {
            accion = "listar";
        }

        try {
            switch (accion) {
                case "listar":
                    listarActividades(request, response);
                    break;
                case "eliminar":
                    eliminarActividad(request, response);
                    break;
                default:
                    listarActividades(request, response);
                    break;
            }
        } catch (SQLException e) {
            throw new ServletException("Error al procesar la petición GET en ActividadesServlet: " + e.getMessage(), e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");
        String accion = request.getParameter("accion");
        if (accion == null) {
            accion = "crear";
        }

        try {
            switch (accion) {
                case "crear":
                    crearActividad(request, response);
                    break;
                case "editar":
                    editarActividad(request, response);
                    break;
                default:
                    response.sendRedirect("ActividadesServlet?accion=listar");
                    break;
            }
        } catch (SQLException | IllegalArgumentException e) {
            throw new ServletException("Error al procesar la petición POST en ActividadesServlet: " + e.getMessage(), e);
        }
    }

    private void listarActividades(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, SQLException {
        
        String sql = "SELECT id_actividad, nombre_actividad, descripcion, fecha_programada, estado, id_proyecto FROM actividades";
        List<Map<String, Object>> listaActividades = new ArrayList<>();

        try (Connection con = conexion.conectar()) {
            if (con == null) {
                throw new SQLException("No se pudo establecer la conexión con la base de datos.");
            }
            try (PreparedStatement pst = con.prepareStatement(sql);
                 ResultSet rs = pst.executeQuery()) {
                
                while (rs.next()) {
                    Map<String, Object> act = new HashMap<>();
                    act.put("id_actividad", rs.getInt("id_actividad"));
                    act.put("nombre_actividad", rs.getString("nombre_actividad"));
                    act.put("descripcion", rs.getString("descripcion"));
                    act.put("fecha_programada", rs.getDate("fecha_programada"));
                    act.put("estado", rs.getString("estado"));
                    act.put("id_proyecto", rs.getInt("id_proyecto"));
                    listaActividades.add(act);
                }
            }
        }
        request.setAttribute("listaActividades", listaActividades);
        request.getRequestDispatcher("/dashboard.jsp").forward(request, response);
    }
    
    private int obtenerIdProyecto(Connection con) throws SQLException {
    String sql = "SELECT MIN(id_proyecto) FROM proyectos";
    try (PreparedStatement pst = con.prepareStatement(sql);
         ResultSet rs = pst.executeQuery()) {
        if (rs.next() && rs.getInt(1) > 0) {
            return rs.getInt(1);
        }
    }
    throw new SQLException("No hay proyectos registrados. Crea uno en la tabla proyectos.");
}

    private void crearActividad(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, SQLException {
        
        String titulo = request.getParameter("titulo");
        String descripcion = request.getParameter("descripcion");
        String fechaStr = request.getParameter("fechaInicio");
        if (fechaStr == null || fechaStr.isEmpty()) {
            fechaStr = request.getParameter("fecha");
        }
        String estado = request.getParameter("estado");
        if (estado == null || estado.trim().isEmpty()) {
            estado = "Pendiente";
        }

        String sql = "INSERT INTO actividades (nombre_actividad, descripcion, fecha_programada, estado, id_proyecto) VALUES (?, ?, ?, ?, ?)";

        try (Connection con = conexion.conectar()) {
            if (con == null)  {
                throw new SQLException("No se pudo establecer la conexión con la base de datos.");
            }
            int idProyecto = obtenerIdProyecto(con);
            
            try (PreparedStatement pst = con.prepareStatement(sql)) {
                pst.setString(1, titulo);
                pst.setString(2, descripcion);
                pst.setDate(3, Date.valueOf(fechaStr));
                pst.setString(4, estado);
                pst.setInt(5, idProyecto);
                pst.executeUpdate();
            }
        }
        response.sendRedirect(request.getContextPath() + "/ActividadesServlet?accion=listar");
    }

    private void editarActividad(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, SQLException {
        
        String idStr = request.getParameter("id_actividad");
        String titulo = request.getParameter("titulo");
        String descripcion = request.getParameter("descripcion");
        String fechaStr = request.getParameter("fecha");
        String estado = request.getParameter("estado");
        
        if (idStr == null || idStr.trim().isEmpty()) {
            throw new IllegalArgumentException("Falta el id del evento a editar.");
            }
        
        int idActividad = Integer.parseInt(idStr);
        if (estado == null || estado.trim().isEmpty()) {
            estado = "Pendiente";
        }
        

        String sql = "UPDATE actividades SET nombre_actividad = ?, descripcion = ?, fecha_programada = ?, estado = ?, id_proyecto = ? WHERE id_actividad = ?";

        try (Connection con = conexion.conectar()) {
            if (con == null) {
                throw new SQLException("No se pudo establecer la conexión con la base de datos.");
            }
            
            int idProyecto = obtenerIdProyecto(con);
            
            try (PreparedStatement pst = con.prepareStatement(sql)) {
                pst.setString(1, titulo);
                pst.setString(2, descripcion);
                pst.setDate(3, Date.valueOf(fechaStr));
                pst.setString(4, estado);
                pst.setInt(5, idProyecto);
                pst.setInt(6, idActividad);
                pst.executeUpdate();
            }
        }
        response.sendRedirect(request.getContextPath() + "/ActividadesServlet?accion=listar");
    }

    private void eliminarActividad(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, SQLException {
        
        String idStr = request.getParameter("id");
        int idActividad = Integer.parseInt(idStr);

        String sql = "DELETE FROM actividades WHERE id_actividad = ?";

        try (Connection con = conexion.conectar()) {
            if (con == null) {
                throw new SQLException("No se pudo establecer la conexión con la base de datos.");
            }
            try (PreparedStatement pst = con.prepareStatement(sql)) {
                pst.setInt(1, idActividad);
                pst.executeUpdate();
            }
        }
        response.sendRedirect(request.getContextPath() + "/ActividadesServlet?accion=listar");;
    }
}
