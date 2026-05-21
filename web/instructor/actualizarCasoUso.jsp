<%-- 
    Document   : actualizarCasoUso
    Created on : 11/01/2026, 11:34:44 PM
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
    String rol = (String) session.getAttribute("rol");

    Integer idInstructorObj =
    (Integer) session.getAttribute("id_usuario");

    if (rol == null ||
        idInstructorObj == null ||
        !"INSTRUCTOR".equalsIgnoreCase(rol)) {

        response.sendRedirect("../index.jsp");
        return;
    }

    int idInstructor = idInstructorObj;

    // =========================
    // OBTENER PARÁMETROS
    // =========================
    String idStr =
    request.getParameter("id_caso");

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

    // =========================
    // VALIDAR NULOS
    // =========================
    if(idStr == null ||
       titulo == null ||
       problema == null ||
       solucion == null ||
       explicacion == null){

        response.sendRedirect(
        "editarCasoUso.jsp?id=" +
        (idStr != null ? idStr : "") +
        "&error=campos");

        return;
    }

    // =========================
    // LIMPIAR ESPACIOS
    // =========================
    idStr = idStr.trim();
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

    // =========================
    // VALIDAR CAMPOS VACÍOS
    // =========================
    if(idStr.isEmpty() ||
       titulo.isEmpty() ||
       problema.isEmpty() ||
       solucion.isEmpty() ||
       explicacion.isEmpty()){

        response.sendRedirect(
        "editarCasoUso.jsp?id=" +
        idStr +
        "&error=campos");

        return;
    }

    // =========================
    // VALIDAR ID NUMÉRICO
    // =========================
    int idCaso = 0;

    try{

        idCaso =
        Integer.parseInt(idStr);

        if(idCaso <= 0){

            response.sendRedirect(
            "casosUsoInstructor.jsp?msg=error");

            return;
        }

    }catch(NumberFormatException e){

        response.sendRedirect(
        "casosUsoInstructor.jsp?msg=error");

        return;
    }

    // =========================
    // VALIDAR LONGITUDES
    // =========================
    if(titulo.length() > 150 ||
       problema.length() > 3000 ||
       solucion.length() > 3000 ||
       explicacion.length() > 3000 ||
       (pobre != null &&
        pobre.length() > 3000) ||
       (optimizado != null &&
        optimizado.length() > 3000)){

        response.sendRedirect(
        "editarCasoUso.jsp?id=" +
        idCaso +
        "&error=longitud");

        return;
    }

    // =========================
    // PROTECCIÓN BÁSICA XSS
    // =========================
    String contenidoCompleto =
        titulo +
        problema +
        solucion +
        explicacion +
        (pobre != null ? pobre : "") +
        (optimizado != null ? optimizado : "");

    if(contenidoCompleto.contains("<script") ||
       contenidoCompleto.contains("</script>") ||
       contenidoCompleto.contains("<") ||
       contenidoCompleto.contains(">")){

        response.sendRedirect(
        "editarCasoUso.jsp?id=" +
        idCaso +
        "&error=xss");

        return;
    }

    PreparedStatement ps = null;

    try{

        // =========================
        // ACTUALIZAR CASO
        // =========================
        ps = conexion.prepareStatement(
        "UPDATE casos_uso_ia " +
        "SET titulo = ?, " +
        "problema = ?, " +
        "solucion = ?, " +
        "explicacion_tecnica = ?, " +
        "resultado_pobre = ?, " +
        "resultado_optimizado = ? " +
        "WHERE id_caso = ? " +
        "AND id_instructor = ?"
        );

        ps.setString(1, titulo);
        ps.setString(2, problema);
        ps.setString(3, solucion);
        ps.setString(4, explicacion);

        // RESULTADO POBRE
        if(pobre != null &&
           !pobre.isEmpty()){

            ps.setString(5, pobre);

        }else{

            ps.setNull(
            5,
            java.sql.Types.VARCHAR);
        }

        // RESULTADO OPTIMIZADO
        if(optimizado != null &&
           !optimizado.isEmpty()){

            ps.setString(6, optimizado);

        }else{

            ps.setNull(
            6,
            java.sql.Types.VARCHAR);
        }

        ps.setInt(7, idCaso);
        ps.setInt(8, idInstructor);

        int filas =
        ps.executeUpdate();

        // =========================
        // VALIDAR ACTUALIZACIÓN
        // =========================
        if(filas > 0){

            response.sendRedirect(
            "casosUsoInstructor.jsp?msg=actualizado");

        }else{

            response.sendRedirect(
            "editarCasoUso.jsp?id=" +
            idCaso +
            "&error=permiso");
        }

    }catch(SQLException e){

        response.sendRedirect(
        "editarCasoUso.jsp?id=" +
        idCaso +
        "&error=sql");

    }catch(Exception e){

        response.sendRedirect(
        "editarCasoUso.jsp?id=" +
        idCaso +
        "&error=general");

    }finally{

        try{

            if(ps != null){
                ps.close();
            }

        }catch(Exception e){}
    }
%>