<%-- 
    Document   : eliminarConcepto
    Created on : 12/01/2026, 08:58:48 PM
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

    // =========================
    // VALIDAR MÉTODO POST
    // EVITA BORRADO POR URL
    // =========================
    if(!"POST".equalsIgnoreCase(
        request.getMethod())){

        response.sendRedirect(
        "diccionarioInstructor.jsp?msg=metodo");

        return;
    }

    // =========================
    // OBTENER ID
    // =========================
    String idStr =
    request.getParameter("id");

    if(idStr == null ||
       idStr.trim().isEmpty()){

        response.sendRedirect(
        "diccionarioInstructor.jsp?msg=id");

        return;
    }

    idStr = idStr.trim();

    // =========================
    // VALIDAR ID NUMÉRICO
    // =========================
    int idConcepto = 0;

    try{

        idConcepto =
        Integer.parseInt(idStr);

        if(idConcepto <= 0){

            response.sendRedirect(
            "diccionarioInstructor.jsp?msg=id");

            return;
        }

    }catch(NumberFormatException e){

        response.sendRedirect(
        "diccionarioInstructor.jsp?msg=id");

        return;
    }

    // =========================
    // VALIDAR CONFIRMACIÓN
    // EVITA BORRADOS ACCIDENTALES
    // =========================
    String confirmar =
    request.getParameter("confirmar");

    if(confirmar == null ||
       !"SI".equals(confirmar)){

        response.sendRedirect(
        "diccionarioInstructor.jsp?msg=confirmar");

        return;
    }

    PreparedStatement ps = null;

    try{

        // =========================
        // ELIMINAR CON PreparedStatement
        // EVITA SQL INJECTION
        // =========================
        ps = conexion.prepareStatement(
        "DELETE FROM diccionario_ia " +
        "WHERE id_termino = ?"
        );

        ps.setInt(1, idConcepto);

        int filas =
        ps.executeUpdate();

        // =========================
        // VALIDAR RESULTADO
        // =========================
        if(filas > 0){

            response.sendRedirect(
            "diccionarioInstructor.jsp?msg=eliminado");

        }else{

            response.sendRedirect(
            "diccionarioInstructor.jsp?msg=error");
        }

    }catch(SQLException e){

        response.sendRedirect(
        "diccionarioInstructor.jsp?msg=sql");

    }catch(Exception e){

        response.sendRedirect(
        "diccionarioInstructor.jsp?msg=error");

    }finally{

        try{

            if(ps != null){
                ps.close();
            }

        }catch(Exception e){}
    }
%>