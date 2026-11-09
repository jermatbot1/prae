/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controlador;

import java.io.IOException;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;

// filtro que revisa si el usuario inicio sesion antes de entrar a las paginas
@WebFilter("/*")
public class AuthFilter implements Filter {

    public static final int ROL_ADMIN = 7; // id_rol de administrador

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;

        if (request.getCharacterEncoding() == null) {
            request.setCharacterEncoding("UTF-8"); //para las tildes y ñ
        }

        String ruta = request.getRequestURI().substring(request.getContextPath().length());

        // 1. Rutas públicas: pasan sin sesión
        boolean publica = ruta.isEmpty() || ruta.equals("/")
                || ruta.equals("/index.jsp") || ruta.equals("/login.jsp")
                || ruta.equals("/registro.jsp") || ruta.equals("/LoginServlet")
                || ruta.equals("/LogoutServlet") || ruta.startsWith("/css/")
                || (ruta.equals("/UsuarioServlet") && "registrar".equals(request.getParameter("accion")));

        if (publica) {
            chain.doFilter(req, res);
            return;
        }

        // 2. Hay sesión?
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("id_usuario") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // 3. Rutas solo para administrador
        boolean soloAdmin = ruta.equals("/UsuarioServlet")
                || ruta.equals("/gestion-usuario.jsp") || ruta.equals("/usuario.jsp");
        Object rol = session.getAttribute("id_rol");
        if (soloAdmin && !(rol instanceof Integer && (Integer) rol == ROL_ADMIN)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "No tienes permisos.");
            return;
        }

        chain.doFilter(req, res);
    }
}