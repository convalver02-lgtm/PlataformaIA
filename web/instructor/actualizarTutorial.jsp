<%-- 
    Document   : actualizarTutorial
    Created on : 6/01/2026, 05:20:15 AM
    Author     : 16003
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="java.sql.*"%>

<%@include file="../conexion.jsp"%>

<%
    request.setCharacterEncoding("UTF-8");

    // =========================
    // VALIDAR SESIÓN
    // =========================

    String rol =
    (String) session.getAttribute("rol");

    Integer idInstructorObj =
    (Integer) session.getAttribute("id_usuario");

    if(rol == null ||
       idInstructorObj == null ||
       !"INSTRUCTOR".equalsIgnoreCase(rol)){

        response.sendRedirect("../index.jsp");
        return;
    }

    int idInstructor =
    idInstructorObj;

    // =========================
    // OBTENER PARÁMETROS
    // =========================

    String idTutorialStr =
    request.getParameter("id_tutorial");

    String titulo =
    request.getParameter("titulo");

    String descripcion =
    request.getParameter("descripcion");

    String nivel =
    request.getParameter("nivel");

    String contenido =
    request.getParameter("contenido");

    String videoUrl =
    request.getParameter("video_url");

    // =========================
    // VALIDAR NULOS
    // =========================

    if(idTutorialStr == null ||
       titulo == null ||
       descripcion == null ||
       nivel == null ||
       contenido == null){

        response.sendRedirect(
        "editarTutorial.jsp?id=" +
        idTutorialStr +
        "&error=campos");

        return;
    }

    // =========================
    // LIMPIAR ESPACIOS
    // =========================

    idTutorialStr =
    idTutorialStr.trim();

    titulo =
    titulo.trim();

    descripcion =
    descripcion.trim();

    nivel =
    nivel.trim();

    contenido =
    contenido.trim();

    if(videoUrl != null){

        videoUrl =
        videoUrl.trim();
    }

    // =========================
    // VALIDAR VACÍOS
    // =========================

    if(idTutorialStr.isEmpty() ||
       titulo.isEmpty() ||
       descripcion.isEmpty() ||
       nivel.isEmpty() ||
       contenido.isEmpty()){

        response.sendRedirect(
        "editarTutorial.jsp?id=" +
        idTutorialStr +
        "&error=campos");

        return;
    }

    // =========================
    // VALIDAR ID
    // =========================

    int idTutorial = 0;

    try{

        idTutorial =
        Integer.parseInt(idTutorialStr);

        if(idTutorial <= 0){

            response.sendRedirect(
            "panelInstructor.jsp?msg=error");

            return;
        }

    } catch(Exception e){

        response.sendRedirect(
        "panelInstructor.jsp?msg=error");

        return;
    }

    // =========================
    // VALIDAR LONGITUDES
    // =========================

    if(titulo.length() > 150 ||
       descripcion.length() > 500 ||
       contenido.length() > 15000 ||
       (videoUrl != null &&
        videoUrl.length() > 300)){

        response.sendRedirect(
        "editarTutorial.jsp?id=" +
        idTutorial +
        "&error=longitud");

        return;
    }

    // =========================
    // VALIDAR NIVEL
    // =========================

    if(!"Principiante".equals(nivel) &&
       !"Intermedio".equals(nivel) &&
       !"Avanzado".equals(nivel)){

        response.sendRedirect(
        "editarTutorial.jsp?id=" +
        idTutorial +
        "&error=nivel");

        return;
    }

    // =========================
    // VALIDAR XSS
    // =========================

    String patronXSS =
    "(?i).*(" +
    "<script|" +
    "</script>|" +
    "javascript:|" +
    "onload=|" +
    "onerror=|" +
    "<|>" +
    ").*";

    if(titulo.matches(patronXSS) ||
       descripcion.matches(patronXSS) ||
       contenido.matches(patronXSS) ||
       (videoUrl != null &&
        videoUrl.matches(patronXSS))){

        response.sendRedirect(
        "editarTutorial.jsp?id=" +
        idTutorial +
        "&error=xss");

        return;
    }

    // =========================
    // VALIDAR URL VIDEO
    // =========================

    if(videoUrl != null &&
       !videoUrl.isEmpty()){

        boolean urlValida =
        videoUrl.startsWith(
        "https://www.youtube.com/embed/")
        ||
        videoUrl.startsWith(
        "https://youtube.com/embed/")
        ||
        videoUrl.startsWith(
        "https://youtu.be/");

        if(!urlValida){

            response.sendRedirect(
            "editarTutorial.jsp?id=" +
            idTutorial +
            "&error=video");

            return;
        }

    } else {

        videoUrl = null;
    }

    // =========================
    // ACTUALIZAR
    // =========================

    PreparedStatement ps = null;

    try{

        ps =
        conexion.prepareStatement(
        "UPDATE tutoriales " +
        "SET titulo=?, " +
        "descripcion=?, " +
        "nivel=?, " +
        "contenido=?, " +
        "video_url=? " +
        "WHERE id_tutorial=? " +
        "AND id_instructor=?"
        );

        ps.setString(1, titulo);
        ps.setString(2, descripcion);
        ps.setString(3, nivel);
        ps.setString(4, contenido);

        if(videoUrl != null){

            ps.setString(5, videoUrl);

        } else {

            ps.setNull(
            5,
            java.sql.Types.VARCHAR);
        }

        ps.setInt(6, idTutorial);

        ps.setInt(7, idInstructor);

        int filas =
        ps.executeUpdate();

        ps.close();

        if(filas > 0){

            response.sendRedirect(
            "panelInstructor.jsp?msg=actualizado");

        } else {

            response.sendRedirect(
            "panelInstructor.jsp?msg=error");
        }

    } catch(Exception e){

        if(ps != null){

            try{

                ps.close();

            } catch(Exception ex){}
        }

        response.sendRedirect(
        "editarTutorial.jsp?id=" +
        idTutorial +
        "&error=general");
    }
%>