<%-- 
    Document   : login
    Created on : 8/01/2026, 02:40:48 AM
    Author     : 16003
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="includes/header.jsp"%>

<div class="container" style="margin-top:60px; max-width:450px;">
    <div class="panel panel-default">
        <div class="panel-heading text-center">
            <h3>Iniciar Sesión</h3>
        </div>
        <div class="panel-body">

            <% if(request.getParameter("error") != null){ %>
                <div class="alert alert-danger">
                    Correo o contraseña incorrectos
                </div>
            <% } %>

            <form action="validarLogin.jsp" method="get">
                <div class="form-group">
                    <label>Correo electrónico</label>
                    <input type="email" name="correo" class="form-control" required>
                </div>

                <div class="form-group">
                    <label>Contraseña</label>
                    <input type="password" name="contrasena" class="form-control" required>

                    
                </div>

                <button type="submit" class="btn btn-primary btn-block">
                    Ingresar
                </button>
            </form>

        </div>
    </div>
</div>

<%@include file="includes/footer.jsp"%>

