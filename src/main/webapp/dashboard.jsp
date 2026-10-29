


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/includes/header.jsp" />


<main class="container-fluid my-4 flex-grow-1">
    <div class="row g-4">
        
        <!-- BARRA LATERAL IZQUIERDA: ACCIONES Y PANEL ADMINISTRATIVO -->
        <aside class="col-12 col-md-3 col-lg-2 d-flex flex-column gap-4 border-end border-light-subtle">
            <div class="d-flex flex-column gap-2">
                <hr class="border-secondary border-2 w-25 my-1">
                <button class="btn btn-success btn-balsamiq py-2 px-3 small" data-bs-toggle="modal" data-bs-target="#modalCrearEvento">Crear evento</button> 
                <button class="btn btn-success btn-balsamiq py-2 px-3 small" data-bs-toggle="modal" data-bs-target="#modalEditarEvento">Editar evento</button>
                <button class="btn btn-success btn-balsamiq py-2 px-3 small" data-bs-toggle="modal" data-bs-target="#modalEliminarEvento">Eliminar evento</button>
                <a href="${pageContext.request.contextPath}/BibliotecaServlet" class="btn btn-biblioteca-marino btn-balsamiq py-2 px-3 small mt-2">Biblioteca</a>
            </div>

            <div class="d-flex flex-column gap-2">
                <hr class="border-secondary border-2 w-25 my-1">
                <span class="text-uppercase text-muted fw-bold tracking-wider" style="font-size: 11px;">Panel administrativo</span>
                <a href="${pageContext.request.contextPath}/UsuarioServlet?accion=listar" class="btn btn-success btn-balsamiq py-2 px-3 small">Gestionar usuarios</a>
                <button class="btn btn-success btn-balsamiq py-2 px-3 small" data-bs-toggle="modal" data-bs-target="#modalGestionAreas">Gestionar áreas</button>
                <button class="btn btn-success btn-balsamiq py-2 px-3 small" data-bs-toggle="modal" data-bs-target="#modalReportes">Reportes</button>
            </div>
        </aside>

        <!-- SECCIÓN CENTRAL: CALENDARIO INSTITUCIONAL -->
        <section class="col-12 col-md-6 col-lg-7">
            <h2 class="text-center fw-normal text-dark tracking-tight mb-4">
                Calendario institucional
            </h2>

            <div class="card calendario-container rounded-0 shadow-sm">
                <div class="card-header calendario-header bg-white d-flex justify-content-between align-items-center py-2 px-4 fw-bold">
                    <button class="btn btn-sm btn-light border-0 py-0">◀</button>
                    <span class="text-uppercase small">JULIO 2026</span>
                    <button class="btn btn-sm btn-light border-0 py-0">▶</button>
                </div>
                
                <div class="card-body p-0">
                    <div class="row g-0 bg-light border-bottom border-dark text-muted fw-bold text-center py-1 small">
                        <div class="col">DO</div><div class="col">LU</div><div class="col">MA</div>
                        <div class="col">MI</div><div class="col">JU</div><div class="col">VI</div><div class="col">SA</div>
                    </div>

                    <div class="row g-0">
                        <div class="col calendario-celda text-muted small text-start">28</div>
                        <div class="col calendario-celda text-muted small text-start">29</div>
                        <div class="col calendario-celda text-muted small text-start">30</div>
                        <div class="col calendario-celda text-dark small text-start fw-medium">1</div>
                        <div class="col calendario-celda text-dark small text-start fw-medium">2</div>
                        <div class="col calendario-celda text-dark small text-start fw-medium">3</div>
                        <div class="col calendario-celda text-dark small text-start fw-medium border-end-0">4</div>
                    </div>
                    <div class="row g-0">
                        <div class="col calendario-celda text-dark small text-start fw-medium">5</div>
                        <div class="col calendario-celda text-dark small text-start fw-medium">6</div>
                        <div class="col calendario-celda text-dark small text-start fw-medium">7</div>
                        <div class="col calendario-celda text-dark small text-start fw-medium">8</div>
                        <div class="col calendario-celda text-dark small text-start fw-medium">9</div>
                        <div class="col calendario-celda text-dark small text-start fw-medium">10</div>
                        <div class="col calendario-celda text-dark small text-start fw-medium border-end-0">11</div>
                    </div>
                    <div class="row g-0">
                        <div class="col calendario-celda text-start position-relative">
                            <span class="badge border border-2 border-success text-success bg-white rounded-circle d-inline-flex align-items-center justify-content-center p-0 m-1" style="width: 22px; height: 22px; font-size: 11px;">12</span>
                        </div>
                        <div class="col calendario-celda text-dark small text-start fw-medium">13</div>
                        <div class="col calendario-celda text-dark small text-start fw-medium">14</div>
                        <div class="col calendario-celda text-dark small text-start fw-medium">15</div>
                        <div class="col calendario-celda text-dark small text-start fw-medium">16</div>
                        <div class="col calendario-celda text-dark small text-start fw-medium">17</div>
                        <div class="col calendario-celda text-dark small text-start fw-medium border-end-0">18</div>
                    </div>
                    <div class="row g-0">
                        <div class="col calendario-celda text-dark small text-start fw-medium">19</div>
                        <div class="col calendario-celda text-dark small text-start fw-medium">20</div>
                        <div class="col calendario-celda text-dark small text-start fw-medium">21</div>
                        <div class="col calendario-celda text-dark small text-start fw-medium">22</div>
                        <div class="col calendario-celda text-dark small text-start fw-medium">23</div>
                        <div class="col calendario-celda text-dark small text-start fw-medium">24</div>
                        <div class="col calendario-celda text-dark small text-start fw-medium border-end-0">25</div>
                    </div>
                    <div class="row g-0">
                        <div class="col calendario-celda text-dark small text-start fw-medium border-bottom-0">26</div>
                        <div class="col calendario-celda text-dark small text-start fw-medium border-bottom-0">27</div>
                        <div class="col calendario-celda text-dark small text-start fw-medium border-bottom-0">28</div>
                        <div class="col calendario-celda text-dark small text-start fw-medium border-bottom-0">29</div>
                        <div class="col calendario-celda text-dark small text-start fw-medium border-bottom-0">30</div>
                        <div class="col calendario-celda text-dark small text-start fw-medium border-bottom-0">31</div>
                        <div class="col calendario-celda text-muted small text-start border-end-0 border-bottom-0">1</div>
                    </div>
                </div>
            </div>
        </section>

        <!-- BARRA LATERAL DERECHA: EVENTOS Y EVIDENCIAS -->
        <aside class="col-12 col-md-3 col-lg-3">
            <div class="p-3 rounded bg-white h-100 position-relative" style="border: 2px solid #0E8C2F;">
                <span class="position-absolute bg-white px-2 font-bold small" style="top: -10px; left: 15px; color: #0E8C2F;">
                    Eventos
                </span>
                
                <div class="d-flex flex-column gap-4 mt-2">
                    <c:choose>
                        <c:when test="${not empty listaActividades}">
                            <c:forEach var="act" items="${listaActividades}">
                                <a href="${pageContext.request.contextPath}/ActividadesServlet?accion=listar&id=${act.id_actividad}"
                                    class="text-decoration-none d-flex flex-column gap-1 evento-item"
                                    data-id="${act.id_actividad}"
                                    data-titulo="<c:out value='${act.nombre_actividad}'/>"
                                    data-descripcion="<c:out value='${act.descripcion}'/>"
                                    data-fecha="${act.fecha_programada}"
                                    data-estado="${act.estado}">
                                    <div class="evidencia-box d-flex align-items-center justify-content-center">
                                    <span class="text-muted fs-4">✕</span>
                                    </div>
                                    <span class="text-center px-2 py-1 rounded text-white" style="font-size: 10px; font-weight: 500; background-color: #0E8C2F;">
                                        <c:out value="${act.nombre_actividad}"/>
                                    </span>
                                </a>
                                
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <!-- CORREGIDO: Apunta a ActividadesServlet en plural y usa param 'accion' -->
                            <a href="${pageContext.request.contextPath}/ActividadesServlet?accion=listar&id=1" class="text-decoration-none d-flex flex-column gap-1">
                                <div class="evidencia-box d-flex align-items-center justify-content-center">
                                    <span class="text-muted fs-4">✕</span>
                                </div>
                                <span class="text-center px-2 py-1 rounded text-white" style="font-size: 10px; font-weight: 500; background-color: #0E8C2F;">
                                    Evidencia Proyecto Pedagógico Productivo
                                </span>
                            </a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </aside>

    </div>
