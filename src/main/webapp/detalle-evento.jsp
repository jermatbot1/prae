<%-- 
    Document   : detalle-evento
    Created on : 27/10/2026, 5:07:44 p. m.
    Author     : Jermat
--%>

<%@page contentType="detalle-evento.jsp" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- INCLUIR CABECERA COMÚN Y NAVEGACIÓN -->
<jsp:include page="/includes/header.jsp" />

<main class="container flex-grow-1 my-4">
    
    <div class="card rounded-0 bg-white" style="border: 2px solid #000;">
        
        <div class="card-header bg-light border-bottom border-dark py-1 px-3">
            <span class="small fw-bold text-dark">Evidencia de Evento</span>
        </div>
        
        <div class="card-body p-4 p-md-5">
            
            <!-- GALERÍA DE IMÁGENES DEL EVENTO -->
            <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-4 mb-5 justify-content-start">
                
                <div class="col" style="max-width: 240px;">
                    <div class="evidencia-box d-flex flex-column align-items-center justify-content-center bg-white text-center p-2">
                        <span class="text-muted fs-3">✕</span>
                        <span class="text-dark small fw-medium mt-1" style="font-size: 11px;">Imágenes del evento</span>
                    </div>
                </div>
                
                <div class="col" style="max-width: 240px;">
                    <div class="evidencia-box d-flex flex-column align-items-center justify-content-center bg-white text-center p-2">
                        <span class="text-muted fs-3">✕</span>
                        <span class="text-dark small fw-medium mt-1" style="font-size: 11px;">Imágenes del evento</span>
                    </div>
                </div>
                
                <div class="col" style="max-width: 240px;">
                    <div class="evidencia-box d-flex flex-column align-items-center justify-content-center bg-white text-center p-2">
                        <span class="text-muted fs-3">✕</span>
                        <span class="text-dark small fw-medium mt-1" style="font-size: 11px;">Imágenes del evento</span>
                    </div>
                </div>
                
                <div class="col" style="max-width: 240px;">
                    <div class="evidencia-box d-flex flex-column align-items-center justify-content-center bg-white text-center p-2">
                        <span class="text-muted fs-3">✕</span>
                        <span class="text-dark small fw-medium mt-1" style="font-size: 11px;">Imágenes del evento</span>
                    </div>
                </div>
                
                <div class="col" style="max-width: 240px;">
                    <div class="evidencia-box d-flex flex-column align-items-center justify-content-center bg-white text-center p-2">
                        <span class="text-muted fs-3">✕</span>
                        <span class="text-dark small fw-medium mt-1" style="font-size: 11px;">Imágenes del evento</span>
                    </div>
                </div>
                
            </div>

            <!-- SECCIÓN DE DOCUMENTACIÓN Y ARCHIVOS ADJUNTOS -->
            <div class="d-flex flex-column flex-sm-row justify-content-between align-items-start align-items-sm-center gap-4 mt-4 pt-3">
                
                <div class="d-flex align-items-start gap-3">
                    <div class="bg-dark rounded p-2 d-flex align-items-center justify-content-center shadow-sm" style="width: 50px; height: 60px; border-bottom-right-radius: 15px !important;">
                        <span class="text-white fw-bold" style="font-size: 11px;">DOC</span>
                    </div>
                    <div class="d-flex flex-column">
                        <span class="fw-bold text-dark mb-1" style="font-size: 15px;">Documentación Asociada</span>
                        <a href="#" class="text-primary text-decoration-underline small hover-verde fw-medium">Descargar</a>
                    </div>
                </div>
                
                <div>
                    <a href="#" class="text-primary text-decoration-underline fw-bold hover-verde" style="font-size: 16px;" data-bs-toggle="modal" data-bs-target="#modalSubirDocs">
                        Adjuntar archivo
                    </a>
                </div>
                
            </div>

            <!-- BOTÓN DE NAVEGACIÓN HACIA ATRÁS -->
            <div class="d-flex justify-content-end mt-5 pt-3">
                <a href="${pageContext.request.contextPath}/dashboard.jsp" class="text-decoration-none">
                    <button type="button" class="btn btn-balsamiq bg-white px-4 py-1.5 text-dark" style="font-size: 14px;">
                        ◀ Volver al Calendario
                    </button>
                </a>
            </div>

        </div>
    </div>
    
</main>

<!-- ======================================================== -->
<!-- MODAL: SUBIR DOCUMENTACIÓN Y MULTIMEDIA                  -->
<!-- ======================================================== -->
<div class="modal fade" id="modalSubirDocs" tabindex="-1" aria-labelledby="modalSubirDocsLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content rounded-0 bg-light" style="border: 2px solid #000; box-shadow: 5px 5px 0px 0px rgba(0,0,0,0.1);">
            
            <div class="modal-header rounded-0 bg-white" style="border-bottom: 2px solid #000;">
                <h5 class="modal-title fs-6 fw-bold text-dark" id="modalSubirDocsLabel">Subir documentación</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
            </div>
            
            <div class="modal-body p-4 text-center d-flex flex-column align-items-center">
                
                <form action="${pageContext.request.contextPath}/ActividadesServlet?action=subirEvidencia" method="POST" enctype="multipart/form-data" class="w-100 d-flex flex-column align-items-center">
                    
                    <div class="border border-dark d-flex align-items-center justify-content-center mb-4 bg-white position-relative overflow-hidden" style="width: 140px; height: 90px; cursor: pointer;">
                        <svg class="position-absolute w-100 h-100" style="opacity: 0.2;" preserveAspectRatio="none" viewBox="0 0 100 100">
                            <line x1="0" y1="0" x2="100" y2="100" stroke="black" stroke-width="2" />
                            <line x1="100" y1="0" x2="0" y2="100" stroke="black" stroke-width="2" />
                        </svg>
                        <span class="small fw-medium text-dark bg-white px-1 z-1">Añadir imágenes</span>
                    </div>

                    <div class="d-flex align-items-center gap-2 mb-2 w-100 justify-content-center">
                        <span class="fs-4">🖼️</span>
                        <div class="border border-dark bg-white text-start px-2 py-1" style="width: 220px;">
                            <span class="small fw-medium text-dark">imagen123.jpg</span>
                        </div>
                    </div>

                    <div class="mb-2">
                        <a href="#" class="small text-primary text-decoration-underline fw-medium hover-verde">añadir documentos</a>
                    </div>

                    <div class="d-flex align-items-center gap-2 mb-4 w-100 justify-content-center">
                        <span class="fs-4">📖</span>
                        <div class="border border-dark bg-white text-start px-2 py-1" style="width: 220px;">
                            <span class="small fw-medium text-dark">Evidencias_acta_reunion.docx</span>
                        </div>
                    </div>

                    <div class="d-flex justify-content-center gap-4 w-100 mt-2 px-3">
                        <button type="submit" class="btn btn-light bg-white fw-bold text-dark w-50" style="border: 2px solid #000; box-shadow: 2px 2px 0px 0px rgba(0,0,0,1);">
                            Guardar
                        </button>
                        <button type="button" class="btn btn-light bg-white fw-bold text-dark w-50" data-bs-dismiss="modal" style="border: 2px solid #000; box-shadow: 2px 2px 0px 0px rgba(0,0,0,1);">
                            Cancelar
                        </button>
                    </div>

                </form>

            </div>
        </div>
    </div>
</div>

<!-- INCLUIR FOOTER -->
<jsp:include page="/includes/footer.jsp" />