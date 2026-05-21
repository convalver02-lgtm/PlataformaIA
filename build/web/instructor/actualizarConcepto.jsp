<%-- 
    Document   : actualizarConcepto
    Created on : 12/01/2026, 09:47:38 PM
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

    if(rol == null ||
       !"INSTRUCTOR".equalsIgnoreCase(rol)){

        response.sendRedirect("../index.jsp");
        return;
    }

    // =========================
    // OBTENER PARÁMETROS
    // =========================

    String idStr =
    request.getParameter("id_termino");

    String termino =
    request.getParameter("termino");

    String definicion =
    request.getParameter("definicion");

    // =========================
    // VALIDAR NULOS
    // =========================

    if(idStr == null ||
       termino == null ||
       definicion == null){

        response.sendRedirect(
        "diccionarioInstructor.jsp");

        return;
    }

    // =========================
    // LIMPIAR ESPACIOS
    // =========================

    idStr =
    idStr.trim();

    termino =
    termino.trim();

    definicion =
    definicion.trim();

    // =========================
    // VALIDAR VACÍOS
    // =========================

    if(idStr.isEmpty() ||
       termino.isEmpty() ||
       definicion.isEmpty()){

        response.sendRedirect(
        "editarConcepto.jsp?id=" +
        idStr +
        "&error=campos");

        return;
    }

    // =========================
    // VALIDAR ID
    // =========================

    int idConcepto = 0;

    try{

        idConcepto =
        Integer.parseInt(idStr);

        if(idConcepto <= 0){

            response.sendRedirect(
            "diccionarioInstructor.jsp?msg=error");

            return;
        }

    } catch(Exception e){

        response.sendRedirect(
        "diccionarioInstructor.jsp?msg=error");

        return;
    }

    // =========================
    // VALIDAR LONGITUDES
    // =========================

    if(termino.length() > 150 ||
       definicion.length() > 5000){

        response.sendRedirect(
        "editarConcepto.jsp?id=" +
        idConcepto +
        "&error=longitud");

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

    if(termino.matches(patronXSS) ||
       definicion.matches(patronXSS)){

        response.sendRedirect(
        "editarConcepto.jsp?id=" +
        idConcepto +
        "&error=xss");

        return;
    }

    // =========================
    // ACTUALIZAR
    // =========================

    PreparedStatement ps = null;

    try{

        ps =
        conexion.prepareStatement(
        "UPDATE diccionario_ia " +
        "SET termino=?, " +
        "definicion=? " +
        "WHERE id_termino=?"
        );

        ps.setString(1, termino);

        ps.setString(2, definicion);

        ps.setInt(3, idConcepto);

        int filas =
        ps.executeUpdate();

        ps.close();

        // =========================
        // VALIDAR RESULTADO
        // =========================

        if(filas > 0){

            response.sendRedirect(
            "diccionarioInstructor.jsp?msg=actualizado");

        } else {

            response.sendRedirect(
            "editarConcepto.jsp?id=" +
            idConcepto +
            "&error=general");
        }

    } catch(Exception e){

        if(ps != null){

            try{

                ps.close();

            } catch(Exception ex){}
        }

        response.sendRedirect(
        "editarConcepto.jsp?id=" +
        idConcepto +
        "&error=general");
    }
%>