</main>

<!-- ======================================================== -->
<!-- MODAL: CREAR EVENTO                                      -->
<!-- ======================================================== -->
<div class="modal fade" id="modalCrearEvento" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content rounded-0 bg-white" style="border: 2px solid #000; box-shadow: 5px 5px 0px 0px rgba(0,0,0,0.1);">
            <div class="modal-header border-bottom border-dark py-1 rounded-0 bg-light">
                <span class="small fw-bold text-dark">Crear evento</span>
                <button type="button" class="btn-close btn-sm" data-bs-dismiss="modal" aria-label="Cerrar"></button>
            </div>
            
            <div class="modal-body p-4 p-md-5">
                <h2 class="text-center mb-5 tracking-tight text-dark">Crear evento</h2>
                
                <form action="${pageContext.request.contextPath}/ActividadesServlet?accion=crear" method="POST">
                    <div class="row mb-3 align-items-center">
                        <label class="col-sm-4 col-form-label text-start text-sm-end small fw-medium">1. Título del evento</label>
                        <div class="col-sm-7">
                            <input type="text" name="titulo" class="form-control rounded-0" style="border: 2px solid #000;" required>
                        </div>
                    </div>

                    <div class="row mb-3">
                        <label class="col-sm-4 col-form-label text-start text-sm-end small fw-medium">2. Descripción</label>
                        <div class="col-sm-7">
                            <textarea name="descripcion" class="form-control rounded-0" rows="3" style="border: 2px solid #000;"></textarea>
                        </div>
                    </div>

                    <div class="row mb-3 align-items-center">
                        <label class="col-sm-4 col-form-label text-start text-sm-end small fw-medium">3. Tipo de evento</label>
                        <div class="col-sm-7">
                            <input type="text" name="tipo" class="form-control rounded-0" style="border: 2px solid #000;">
                        </div>
                    </div>

                    <div class="row mb-3 align-items-center">
                        <label class="col-sm-4 col-form-label text-start text-sm-end small fw-medium">4. Fecha programada</label>
                        <div class="col-sm-7">
                            <input type="date" name="fechaInicio" class="form-control rounded-0" style="border: 2px solid #000;" required>
                        </div>
                    </div>

                    <div class="row mb-3 align-items-center">
                        <label class="col-sm-4 col-form-label text-start text-sm-end small fw-medium">5. Ubicación</label>
                        <div class="col-sm-7">
                            <input type="text" name="ubicacion" class="form-control rounded-0" style="border: 2px solid #000;">
                        </div>
                    </div>

                    <div class="row mb-3 align-items-center">
                        <label class="col-sm-4 col-form-label text-start text-sm-end small fw-medium">6. Responsable</label>
                        <div class="col-sm-7">
                            <input type="text" name="responsable" class="form-control rounded-0" style="border: 2px solid #000;">
                        </div>
                    </div>

                    <div class="row mb-3 align-items-center">
                        <label class="col-sm-4 col-form-label text-start text-sm-end small fw-medium">7. Estado</label>
                        <div class="col-sm-7">
                            <select name="estado" class="form-control rounded-0" style="border: 2px solid #000;">
                                <option value="Pendiente">Pendiente</option>
                                <option value="En proceso">En proceso</option>
                                <option value="Completada">Completada</option>
                                <option value="cancelada">Cancelada</option>
                            </select>
                        </div>
                    </div>

                    <div class="d-flex justify-content-between px-md-5 mt-4">
                        <button type="submit" class="btn btn-light bg-white fw-bold text-dark px-4" style="border: 2px solid #000; box-shadow: 2px 2px 0px 0px rgba(0,0,0,1);">
                            Guardar evento
                        </button>
                        <button type="button" class="btn btn-light bg-white fw-bold text-dark px-4" data-bs-dismiss="modal" style="border: 2px solid #000; box-shadow: 2px 2px 0px 0px rgba(0,0,0,1);">
                            Cancelar
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- ======================================================= -->
<!-- MODAL: EDITAR EVENTO                                    -->
<!-- ======================================================= -->
<div class="modal fade" id="modalEditarEvento" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content rounded-0 bg-white" style="border: 2px solid #000; box-shadow: 5px 5px 0px 0px rgba(0,0,0,0.1);">
            <div class="modal-header border-bottom border-dark py-1 rounded-0 bg-light">
                <span class="small fw-bold text-dark">Editar evento</span>
                <button type="button" class="btn-close btn-sm" data-bs-dismiss="modal" aria-label="Cerrar"></button>
            </div>
            
            <div class="modal-body p-4 p-md-5">
                <h2 class="text-center mb-5 tracking-tight text-dark">Editar evento</h2>
                
                <form action="${pageContext.request.contextPath}/ActividadesServlet?accion=editar" method="POST">
                    <input type="hidden" name="id_actividad" value="">

                    <div class="row mb-3 align-items-center">
                        <label class="col-sm-4 col-form-label text-start text-sm-end small fw-medium">1. Título del evento</label>
                        <div class="col-sm-7">
                            <input type="text" name="titulo" value="${param.titulo}" class="form-control rounded-0" style="border: 2px solid #000;" required>
                        </div>
                    </div>

                    <div class="row mb-3">
                        <label class="col-sm-4 col-form-label text-start text-sm-end small fw-medium">2. Descripción</label>
                        <div class="col-sm-7">
                            <textarea name="descripcion" class="form-control rounded-0" rows="3" style="border: 2px solid #000;"><c:out value="${param.descripcion}"/></textarea>
                        </div>
                    </div>

                    <div class="row mb-3 align-items-center">
                        <label class="col-sm-4 col-form-label text-start text-sm-end small fw-medium">3. Tipo de evento</label>
                        <div class="col-sm-7">
                            <input type="text" name="tipo" class="form-control rounded-0" style="border: 2px solid #000;">
                        </div>
                    </div>

                    <div class="row mb-3 align-items-center">
                        <label class="col-sm-4 col-form-label text-start text-sm-end small fw-medium">4. Fecha programada</label>
                        <div class="col-sm-7">
                            <input type="date" name="fecha" value="${param.fecha}" class="form-control rounded-0" style="border: 2px solid #000;" required>
                        </div>
                    </div>

                    <div class="row mb-3 align-items-center">
                        <label class="col-sm-4 col-form-label text-start text-sm-end small fw-medium">5. Ubicación</label>
                        <div class="col-sm-7">
                            <input type="text" name="ubicacion" class="form-control rounded-0" style="border: 2px solid #000;">
                        </div>
                    </div>

                    <div class="row mb-3 align-items-center">
                        <label class="col-sm-4 col-form-label text-start text-sm-end small fw-medium">6. Responsable</label>
                        <div class="col-sm-7">
                            <input type="text" name="responsable" class="form-control rounded-0" style="border: 2px solid #000;">
                        </div>
                    </div>

                    <div class="row mb-3 align-items-center">
                        <label class="col-sm-4 col-form-label text-start text-sm-end small fw-medium">7. Estado</label>
                        <div class="col-sm-7">
                            <select name="estado" class="form-control rounded-0" style="border: 2px solid #000;">
                                <option value="Pendiente">Pendiente</option>
                                <option value="En proceso">En proceso</option>
                                <option value="Completada">Completada</option>
                                <option value="cancelada">Cancelada</option>
                            </select>
                        </div>
                    </div>

                    <div class="d-flex justify-content-between px-md-5 mt-4">
                        <button type="submit" class="btn btn-light bg-white fw-bold text-dark px-4" style="border: 2px solid #000; box-shadow: 2px 2px 0px 0px rgba(0,0,0,1);">
                            Guardar cambios
                        </button>
                        <button type="button" class="btn btn-light bg-white fw-bold text-dark px-4" data-bs-dismiss="modal" style="border: 2px solid #000; box-shadow: 2px 2px 0px 0px rgba(0,0,0,1);">
                            Cancelar
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- =================================================       -->
<!-- MODAL: ELIMINAR EVENTO                                  -->
<!-- ======================================================= -->
<div class="modal fade" id="modalEliminarEvento" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" style="max-width: 320px;">
        <div class="modal-content text-center bg-white" style="border: 2px solid #000; border-radius: 12px; box-shadow: 4px 4px 0px rgba(0,0,0,0.1);">
            <div class="modal-header justify-content-center py-2" style="border-bottom: 0;">
                <h6 class="modal-title fw-bold text-dark w-100">Alerta</h6>
            </div>
            <div class="modal-body py-3">
                <p class="mb-2 small fw-medium text-dark">¿Deseas eliminar el evento?</p>
            </div>
            <div class="modal-footer p-0 d-flex flex-nowrap" style="border-top: 2px solid #000;">
                <button type="button" class="btn btn-link text-dark text-decoration-none w-50 m-0 py-2 rounded-0 fw-bold" data-bs-dismiss="modal" style="border-right: 2px solid #000;">
                    No
                </button>
                <a id="btnConfirmarEliminar" href="#" class="btn btn-link text-dark text-decoration-none w-50 m-0 py-2 rounded-0 fw-bold">
                    Sí
                </a>
            </div>
        </div>
    </div>
