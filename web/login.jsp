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

<!DOCTYPE html>
<html>
<head>

    <title>Iniciar Sesión</title>

    <style>

        .xss-error{
            color:red;
            font-weight:bold;
            margin-top:8px;
            display:none;
        }

        .input-error{
            border:2px solid red !important;
        }

        .login-container{
            margin-top:60px;
            max-width:450px;
        }

    </style>

</head>

<body>

<div class="container login-container">

    <div class="panel panel-default">

        <div class="panel-heading text-center">
            <h3>Iniciar Sesión</h3>
        </div>

        <div class="panel-body">

            <!-- MENSAJES -->
            <% if(request.getParameter("error") != null){ %>

                <div class="alert alert-danger">

                    <% if("1".equals(request.getParameter("error"))){ %>

                        Correo o contraseña incorrectos

                    <% } else if("campos".equals(request.getParameter("error"))){ %>

                        Todos los campos son obligatorios

                    <% } else if("longitud".equals(request.getParameter("error"))){ %>

                        La información excede el límite permitido

                    <% } else if("xss".equals(request.getParameter("error"))){ %>

                        Se detectaron caracteres peligrosos

                    <% } else { %>

                        Error al iniciar sesión

                    <% } %>

                </div>

            <% } %>

            <% if("registrado".equals(request.getParameter("msg"))){ %>

                <div class="alert alert-success">

                    Registro exitoso. Ahora puedes iniciar sesión.

                </div>

            <% } %>

            <!-- FORMULARIO -->
            <form action="validarLogin.jsp"
                  method="post"
                  id="formLogin">

                <!-- CORREO -->
                <div class="form-group">

                    <label>
                        Correo electrónico
                        <span style="color:red;">*</span>
                    </label>

                    <input type="email"
                           name="correo"
                           id="correo"
                           class="form-control"
                           required
                           maxlength="100"
                           autocomplete="off"
                           value="<%= correoGuardado %>"
                           placeholder="usuario@correo.com">

                    <small class="text-muted">
                        Máximo 100 caracteres
                    </small>

                </div>

                <!-- PASSWORD -->
                <div class="form-group">

                    <label>
                        Contraseña
                        <span style="color:red;">*</span>
                    </label>

                    <input type="password"
                           name="contrasena"
                           id="contrasena"
                           class="form-control"
                           required
                           minlength="6"
                           maxlength="100"
                           autocomplete="off"
                           placeholder="Ingresa tu contraseña">

                    <small class="text-muted">
                        Mínimo 6 caracteres
                    </small>

                </div>

                <!-- MENSAJE XSS -->
                <div id="mensajeXSS"
                     class="xss-error">

                    ⚠ Entrada peligrosa detectada.

                </div>

                <!-- BOTÓN -->
                <button type="submit"
                        class="btn btn-primary btn-block">

                    Ingresar

                </button>

            </form>

        </div>

    </div>

</div>

<script>

document.addEventListener("DOMContentLoaded", function(){

    const correo =
    document.getElementById("correo");

    const contrasena =
    document.getElementById("contrasena");

    const mensaje =
    document.getElementById("mensajeXSS");

    const formulario =
    document.getElementById("formLogin");

    // PATRÓN XSS
    function validarXSS(valor){

        const patron =
        /<script>|<\/script>|<|>|javascript:|onerror=|onload=/gi;

        return patron.test(valor);
    }

    // MOSTRAR ERROR
    function mostrarError(campo){

        campo.classList.add("input-error");

        mensaje.style.display = "block";
    }

    // LIMPIAR ERROR
    function limpiarError(campo){

        campo.classList.remove("input-error");

        if(
            !validarXSS(correo.value) &&
            !validarXSS(contrasena.value)
        ){
            mensaje.style.display = "none";
        }
    }

    // VALIDACIÓN EN TIEMPO REAL
    correo.addEventListener("keyup", function(){

        if(validarXSS(correo.value)){

            mostrarError(correo);

        } else {

            limpiarError(correo);
        }

    });

    contrasena.addEventListener("keyup", function(){

        if(validarXSS(contrasena.value)){

            mostrarError(contrasena);

        } else {

            limpiarError(contrasena);
        }

    });

    // BLOQUEAR ENVÍO
    formulario.addEventListener("submit", function(e){

        if(
            validarXSS(correo.value) ||
            validarXSS(contrasena.value)
        ){

            e.preventDefault();

            mensaje.style.display = "block";

            alert(
            "Entrada peligrosa detectada."
            );
        }

    });

});

</script>

</body>
</html>