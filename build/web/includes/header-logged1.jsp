<%-- 
    Document   : header-logged
    Created on : 8/01/2026, 01:01:16 PM
    Author     : 16003
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<header>
    <div id="header" style="background-color: #006299; color: white; padding: 20px 0;">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-md-2">
                    <a href="../index.jsp">
                        <img src="../img/logo.png" alt="Logo" height="60">
                    </a>
                </div>
                <div class="col-md-8 text-center">
                    <h2 style="color: white; margin: 0;">Plataforma Educativa de Inteligencia Artificial</h2>
                </div>
                <div class="col-md-2 text-right">
                    <span style="color: white;">
                        <i class="fa fa-user-circle fa-lg"></i>
                        <%= session.getAttribute("usuario") != null ? session.getAttribute("usuario") : "Usuario" %>
                    </span>
                    <br>
                    <a href="../cerrarSesion.jsp" class="primary-btn" style="padding: 8px 20px; font-size: 14px; margin-top: 10px; display: inline-block;">
                        Cerrar Sesión
                    </a>
                </div>
            </div>
        </div>
    </div>
</header>
