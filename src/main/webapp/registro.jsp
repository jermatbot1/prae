<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registro - SystemaPRAE</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
</head>
<body class="bg-light d-flex flex-column min-vh-100">

    <header class="navbar navbar-dark p-3 shadow-sm" style="background-color: #0E8C2F;">
        <div class="container-fluid d-flex align-items-center gap-3">
            <div class="bg-white d-flex align-items-center justify-content-center" style="width: 50px; height: 50px; border: 2px solid #000;">
                <span class="fs-4 text-muted">✕</span>
            </div>
            <h1 class="navbar-brand fs-5 m-0 fw-semibold text-white text-wrap">
                Bienvenido al PRAE Digital
            </h1>
        </div>
    </header>

    <main class="flex-grow-1 d-flex flex-column align-items-center justify-content-center p-4">

        <h2 class="text-center fw-normal text-dark mb-4">Ingreso de datos</h2>

        <div class="w-100" style="max-width: 550px;">
            <div class="card rounded-0 shadow-sm" style="border: 2px solid #000; background-color: #f1f1f1;">
                <div class="card-body p-4 px-md-5">

                    <form action="${pageContext.request.contextPath}/UsuarioServlet?accion=registrar" method="POST">

                        <div class="mb-3 row align-items-center">
                            <label for="nombre" class="col-sm-4 col-form-label text-end small fw-bold">Nombre:</label>
                            <div class="col-sm-8">
                                <input type="text" name="nombres" class="form-control rounded-0 form-control-sm" id="nombre" placeholder="Ingrese su Nombre" style="border: 2px solid #000;" required>
                            </div>
                        </div>

                        <div class="mb-3 row align-items-center">
                            <label for="apellido" class="col-sm-4 col-form-label text-end small fw-bold">Apellido:</label>
                            <div class="col-sm-8">
                                <input type="text" name="apellidos" class="form-control rounded-0 form-control-sm" id="apellido" placeholder="Ingrese su Apellido" style="border: 2px solid #000;" required>
                            </div>
                        </div>

                        <div class="mb-3 row align-items-center">
                            <label for="correo" class="col-sm-4 col-form-label text-end small fw-bold">Correo electrónico:</label>
                            <div class="col-sm-8">
                                <input type="email" name="correo" class="form-control rounded-0 form-control-sm" id="correo" placeholder="Ingrese su Correo electrónico" style="border: 2px solid #000;" required>
                            </div>
                        </div>

                        <div class="mb-3 row align-items-center">
                            <label for="cedula" class="col-sm-4 col-form-label text-end small fw-bold">Cédula:</label>
                            <div class="col-sm-8">
                                <input type="number" name="numero_documento" class="form-control rounded-0 form-control-sm" id="cedula" placeholder="Ingrese su Cédula" style="border: 2px solid #000;" required>
                            </div>
                        </div>

                        <div class="mb-3 row align-items-center">
                            <label for="fechaNacimiento" class="col-sm-4 col-form-label text-end small fw-bold">Fecha de nacimiento:</label>
                            <div class="col-sm-8">
                                <input type="date" class="form-control rounded-0 form-control-sm" id="fechaNacimiento" style="border: 2px solid #000;" required>
                            </div>
                        </div>

                        <div class="mb-3 row align-items-center">
                            <label for="password" class="col-sm-4 col-form-label text-end small fw-bold">Contraseña:</label>
                            <div class="col-sm-8">
                                <input type="password" name="contrasena" class="form-control rounded-0 form-control-sm" id="password" placeholder="Ingrese su Contraseña" style="border: 2px solid #000;" required>
                            </div>
                        </div>

                        <div class="mb-4 row align-items-center">
                            <label for="confirmPassword" class="col-sm-4 col-form-label text-end small fw-bold text-nowrap">Confirmar contraseña:</label>
                            <div class="col-sm-8">
                                <input type="password" name="confirmar" class="form-control rounded-0 form-control-sm" id="confirmPassword" placeholder="Confirma su contraseña" style="border: 2px solid #000;" required>
                            </div>
                        </div>

                        <div class="d-flex justify-content-between mt-2 px-2">
                            <button type="submit" class="btn btn-light bg-white px-4 py-1 fw-bold text-dark" style="border: 2px solid #000; box-shadow: 2px 2px 0px 0px rgba(0,0,0,1);">
                                Guardar
                            </button>
                            <a href="${pageContext.request.contextPath}/index.jsp" class="text-decoration-none">
                                <button type="button" class="btn btn-light bg-white px-4 py-1 fw-bold text-dark" style="border: 2px solid #000; box-shadow: 2px 2px 0px 0px rgba(0,0,0,1);">
                                    Cancelar
                                </button>
                            </a>
                        </div>

                    </form>

                </div>
            </div>
        </div>
    </main>

    <jsp:include page="/includes/footer.jsp" />
</body>
</html>