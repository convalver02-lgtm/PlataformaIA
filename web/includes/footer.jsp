<%-- 
    Document   : footer
    Created on : 8/01/2026, 02:40:06 AM
    Author     : 16003
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!-- ===================== FOOTER ===================== -->
<footer id="footer">
    <div class="section">
        <div class="container">
            <div class="row align-items-center">

                <div class="col-md-1 col-xs-12 text-end"></div>

                <div class="col-md-3 col-xs-6">
                    <h3 class="footer-title">Contacto</h3>
                    <ul class="footer-links">
                        <li>
                            <i class="fa fa-envelope-o"></i>
                            aprendizajeia@udl.com
                        </li>
                    </ul>
                </div>

                <div class="col-md-3 col-xs-6">
                    <h3 class="footer-title">Acerca de</h3>
                    <ul class="footer-links">
                        <li><a href="nosotros.jsp">Nosotros</a></li>
                        <li><a href="horarios.jsp">Horarios</a></li>
                        <li>
                            <a href="avisoPrivacidad.jsp"
                               target="_blank">
                                Aviso de Privacidad
                            </a>
                        </li>
                    </ul>
                </div>

                <div class="col-md-2 d-none d-md-block"></div>

                <div class="col-md-3 col-xs-12 text-end">
                    <img src="<%= request.getContextPath() %>/img/logo1.png" width="100" alt="Logo">

                </div>

            </div>
        </div>
    </div>

    <!-- FOOTER INFERIOR -->
    <div id="bottom-footer" class="section">
        <div class="container">
            <div class="row">
                <div class="col-md-12 text-center">
                    <span class="copyright">
                        &copy;
                        <script>document.write(new Date().getFullYear());</script>
                        Todos los derechos reservados
                    </span>
                </div>
            </div>
        </div>
    </div>
</footer>
<!-- ===================== /FOOTER ===================== -->
