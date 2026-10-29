<%-- 
    Document   : login
    Created on : 27/10/2026, 4:30:36 p. m.
    Author     : Jermat
--%>

<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Iniciar Sesión - SystemaPRAE</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
</head>
<body class="bg-light d-flex flex-column min-vh-100">

    <header class="navbar navbar-prae navbar-dark p-3 shadow-sm">
        <div class="container-fluid d-flex align-items-center gap-3">
            <div class="logo-placeholder d-flex align-items-center justify-content-center bg-white">
                <span class="fs-4 text-muted">✕</span>
            </div>
            <h1 class="navbar-brand fs-5 fs-md-4 fs-lg-3 m-0 fw-semibold tracking-tight text-white text-wrap">
                Bienvenido al PRAE Digital 
            </h1>
        </div>
    </header>

    <main class="flex-grow-1 d-flex align-items-center justify-content-center p-4">
        
        <div class="w-100" style="max-width: 450px;">
            
            <h2 class="text-center fw-normal text-dark tracking-tight mb-4">
                Iniciar Sesión
            </h2>

            <div class="card rounded-0 shadow-sm" style="border: 2px solid #000; background-color: #f1f1f1;">
                <div class="card-body p-4 px-md-5">
                    <% if (request.getParameter("error") != null) { %>
                    <div class="alert alert-danger rounded-0 small py-2">Correo o contraseña incorrectos.</div>
                    <% } %>
                    <% if (request.getParameter("registro") != null) { %>
                    <div class="alert alert-success rounded-0 small py-2">Registro exitoso. Ya puedes iniciar sesión.</div>
                    <% }%>
                    <form action="LoginServlet" method="POST">
                        <div class="mb-3 d-flex align-items-center gap-2">
                            <label for="email" class="form-label mb-0 small fw-bold text-end" style="width: 70px;">Email:</label>
                            <input type="email" name="email" class="form-control rounded-0" id="email" style="border: 2px solid #000;" required>
                        </div>
                        
                        <div class="mb-3 d-flex align-items-center gap-2">
                            <label for="password" class="form-label mb-0 small fw-bold text-end" style="width: 70px;">Password:</label>
                            <input type="password" name="password" class="form-control rounded-0" id="password" style="border: 2px solid #000;" required>
                        </div>
                        
                        <div class="mb-3 d-flex justify-content-center">
                            <div class="form-check">
                                <input type="checkbox" name="recordarme" class="form-check-input border-dark" id="recordarme">
                                <label class="form-check-label small fw-medium text-dark" for="recordarme">Recordarme</label>
                            </div>
                        </div>
                        
                        <div class="d-flex justify-content-center mb-4">
                            <button type="submit" class="btn btn-light bg-white px-4 py-1 fw-bold text-dark" style="border: 2px solid #000; box-shadow: 2px 2px 0px 0px rgba(0,0,0,1);">
                                Ingresar
                            </button>
                        </div>
                        
                        <div class="text-center d-flex flex-column gap-2 small">
                            <a href="#" class="text-primary text-decoration-none hover-verde">¿Olvidaste la contraseña?</a>
                            <span class="text-muted">
                            ¿No tienes cuenta? <a href="registro.jsp" class="text-primary text-decoration-none hover-verde">Regístrate aquí</a>
                            </span>
                        </div>
                    </form>
                    

                </div>
            </div>
        </div>

    </main>

    <jsp:include page="/includes/footer.jsp" />