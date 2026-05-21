<%-- 
    Document   : guardarConcepto
    Created on : 12/01/2026, 09:38:39 PM
    Author     : 16003
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="java.sql.*"%>

<%@include file="../conexion.jsp"%>

<%
    request.setCharacterEncoding("UTF-8");

    // VALIDAR SESIÓN
    String rol = (String) session.getAttribute("rol");

    if(rol == null ||
       !"INSTRUCTOR".equalsIgnoreCase(rol)){

        response.sendRedirect("../index.jsp");
        return;
    }

    // OBTENER DATOS
    String termino =
    request.getParameter("termino");

    String definicion =
    request.getParameter("definicion");

    // VALIDAR NULOS
    if(termino == null ||
       definicion == null){

        response.sendRedirect(
        "nuevoConcepto.jsp?error=campos");

        return;
    }

    // LIMPIAR ESPACIOS
    termino = termino.trim();
    definicion = definicion.trim();

    // VALIDAR VACÍOS
    if(termino.isEmpty() ||
       definicion.isEmpty()){

        response.sendRedirect(
        "nuevoConcepto.jsp?error=campos");

        return;
    }

    // VALIDAR LONGITUDES
    if(termino.length() > 150 ||
       definicion.length() > 5000){

        response.sendRedirect(
        "nuevoConcepto.jsp?error=longitud");

        return;
    }

    // VALIDAR XSS
    String patronXSS =
    "(?i).*(" +
    "<script>|</script>|" +
    "<|>|" +
    "javascript:|" +
    "onload=|" +
    "onerror=|" +
    "alert\\(|" +
    "document\\.cookie" +
    ").*";

    if(termino.matches(patronXSS) ||
       definicion.matches(patronXSS)){

        response.sendRedirect(
        "nuevoConcepto.jsp?error=xss");

        return;
    }

    PreparedStatement ps = null;

    try{

        String sql =
        "INSERT INTO diccionario_ia " +
        "(termino, definicion) " +
        "VALUES (?, ?)";

        ps =
        conexion.prepareStatement(sql);

        ps.setString(1, termino);
        ps.setString(2, definicion);

        int filas =
        ps.executeUpdate();

        if(filas > 0){

            response.sendRedirect(
            "diccionarioInstructor.jsp?msg=creado");

        } else {

            response.sendRedirect(
            "nuevoConcepto.jsp?error=general");
        }

    } catch(Exception e){

        response.sendRedirect(
        "nuevoConcepto.jsp?error=general");

    } finally {

        try{
            if(ps != null){
                ps.close();
            }
        } catch(Exception ex){}
    }
%>