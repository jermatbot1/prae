<%-- 
    Document   : gestion-usuario
    Created on : 27/10/2026, 5:08:43 p. m.
    Author     : Jermat
--%>
<%
    if (session.getAttribute("id_usuario") == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
%>
<%@page contentType="gestion-usuario.jsp" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Gestión de Usuarios - SystemaPRAE</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
        <style>
            .bg-prae {
                background-color: #0E8C2F !important;
            }
            .btn-prae {
                background-color: #0E8C2F !important;
                color: white;
                border: 2px solid #000;
            }
            .btn-prae:hover {
                background-color: #0a6b22 !important;
                color: white;
            }
        </style>
    </head>
    <body class="bg-light d-flex flex-column min-vh-100">

        <header class="navbar navbar-dark bg-prae p-3 shadow-sm">
            <div class="container-fluid">
                <span class="navbar-brand fw-bold">SystemaPRAE - Módulo Administrativo</span>
                <a href="${pageContext.request.contextPath}/dashboard.jsp" class="btn btn-outline-light btn-sm">Volver al Dashboard</a>
            </div>
        </header>

        <main class="container my-5 flex-grow-1">
            <h2 class="text-center mb-5 fw-bold">Gestión de Usuarios</h2>

            <div class="row">
                <div class="col-12 col-md-4 d-flex flex-column gap-3">
                    <button class="btn btn-light border border-dark rounded-0 fw-bold py-2 shadow-sm" 
                            data-bs-toggle="modal" 
                            data-bs-target="#modalRegistrarUsuario">
                        Registrar usuario nuevo
                    </button>
                    <button class="btn btn-light border border-dark rounded-0 fw-bold py-2 shadow-sm"
                            data-bs-toggle="modal" 
                            data-bs-target="#modalEditarUsuario">
                        Editar usuarios
                    </button>
                    <button class="btn btn-danger rounded-0 fw-bold py-2"
                            data-bs-toggle="modal" 
                            data-bs-target="#modalEliminarUsuario">               
                        Eliminar usuarios
                    </button>
                    <hr>
                    <button class="btn btn-light border border-dark rounded-0 fw-bold py-2">Seguridad y Permisos</button>
                </div>

                <div class="col-12 col-md-8">
                    <div class="bg-white p-4 border border-dark" style="min-height: 400px;">
                        <h5 class="mb-4">Lista de usuarios activos</h5>

                        <c:choose>
                            <c:when test="${not empty listaUsuarios}">
                                <c:forEach var="usr" items="${listaUsuarios}">
                                    <div class="d-flex align-items-center justify-content-between p-2 border-bottom border-dark border-opacity-25">
                                        <span>${usr.nombre}</span>
                                        <div class="d-flex gap-3"><span class="badge bg-prae rounded-0">${usr.rol}</span></div>
                                        <button class="btn btn-sm btn-outline-dark rounded-0">Ver detalles</button>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <div class="d-flex align-items-center justify-content-between p-2 border-bottom border-dark border-opacity-25">
                                    <span>Docente_01</span>
                                    <div class="d-flex gap-3"><span class="badge bg-prae rounded-0">Admin</span></div>
                                    <button class="btn btn-sm btn-outline-dark rounded-0">Ver detalles</button>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </main>

        <!-- ======================================================== -->
        <!-- MODAL: REGISTRAR USUARIO NUEVO                           -->
        <!-- ======================================================== -->
        <div class="modal fade" id="modalRegistrarUsuario" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-lg">
                <div class="modal-content rounded-0 bg-white" style="border: 2px solid #000;">

                    <div class="modal-header border-bottom border-dark py-1 rounded-0 bg-light">
                        <span class="small fw-bold text-dark">Registrar nuevo usuario</span>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>

                    <div class="modal-body p-5">
                        <h3 class="text-center mb-4">Registrar nuevo usuario</h3>
                        <p class="text-center text-muted small mb-4">DATOS BÁSICOS</p>

                        <form action="${pageContext.request.contextPath}/UsuarioServlet?accion=crear" method="POST">

                            <div class="row mb-3 align-items-center">
                                <label class="col-sm-3 text-end fw-bold">Tipo doc.</label>
                                <div class="col-sm-9">
                                    <select name="tipo_documento" class="form-control rounded-0 border-dark" required>
                                        <option value="CC">Cédula de ciudadanía</option>
                                        <option value="TI">Tarjeta de identidad</option>
                                        <option value="CE">Cédula de extranjería</option>
                                    </select>
                                </div>
                            </div>

                            <div class="row mb-3 align-items-center">
                                <label class="col-sm-3 text-end fw-bold">Número doc.</label>
                                <div class="col-sm-9">
                                    <input type="text" name="numero_documento" class="form-control rounded-0 border-dark" required>
                                </div>
                            </div>

                            <div class="row mb-3 align-items-center">
                                <label class="col-sm-3 text-end fw-bold">Nombres</label>
                                <div class="col-sm-9">
                                    <input type="text" name="nombres" class="form-control rounded-0 border-dark" required>
                                </div>
                            </div>

                            <div class="row mb-3 align-items-center">
                                <label class="col-sm-3 text-end fw-bold">Apellidos</label>
                                <div class="col-sm-9">
                                    <input type="text" name="apellidos" class="form-control rounded-0 border-dark" required>
                                </div>
                            </div>

                            <div class="row mb-3 align-items-center">
                                <label class="col-sm-3 text-end fw-bold">Rol</label>
                                <div class="col-sm-9">
                                    <select name="id_rol" class="form-control rounded-0 border-dark" required>
                                        <option value="7">Administrador</option>
                                        <option value="8">Docente</option>
                                        <option value="9">Estudiante</option>
                                    </select>
                                </div>
                            </div>

                            <div class="row mb-3 align-items-center">
                                <label class="col-sm-3 text-end fw-bold">Correo</label>
                                <div class="col-sm-9">
                                    <input type="email" name="correo" class="form-control rounded-0 border-dark" required>
                                </div>
                            </div>

                            <div class="row mb-3 align-items-center">
                                <label class="col-sm-3 text-end fw-bold">Contraseña</label>
                                <div class="col-sm-9">
                                    <input type="password" name="contrasena" class="form-control rounded-0 border-dark" required>
                                </div>
                            </div>

                            <div class="row mb-3 align-items-center">
                                <label class="col-sm-3 text-end fw-bold">Teléfono</label>
                                <div class="col-sm-9">
                                    <input type="text" name="telefono" class="form-control rounded-0 border-dark">
                                </div>
                            </div>

                            <div class="d-flex justify-content-center gap-4 mt-4">
                                <button type="submit" class="btn btn-light border-dark px-4 fw-bold">Guardar</button>
                                <button type="button" class="btn btn-light border-dark px-4 fw-bold" data-bs-dismiss="modal">Cancelar</button>
                            </div>

                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- ======================================================== -->
        <!-- MODAL: EDITAR USUARIO                                    -->
        <!-- ======================================================== -->
        <div class="modal fade" id="modalEditarUsuario" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-lg">
                <div class="modal-content rounded-0 bg-white" style="border: 2px solid #000;">

                    <div class="modal-header bg-prae text-white py-2 rounded-0">
                        <span class="fw-bold small">Editar información de usuario</span>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                    </div>

                    <div class="modal-body p-5">
                        <h4 class="text-center mb-4">Editar Usuario</h4>
                        <form action="${pageContext.request.contextPath}/UsuarioServlet?action=editar" method="POST">
                            <div class="row mb-3 align-items-center">
                                <label class="col-sm-3 fw-bold">Nombre</label>
                                <div class="col-sm-9"><input type="text" name="nombre" class="form-control rounded-0 border-dark" value="Docente_01"></div>
                            </div>
                            <div class="row mb-3 align-items-center">
                                <label class="col-sm-3 fw-bold">Rol</label>
                                <div class="col-sm-9 d-flex flex-wrap gap-2 small">
                                    <div class="form-check"><input class="form-check-input border-dark" type="checkbox" checked><label class="form-check-label">Admin</label></div>
                                    <div class="form-check"><input class="form-check-input border-dark" type="checkbox"><label class="form-check-label">Docente</label></div>
                                </div>
                            </div>
                            <div class="row mb-3 align-items-center">
                                <label class="col-sm-3 fw-bold">Correo</label>
                                <div class="col-sm-9"><input type="email" name="correo" class="form-control rounded-0 border-dark" value="docente01@systemaprae.com"></div>
                            </div>
                            <div class="d-flex justify-content-center gap-3 mt-4">
                                <button type="submit" class="btn btn-prae rounded-0 px-4">Actualizar cambios</button>
                                <button type="button" class="btn btn-light border-dark rounded-0 px-4" data-bs-dismiss="modal">Cancelar</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- ======================================================== -->
        <!-- MODAL: ELIMINAR USUARIO                                  -->
        <!-- ======================================================== -->
        <div class="modal fade" id="modalEliminarUsuario" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content rounded-0 bg-white" style="border: 2px solid #000;">

                    <div class="modal-header bg-danger text-white py-2 rounded-0">
                        <span class="fw-bold small">Confirmar eliminación</span>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                    </div>

                    <div class="modal-body p-4 text-center">
                        <h5 class="mb-4">¿Estás seguro de eliminar este usuario?</h5>
                        <p class="small text-muted mb-4">Esta acción no se puede deshacer. Todos los datos asociados a este usuario serán eliminados permanentemente del sistema.</p>

                        <div class="d-flex justify-content-center gap-3">
                            <a href="${pageContext.request.contextPath}/UsuarioServlet?action=eliminar" class="btn btn-danger rounded-0 px-4 fw-bold text-decoration-none">Sí, eliminar</a>
                            <button type="button" class="btn btn-light border-dark rounded-0 px-4" data-bs-dismiss="modal">Cancelar</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <jsp:include page="/includes/footer.jsp" />