</div>

<!-- ======================================================== -->
<!-- MODAL: REPORTES ADMINISTRATIVOS                          -->
<!-- ======================================================== -->
<div class="modal fade" id="modalReportes" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content rounded-0 bg-white" style="border: 2px solid #000;">
            <div class="modal-header text-white py-2 rounded-0" style="background-color: #0E8C2F;">
                <span class="fw-bold small">Reportes Administrativos</span>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body p-4 text-center">
                <div class="d-grid gap-3">
                    <button class="btn btn-outline-dark rounded-0">Reporte de Usuarios por Rol</button>
                    <button class="btn btn-outline-dark rounded-0">Reporte de Actividad del PRAE</button>
                    <button class="btn btn-outline-dark rounded-0">Reporte de Asistencia Padres</button>
                </div>
            </div>
        </div>
    </div>
</div>


<script>
    //editar
    let eventoSeleccionado = null;

    // 1. Al hacer clic en un evento, guardamos sus datos y evitamos que la página cambie
    document.addEventListener("click", function (e) {
        const item = e.target.closest(".evento-item");
        if (item) {
            e.preventDefault();
            eventoSeleccionado = item.dataset;
        }
    });

    // 2. Al abrir el modal de editar, llenamos los campos con el evento seleccionado
    document.getElementById("modalEditarEvento").addEventListener("show.bs.modal", function (e) {
        if (!eventoSeleccionado) {
            e.preventDefault();
            alert("Primero selecciona un evento de la lista.");
            return;
        }
        const form = this.querySelector("form");
        form.querySelector('[name="id_actividad"]').value = eventoSeleccionado.id;
        form.querySelector('[name="titulo"]').value = eventoSeleccionado.titulo;
        form.querySelector('[name="descripcion"]').value = eventoSeleccionado.descripcion;
        form.querySelector('[name="fecha"]').value = eventoSeleccionado.fecha;
        form.querySelector('[name="estado"]').value = eventoSeleccionado.estado;
    });
    
    //eliminar
    
    document.getElementById("btnConfirmarEliminar").addEventListener("click", function (e) {
    if (!eventoSeleccionado) {
        e.preventDefault();
        alert("Primero selecciona un evento de la lista.");
        return;
    }
    this.href = "${pageContext.request.contextPath}/ActividadesServlet?accion=eliminar&id=" + eventoSeleccionado.id;
});
</script>

<jsp:include page="/includes/footer.jsp" />