
<%@ page contentType="usuario.jsp" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>

<%@ include file="includes/header.jsp" %>

<div class="container my-5">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="fw-bold">Gestión de Usuarios</h2>
        <button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#modalRegistroUsuario">
            + Nuevo Usuario
        </button>
    </div>

    <!-- Tabla de Usuarios -->
    <div class="table-responsive bg-white p-3 shadow-sm rounded">
        <table class="table table-striped align-middle">
            <thead class="table-dark">
                <tr>
                    <th>ID</th>
                    <th>Nombre</th>
                    <th>Correo</th>
                    <th>Rol</th>
                </tr>
            </thead>
            <tbody>
                <%
                    List<Map<String, String>> lista = (List<Map<String, String>>) request.getAttribute("listaUsuarios");
                    if (lista != null && !lista.isEmpty()) {
                        for (Map<String, String> usr : lista) {
                %>
                <tr>
                    <td><%= usr.get("id") %></td>
                    <td><%= usr.get("nombre") %></td>
                    <td><%= usr.get("correo") %></td>
                    <td><%= usr.get("rol") %></td>
                </tr>
                <%
                        }
                    } else {
                %>
                <tr>
                    <td colspan="4" class="text-center text-muted py-3">No hay usuarios registrados en el sistema.</td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    </div>
</div>

<!-- Modal de Registro de Usuario (POST a UsuarioServlet) -->
<div class="modal fade" id="modalRegistroUsuario" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title fw-bold">Registrar Usuario</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
            </div>
            <form action="UsuarioServlet" method="POST">
                <div class="modal-body">
                    <div class="mb-3">
                        <label for="nombre" class="form-label">Nombre Completo</label>
                        <input type="text" name="nombre" id="nombre" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label for="correo" class="form-label">Correo Electrónico</label>
                        <input type="email" name="correo" id="correo" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label for="password" class="form-label">Contraseña</label>
                        <input type="password" name="password" id="password" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label for="rol" class="form-label">Rol de Usuario</label>
                        <select name="rol" id="rol" class="form-select" required>
                            <option value="Docente">Docente</option>
                            <option value="Administrativo">Administrativo</option>
                            <option value="Estudiante">Estudiante</option>
                        </select>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                    <button type="submit" class="btn btn-primary">Guardar</button>
                </div>
            </form>
        </div>
    </div>
</div>

<%@ include file="includes/footer.jsp" %>