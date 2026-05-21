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
    String correoGuardado = request.getParameter("correo") != null
            ? request.getParameter("correo")
            : "";
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
                    <% } else if("rol".equals(request.getParameter("error"))){ %>
                        El usuario no tiene un rol válido
                    <% } else if("vacio".equals(request.getParameter("error"))){ %>
                        Todos los campos son obligatorios
                    <% } else { %>
                        Ocurrió un error inesperado
                    <% } %>

                </div>

            <% } %>

            <% if(request.getParameter("msg") != null){ %>

                <div class="alert alert-success">
                    Registro exitoso. Ya puedes iniciar sesión.
                </div>

            <% } %>

            <!-- FORMULARIO -->
            <form action="validarLogin.jsp" method="post" autocomplete="on">

                <!-- CORREO -->
                <div class="form-group">

                    <label>
                        Correo electrónico
                        <span style="color:red;">*</span>
                    </label>

                    <input
                        type="email"
                        name="correo"
                        class="form-control"
                        required
                        maxlength="100"
                        autocomplete="email"
                        tabindex="1"
                        autofocus
                        value="<%= correoGuardado %>"
                        placeholder="Ejemplo: usuario@correo.com"
                    >

                    <small class="text-muted">
                        Ingresa el correo registrado en la plataforma
                    </small>

                </div>

                <!-- CONTRASEÑA -->
                <div class="form-group">

                    <label>
                        Contraseña
                        <span style="color:red;">*</span>
                    </label>

                    <input
                        type="password"
                        name="contrasena"
                        class="form-control"
                        required
                        maxlength="100"
                        minlength="6"
                        autocomplete="current-password"
                        tabindex="2"
                        placeholder="Mínimo 6 caracteres"
                    >

                    <small class="text-muted">
                        La contraseña distingue mayúsculas y minúsculas
                    </small>

                </div>

                <!-- BOTÓN -->
                <button
                    type="submit"
                    class="btn btn-primary btn-block"
                    tabindex="3">

                    Ingresar

                </button>

            </form>

        </div>
    </div>
</div>

<%@include file="includes/footer.jsp"%>