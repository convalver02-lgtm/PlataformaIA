<%-- 
    Document   : guardarCasoUso
    Created on : 11/01/2026, 11:33:50 PM
    Author     : 16003
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="java.sql.*"%>

<%@include file="../conexion.jsp"%>

<%
    // UTF-8
    request.setCharacterEncoding("UTF-8");

    // VALIDAR SESIÓN
    String rol =
    (String) session.getAttribute("rol");

    Integer idInstructor =
    (Integer) session.getAttribute("id_usuario");

    if(rol == null ||
       idInstructor == null ||
       !"INSTRUCTOR".equalsIgnoreCase(rol)){

        response.sendRedirect("../index.jsp");
        return;
    }

    // OBTENER PARÁMETROS
    String titulo =
    request.getParameter("titulo");

    String problema =
    request.getParameter("problema");

    String solucion =
    request.getParameter("solucion");

    String explicacion =
    request.getParameter("explicacion_tecnica");

    String pobre =
    request.getParameter("resultado_pobre");

    String optimizado =
    request.getParameter("resultado_optimizado");

    // VALIDAR NULOS
    if(titulo == null ||
       problema == null ||
       solucion == null ||
       explicacion == null){

        response.sendRedirect(
        "nuevoCasoUso.jsp?error=campos");

        return;
    }

    // LIMPIAR ESPACIOS
    titulo = titulo.trim();
    problema = problema.trim();
    solucion = solucion.trim();
    explicacion = explicacion.trim();

    if(pobre != null){
        pobre = pobre.trim();
    }

    if(optimizado != null){
        optimizado = optimizado.trim();
    }

    // VALIDAR CAMPOS VACÍOS
    if(titulo.isEmpty() ||
       problema.isEmpty() ||
       solucion.isEmpty() ||
       explicacion.isEmpty()){

        response.sendRedirect(
        "nuevoCasoUso.jsp?error=campos");

        return;
    }

    // VALIDAR LONGITUDES
    if(titulo.length() > 200 ||
       problema.length() > 5000 ||
       solucion.length() > 5000 ||
       explicacion.length() > 5000){

        response.sendRedirect(
        "nuevoCasoUso.jsp?error=longitud");

        return;
    }

    if(pobre != null &&
       pobre.length() > 3000){

        response.sendRedirect(
        "nuevoCasoUso.jsp?error=longitud");

        return;
    }

    if(optimizado != null &&
       optimizado.length() > 3000){

        response.sendRedirect(
        "nuevoCasoUso.jsp?error=longitud");

        return;
    }

    // VALIDACIÓN XSS
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

    if(titulo.matches(patronXSS) ||
       problema.matches(patronXSS) ||
       solucion.matches(patronXSS) ||
       explicacion.matches(patronXSS) ||
       (pobre != null &&
        pobre.matches(patronXSS)) ||
       (optimizado != null &&
        optimizado.matches(patronXSS))){

        response.sendRedirect(
        "nuevoCasoUso.jsp?error=xss");

        return;
    }

    PreparedStatement ps = null;

    try{

        // INSERTAR CASO
        String sql =
        "INSERT INTO casos_uso_ia " +
        "(titulo, problema, solucion, " +
        "explicacion_tecnica, " +
        "resultado_pobre, " +
        "resultado_optimizado, " +
        "id_instructor) " +
        "VALUES (?, ?, ?, ?, ?, ?, ?)";

        ps =
        conexion.prepareStatement(sql);

        ps.setString(1, titulo);
        ps.setString(2, problema);
        ps.setString(3, solucion);
        ps.setString(4, explicacion);

        // RESULTADO POBRE
        if(pobre != null &&
           !pobre.isEmpty()){

            ps.setString(5, pobre);

        } else {

            ps.setNull(
            5,
            java.sql.Types.VARCHAR);
        }

        // RESULTADO OPTIMIZADO
        if(optimizado != null &&
           !optimizado.isEmpty()){

            ps.setString(6, optimizado);

        } else {

            ps.setNull(
            6,
            java.sql.Types.VARCHAR);
        }

        // ID INSTRUCTOR
        ps.setInt(7, idInstructor);

        int filas =
        ps.executeUpdate();

        if(filas > 0){

            response.sendRedirect(
            "casosUsoInstructor.jsp?msg=creado");

        } else {

            response.sendRedirect(
            "nuevoCasoUso.jsp?error=general");
        }

    } catch(Exception e){

        response.sendRedirect(
        "nuevoCasoUso.jsp?error=general");

    } finally {

        try{

            if(ps != null){
                ps.close();
            }

        } catch(Exception ex){}
    }
%>