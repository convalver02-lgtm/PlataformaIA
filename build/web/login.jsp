<%-- 
    Document   : login
    Created on : 8/01/2026, 02:40:48 AM
    Author     : 16003
--%>

<%-- 
    Document   : login
    Created on : 8/01/2026
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="includes/header.jsp"%>

<%
    String correoGuardado = request.getParameter("correo");

    if(correoGuardado == null){
        correoGuardado = "";
    }
%>

<div class="container" style="margin-top:60px; max-width:450px;">
    
    <div class="panel panel-default">

        <div class="panel-heading text-center">
            <h3>Iniciar Sesión</h3>
        </div>

        <div class="panel-body">

            <% if(request.getParameter("error") != null){ %>

                <div class="alert alert-danger">

                    <% if("1".equals(request.getParameter("error"))){ %>
                        Correo o contraseña incorrectos
                    <% } else if("campos".equals(request.getParameter("error"))){ %>
                        Todos los campos son obligatorios
                    <% } else if("longitud".equals(request.getParameter("error"))){ %>
                        La información excede el límite permitido
                    <% } else { %>
                        Error al iniciar sesión
                    <% } %>

                </div>

            <% } %>

            <form action="validarLogin.jsp" method="post">

                <div class="form-group">
                    <label>
                        Correo electrónico <span style="color:red;">*</span>
                    </label>

                    <input type="email"
                           name="correo"
                           class="form-control"
                           required
                           maxlength="100"
                           value="<%= correoGuardado %>">
                </div>

                <div class="form-group">

                    <label>
                        Contraseña <span style="color:red;">*</span>
                    </label>

                    <input type="password"
                           name="contrasena"
                           class="form-control"
                           required
                           maxlength="100">

                    <small class="text-muted">
                        Máximo 6 caracteres
                    </small>

                </div>

                <button type="submit"
                        class="btn btn-primary btn-block">

                    Ingresar

                </button>

            </form>

        </div>
    </div>
</div>

<%@include file="includes/footer.jsp"%>