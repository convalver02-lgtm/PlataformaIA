<%-- 
    Document   : nuevoCasoUso
    Created on : 11/01/2026, 11:53:47 PM
    Author     : 16003
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../conexion.jsp"%>

<%
    String rol = (String) session.getAttribute("rol");
    String nombreUsuario = (String) session.getAttribute("usuario");

    if (rol == null || !"INSTRUCTOR".equalsIgnoreCase(rol)) {
        response.sendRedirect("../index.jsp");
        return;
    }

    String error = request.getParameter("error");
%>

<!DOCTYPE html>
<html>
<head>

    <title>Nuevo Caso de Uso IA</title>

    <meta charset="UTF-8">

    <link rel="stylesheet" href="../css/bootstrap.min.css">
    <link rel="stylesheet" href="../css/font-awesome.min.css">
    <link rel="stylesheet" href="../css/style.css">

    <style>

        .dashboard-container{
            margin-top:80px;
            margin-bottom:120px;
        }

        .form-container{
            background:white;
            padding:50px;
            border-radius:16px;
            box-shadow:0 6px 20px rgba(0,0,0,0.1);
        }

        textarea.form-control{
            resize:vertical;
        }

        .btn-guardar{
            background:#006299;
            color:white;
            padding:12px 40px;
            border-radius:40px;
        }

        .xss-error{
            color:red;
            font-weight:bold;
            display:none;
            margin-top:10px;
        }

        .input-error{
            border:2px solid red !important;
        }

    </style>

</head>

<body>

<%@include file="../includes/header.jsp"%>

<div class="container mt-4">

    <% if(error != null){ %>

        <div class="alert alert-danger">

            <% if("campos".equals(error)){ %>

                Completa todos los campos obligatorios.

            <% } else if("xss".equals(error)){ %>

                Se detectaron caracteres peligrosos.

            <% } else if("longitud".equals(error)){ %>

                Uno o más campos exceden el límite permitido.

            <% } else { %>

                Error al guardar el caso.

            <% } %>

        </div>

    <% } %>

</div>

<div class="container dashboard-container">

    <div class="form-container">

        <h2>
            Crear Nuevo Caso de Uso IA
        </h2>

        <form action="guardarCasoUso.jsp"
              method="post"
              id="formCaso">

            <div class="form-group">

                <label>
                    Título
                    <span style="color:red;">*</span>
                </label>

                <input type="text"
                       name="titulo"
                       id="titulo"
                       class="form-control"
                       required
                       minlength="5"
                       maxlength="150">

            </div>

            <div class="form-group mt-4">

                <label>
                    Problema Real
                    <span style="color:red;">*</span>
                </label>

                <textarea name="problema"
                          id="problema"
                          class="form-control"
                          required
                          maxlength="3000"
                          rows="5"></textarea>

            </div>

            <div class="form-group mt-4">

                <label>
                    Solución IA
                    <span style="color:red;">*</span>
                </label>

                <textarea name="solucion"
                          id="solucion"
                          class="form-control"
                          required
                          maxlength="3000"
                          rows="5"></textarea>

            </div>

            <div class="form-group mt-4">

                <label>
                    Explicación Técnica
                    <span style="color:red;">*</span>
                </label>

                <textarea name="explicacion_tecnica"
                          id="explicacion_tecnica"
                          class="form-control"
                          required
                          maxlength="3000"
                          rows="5"></textarea>

            </div>

            <div class="form-group mt-4">

                <label>
                    Resultado Pobre
                </label>

                <textarea name="resultado_pobre"
                          id="resultado_pobre"
                          class="form-control"
                          maxlength="2000"
                          rows="3"></textarea>

            </div>

            <div class="form-group mt-4">

                <label>
                    Resultado Optimizado
                </label>

                <textarea name="resultado_optimizado"
                          id="resultado_optimizado"
                          class="form-control"
                          maxlength="2000"
                          rows="3"></textarea>

            </div>

            <div id="mensajeXSS"
                 class="xss-error">

                ⚠ Entrada peligrosa detectada.

            </div>

            <div class="text-center mt-5">

                <button type="submit"
                        class="btn btn-guardar">

                    Guardar Caso

                </button>

            </div>

        </form>

    </div>

</div>

<%@include file="../includes/footer.jsp"%>

<script>

document.addEventListener("DOMContentLoaded", function(){

    const campos =
    document.querySelectorAll("input, textarea");

    const mensaje =
    document.getElementById("mensajeXSS");

    const formulario =
    document.getElementById("formCaso");

    function validarXSS(valor){

        const patron =
        /<script|<\/script>|<|>|javascript:|onerror=|onload=/gi;

        return patron.test(valor);
    }

    campos.forEach(function(campo){

        campo.addEventListener("keyup", function(){

            if(validarXSS(campo.value)){

                campo.classList.add("input-error");
                mensaje.style.display = "block";

            } else {

                campo.classList.remove("input-error");

            }

        });

    });

    formulario.addEventListener("submit", function(e){

        let peligro = false;

        campos.forEach(function(campo){

            if(validarXSS(campo.value)){

                campo.classList.add("input-error");
                peligro = true;

            }

        });

        if(peligro){

            e.preventDefault();

            mensaje.style.display = "block";

            alert("Se detectó contenido peligroso.");

        }

    });

});

</script>

</body>
</html>