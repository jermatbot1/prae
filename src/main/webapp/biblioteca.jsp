<%-- 
    Document   : biblioteca
    Created on : 27/09/2026, 5:01:41 p. m.
    Author     : Jermat
--%>
<%
    if (session.getAttribute("id_usuario") == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
%>
<%@page contentType="biblioteca.jsp" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- INCLUIR CABECERA COMÚN Y NAVEGACIÓN -->
<jsp:include page="/includes/header.jsp" />

<main class="container-fluid my-4 flex-grow-1">
    <div class="row g-4">
        
        <!-- BARRA LATERAL IZQUIERDA -->
        <aside class="col-12 col-md-3 col-lg-2 d-flex flex-column gap-4 border-end border-light-subtle">
            <div class="d-flex flex-column gap-2">
                <hr class="border-secondary border-2 w-25 my-1">
                <a href="${pageContext.request.contextPath}/dashboard.jsp" class="btn btn-success btn-balsamiq py-2 px-3 small text-decoration-none text-white text-center">
                    ◀ Volver al Dashboard
                </a>
            </div>
        </aside>

        <!-- SECCIÓN PRINCIPAL: ÁREA DE BIBLIOTECA -->
        <section class="col-12 col-md-9 col-lg-10">
            <h2 class="text-center fw-normal text-dark tracking-tight mb-2">Biblioteca</h2>
            <p class="text-center text-muted small mb-4">Área de Biblioteca</p>

            <div class="d-flex flex-column flex-md-row align-items-start border border-dark p-3 bg-white" style="min-height: 500px;">
                
                <!-- MENÚ DE PESTAÑAS (TABS) -->
                <div class="nav flex-column nav-pills me-md-3 mb-3 mb-md-0 border border-dark bg-light rounded-0" id="v-pills-tab" role="tablist" aria-orientation="vertical" style="width: 100%; max-width: 240px;">
                    <button class="nav-link rounded-0 text-dark border-bottom border-dark text-start small active fw-medium py-2" id="v-pills-padres-tab" data-bs-toggle="pill" data-bs-target="#v-pills-padres" type="button" role="tab">Escuela de padres</button>
                    <button class="nav-link rounded-0 text-dark border-bottom border-dark text-start small fw-medium py-2" id="v-pills-ppp-tab" data-bs-toggle="pill" data-bs-target="#v-pills-ppp" type="button" role="tab">Proyecto pedagógico productivo</button>
                    <button class="nav-link rounded-0 text-dark border-bottom border-dark text-start small fw-medium py-2" id="v-pills-ambiental-tab" data-bs-toggle="pill" data-bs-target="#v-pills-ambiental" type="button" role="tab">Zona ambiental</button>
                    <button class="nav-link rounded-0 text-dark border-bottom border-dark text-start small fw-medium py-2" id="v-pills-prensa-tab" data-bs-toggle="pill" data-bs-target="#v-pills-prensa" type="button" role="tab">Proyecto de prensa</button>
                    <button class="nav-link rounded-0 text-dark border-bottom border-dark text-start small fw-medium py-2" id="v-pills-asociadas-tab" data-bs-toggle="pill" data-bs-target="#v-pills-asociadas" type="button" role="tab">Instituciones asociadas</button>
                    <button class="nav-link rounded-0 text-dark text-start small fw-medium py-2" id="v-pills-globales-tab" data-bs-toggle="pill" data-bs-target="#v-pills-globales" type="button" role="tab">Eventos globales</button>
                </div>

                <!-- CONTENIDO DE LAS PESTAÑAS -->
                <div class="tab-content flex-grow-1 w-100 border border-dark p-4 bg-white min-vh-50" id="v-pills-tabContent">
                    
                    <!-- 1. ESCUELA DE PADRES -->
                    <div class="tab-pane fade show active" id="v-pills-padres" role="tabpanel">
                        <h4 class="text-center fw-semibold mb-4 text-dark fs-5">Escuela de padres</h4>
                        <div class="row row-cols-1 row-cols-sm-2 g-4 justify-content-center">
                            <div class="col d-flex flex-column align-items-center" style="max-width: 240px;">
                                <a href="${pageContext.request.contextPath}/detalle-evento.jsp" class="text-decoration-none w-100 text-center">
                                    <div class="evidencia-box d-flex align-items-center justify-content-center"><span class="text-muted fs-3">✕</span></div>
                                    <span class="badge bg-light text-dark border border-dark rounded-0 mt-2 py-1 w-100 text-center small">1. evidencia</span>
                                </a>
                            </div>
                            <div class="col d-flex flex-column align-items-center" style="max-width: 240px;">
                                <a href="${pageContext.request.contextPath}/detalle-evento.jsp" class="text-decoration-none w-100 text-center">
                                    <div class="evidencia-box d-flex align-items-center justify-content-center"><span class="text-muted fs-3">✕</span></div>
                                    <span class="badge bg-light text-dark border border-dark rounded-0 mt-2 py-1 w-100 text-center small">2. evidencia</span>
                                </a>
                            </div>
                            <div class="col d-flex flex-column align-items-center" style="max-width: 240px;">
                                <a href="${pageContext.request.contextPath}/detalle-evento.jsp" class="text-decoration-none w-100 text-center">
                                    <div class="evidencia-box d-flex align-items-center justify-content-center"><span class="text-muted fs-3">✕</span></div>
                                    <span class="badge bg-light text-dark border border-dark rounded-0 mt-2 py-1 w-100 text-center small">3. evidencia</span>
                                </a>
                            </div>
                            <div class="col d-flex flex-column align-items-center" style="max-width: 240px;">
                                <a href="${pageContext.request.contextPath}/detalle-evento.jsp" class="text-decoration-none w-100 text-center">
                                    <div class="evidencia-box d-flex align-items-center justify-content-center"><span class="text-muted fs-3">✕</span></div>
                                    <span class="badge bg-light text-dark border border-dark rounded-0 mt-2 py-1 w-100 text-center small">4. evidencia</span>
                                </a>
                            </div>
                        </div>
                    </div>

                    <!-- 2. PPP -->
                    <div class="tab-pane fade" id="v-pills-ppp" role="tabpanel">
                        <h4 class="text-center fw-semibold mb-4 text-dark fs-5">Proyecto pedagógico productivo</h4>
                        <div class="row row-cols-1 row-cols-sm-2 g-4 justify-content-center">
                            <div class="col d-flex flex-column align-items-center" style="max-width: 240px;">
                                <a href="${pageContext.request.contextPath}/detalle-evento.jsp" class="text-decoration-none w-100 text-center">
                                    <div class="evidencia-box d-flex align-items-center justify-content-center"><span class="text-muted fs-3">✕</span></div>
                                    <span class="badge bg-light text-dark border border-dark rounded-0 mt-2 py-1 w-100 text-center small">Evidencia PPP 1</span>
                                </a>
                            </div>
                            <div class="col d-flex flex-column align-items-center" style="max-width: 240px;">
                                <a href="${pageContext.request.contextPath}/detalle-evento.jsp" class="text-decoration-none w-100 text-center">
                                    <div class="evidencia-box d-flex align-items-center justify-content-center"><span class="text-muted fs-3">✕</span></div>
                                    <span class="badge bg-light text-dark border border-dark rounded-0 mt-2 py-1 w-100 text-center small">Evidencia PPP 2</span>
                                </a>
                            </div>
                        </div>
                    </div>

                    <!-- 3. ZONA AMBIENTAL -->
                    <div class="tab-pane fade" id="v-pills-ambiental" role="tabpanel">
                        <h4 class="text-center fw-semibold mb-4 text-dark fs-5">Zona ambiental</h4>
                        <div class="row row-cols-1 row-cols-sm-2 g-4 justify-content-center">
                            <div class="col d-flex flex-column align-items-center" style="max-width: 240px;">
                                <a href="${pageContext.request.contextPath}/detalle-evento.jsp" class="text-decoration-none w-100 text-center">
                                    <div class="evidencia-box d-flex align-items-center justify-content-center"><span class="text-muted fs-3">✕</span></div>
                                    <span class="badge bg-light text-dark border border-dark rounded-0 mt-2 py-1 w-100 text-center small">Evidencia Ambiental 1</span>
                                </a>
                            </div>
                        </div>
                    </div>

                    <!-- 4. PRENSA -->
                    <div class="tab-pane fade" id="v-pills-prensa" role="tabpanel">
                        <h4 class="text-center fw-semibold mb-4 text-dark fs-5">Proyecto de prensa</h4>
                        <p class="text-center text-muted small">No hay evidencias cargadas en prensa actualmente.</p>
                    </div>

                    <!-- 5. INSTITUCIONES ASOCIADAS -->
                    <div class="tab-pane fade" id="v-pills-asociadas" role="tabpanel">
                        <h4 class="text-center fw-semibold mb-4 text-dark fs-5">Instituciones asociadas</h4>
                        <p class="text-center text-muted small">No hay evidencias cargadas para instituciones asociadas.</p>
                    </div>

                    <!-- 6. EVENTOS GLOBALES -->
                    <div class="tab-pane fade" id="v-pills-globales" role="tabpanel">
                        <h4 class="text-center fw-semibold mb-4 text-dark fs-5">Eventos globales</h4>
                        <p class="text-center text-muted small">No hay evidencias globales registradas.</p>
                    </div>

                </div>
            </div>
        </section>

    </div>
</main>

<!-- SCRIPT PARA MANEJAR LA NAVEGACIÓN POR HASH (#ppp, #padres, etc.) -->
<script>
    function activarPestanaPorHash() {
        let hash = window.location.hash;
        if (hash) {
            let tabId = 'v-pills-' + hash.substring(1) + '-tab';
            let tabBoton = document.getElementById(tabId);
            if (tabBoton) {
                let tab = new bootstrap.Tab(tabBoton);
                tab.show();
            }
        }
    }
    document.addEventListener("DOMContentLoaded", activarPestanaPorHash);
    window.addEventListener("hashchange", activarPestanaPorHash);
</script>

<!-- INCLUIR PIE DE PÁGINA -->
<jsp:include page="/includes/footer.jsp" />