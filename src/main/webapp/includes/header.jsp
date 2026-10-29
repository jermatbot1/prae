<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SystemaPRAE</title>
    
    <!-- aqui es lo del Bootstrap 5 CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Estilo CSS para que salga bien -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
</head>
<body class="bg-light d-flex flex-column min-vh-100">

    <header class="navbar navbar-prae navbar-dark p-3 shadow-sm">
        <div class="container-fluid d-flex flex-column flex-md-row justify-content-between align-items-center gap-3">
            <div class="d-flex align-items-center gap-3">
                <div class="logo-placeholder d-flex align-items-center justify-content-center bg-white">
                    <span class="fs-4 text-muted">✕</span>
                </div>
                <h1 class="navbar-brand fs-5 fs-md-3 fs-lg-2 m-0 fw-semibold tracking-tight text-white text-wrap">
                    SystemaPRAE
                </h1>
            </div>
            <div class="bg-white text-dark border border-dark px-3 py-1 d-flex align-items-center gap-2 rounded shadow-sm dropdown">
                <!-- Muestra el nombre del usuario logueado almacenado en HttpSession -->
                <a href="#" class="text-dark text-decoration-none dropdown-toggle small fw-medium" data-bs-toggle="dropdown" aria-expanded="false">
                    Perfil: ${sessionScope.nombres != null ? sessionScope.nombres : 'Invitado'}
                </a>
                <!-- Menú desplegable para la acción de cierre de sesión  -->   
                <ul class="dropdown-menu dropdown-menu-end">
                      <li><a class="dropdown-item text-danger fw-bold" href="LogoutServlet">Cerrar Sesión</a></li>
                </ul>
            </div>

        <div class="container-fluid justify-content-end mt-3">
            <nav class="nav bg-white border border-dark text-dark small fw-medium">
                <a href="${pageContext.request.contextPath}/dashboard.jsp" class="nav-link text-dark border-end border-dark py-1 px-3">Inicio</a>
                <a href="${pageContext.request.contextPath}/biblioteca.jsp#ppp" class="nav-link text-dark border-end border-dark py-1 px-3">PPP</a>
                <a href="${pageContext.request.contextPath}/biblioteca.jsp#padres" class="nav-link text-dark border-end border-dark py-1 px-3">Escuela de padres</a>
                <a href="${pageContext.request.contextPath}/biblioteca.jsp#ambiental" class="nav-link text-dark border-end border-dark py-1 px-3">Zona ambiental</a>
                <a href="${pageContext.request.contextPath}/biblioteca.jsp" class="nav-link text-dark border-end border-dark py-1 px-3 active fw-bold bg-secondary-subtle">Biblioteca</a>
                <a href="${pageContext.request.contextPath}/biblioteca.jsp#prensa" class="nav-link text-dark border-end border-dark py-1 px-3">Prensa</a>
                <a href="${pageContext.request.contextPath}/biblioteca.jsp#asociadas" class="nav-link text-dark py-1 px-3">Instituciones asociadas</a>
            </nav>
        </div>
    </header>