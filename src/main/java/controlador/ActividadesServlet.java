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



// servlet de las actividades o eventos ambientales del prae
@WebServlet(name = "ActividadesServlet", urlPatterns = {"/ActividadesServlet"})


public class ActividadesServlet extends HttpServlet {

    // el get es para listar las actividades en el dashboard y para ver una sola
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
                case "ver":
                    verActividad(request, response);
                    break;
                default:
                    listarActividades(request, response);
                    break;
            }
        } catch (SQLException e) {
            throw new ServletException("Error al procesar la petición GET en ActividadesServlet: " + e.getMessage(), e);
        }
    }

    // en el post llegan crear, editar y eliminar segun la accion
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
                case "eliminar":
                    eliminarActividad(request, response);
                    break;
                default:
                    response.sendRedirect(request.getContextPath() + "/UsuarioServlet?accion=listar");
                    break;
            }
        } catch (SQLException | IllegalArgumentException e) {
            throw new ServletException("Error al procesar la petición POST en ActividadesServlet: " + e.getMessage(), e);
        }
    }

    // aqui se traen todas las actividades de la base de datos
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
                
                // cada actividad se guarda en un map y se mete a la lista
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
        // se manda la lista al dashboard
        request.setAttribute("listaActividades", listaActividades);
        request.getRequestDispatcher("/dashboard.jsp").forward(request, response);
    }
    
    // aqui se busca un solo evento por el id para verlo en detalle-evento.jsp
    private void verActividad(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {

        // si el id no llega o no es numero se devuelve al dashboard
        int idActividad;
        try {
            idActividad = Integer.parseInt(request.getParameter("id"));
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/ActividadesServlet?accion=listar");
            return;
        }

        String sql = "SELECT id_actividad, nombre_actividad, descripcion, fecha_programada, estado, id_proyecto "
                + "FROM actividades WHERE id_actividad = ?";
        Map<String, Object> act = null;

        try (Connection con = conexion.conectar()) {
            if (con == null) {
                throw new SQLException("No se pudo establecer la conexión con la base de datos.");
            }
            try (PreparedStatement pst = con.prepareStatement(sql)) {
                pst.setInt(1, idActividad);
                try (ResultSet rs = pst.executeQuery()) {
                    // si lo encuentra se guardan los datos en el map
                    if (rs.next()) {
                        act = new HashMap<>();
                        act.put("id_actividad", rs.getInt("id_actividad"));
                        act.put("nombre_actividad", rs.getString("nombre_actividad"));
                        act.put("descripcion", rs.getString("descripcion"));
                        act.put("fecha_programada", rs.getDate("fecha_programada"));
                        act.put("estado", rs.getString("estado"));
                        act.put("id_proyecto", rs.getInt("id_proyecto"));
                    }
                }
            }
        }

        // si no existe ese evento tambien se devuelve al dashboard
        if (act == null) {
            response.sendRedirect(request.getContextPath() + "/ActividadesServlet?accion=listar");
            return;
        }

        // se manda el evento al jsp del detalle
        request.setAttribute("actividad", act);
        request.getRequestDispatcher("/detalle-evento.jsp").forward(request, response);
    }

    // saca el primer proyecto que haya para asociarle la actividad
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

    // aqui va la creacion de evento
    private void crearActividad(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, SQLException {
        
        String titulo = request.getParameter("titulo");
        String descripcion = request.getParameter("descripcion");
        String fechaStr = request.getParameter("fechaInicio");
        Date fecha = parsearFecha(fechaStr);
        // si la fecha viene mal se devuelve con error
        if (fecha == null) {
            response.sendRedirect(request.getContextPath() + "/ActividadesServlet?accion=listar&error=FechaInvalida");
            return;
        }
        String estado = request.getParameter("estado");
        // si no mandan estado queda en pendiente
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
                pst.setDate(3, fecha);
                pst.setString(4, estado);
                pst.setInt(5, idProyecto);
                pst.executeUpdate();
            }
        }
        response.sendRedirect(request.getContextPath() + "/ActividadesServlet?accion=listar");
    }

    // aqui se edita el evento
    private void editarActividad(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, SQLException {
        
        String idStr = request.getParameter("id_actividad");
        String titulo = request.getParameter("titulo");
        String descripcion = request.getParameter("descripcion");
        String fechaStr = request.getParameter("fecha");
        String estado = request.getParameter("estado");
        
        // sin id no se puede editar nada
        if (idStr == null || idStr.trim().isEmpty()) {
            throw new IllegalArgumentException("Falta el id del evento a editar.");
            }
        
        int idActividad = Integer.parseInt(idStr);
        if (estado == null || estado.trim().isEmpty()) {
            estado = "Pendiente";
        }
        

        String sql = "UPDATE actividades SET nombre_actividad = ?, descripcion = ?, fecha_programada = ?, estado = ? WHERE id_actividad = ?";

        try (Connection con = conexion.conectar()) {
            if (con == null) {
                throw new SQLException("No se pudo establecer la conexión con la base de datos.");
            }
            
            
            
            try (PreparedStatement pst = con.prepareStatement(sql)) {
                pst.setString(1, titulo);
                pst.setString(2, descripcion);
                pst.setDate(3, Date.valueOf(fechaStr));
                pst.setString(4, estado);
                pst.setInt(5, idActividad);
                pst.executeUpdate();
            }
        }
        response.sendRedirect(request.getContextPath() + "/ActividadesServlet?accion=listar");
    }

    // aqui se borra el evento por el id
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

    // convierte el texto de la fecha a Date, si esta mal devuelve null
    private Date parsearFecha(String s) {
        if (s == null || s.isBlank()) {
            return null;
        }
        try {
            return Date.valueOf(s);
        } catch (IllegalArgumentException e) {
            return null;
        }
    }
}
