<%-- 
    Document   : eliminarCasoUso
    Created on : 11/01/2026, 11:35:02 PM
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
    // VALIDAR MÉTODO POST
    // EVITA BORRADO POR URL
    // =========================
    if(!"POST".equalsIgnoreCase(
        request.getMethod())){

        response.sendRedirect(
        "casosUsoInstructor.jsp?msg=metodo");

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
        "casosUsoInstructor.jsp?msg=id");

        return;
    }

    idStr = idStr.trim();

    // =========================
    // VALIDAR ID NUMÉRICO
    // =========================
    int idCaso = 0;

    try{

        idCaso =
        Integer.parseInt(idStr);

        if(idCaso <= 0){

            response.sendRedirect(
            "casosUsoInstructor.jsp?msg=id");

            return;
        }

    }catch(NumberFormatException e){

        response.sendRedirect(
        "casosUsoInstructor.jsp?msg=id");

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
        "casosUsoInstructor.jsp?msg=confirmar");

        return;
    }

    PreparedStatement ps = null;

    try{

        // =========================
        // ELIMINAR SOLO SI
        // PERTENECE AL INSTRUCTOR
        // =========================
        ps = conexion.prepareStatement(
        "DELETE FROM casos_uso_ia " +
        "WHERE id_caso = ? " +
        "AND id_instructor = ?"
        );

        ps.setInt(1, idCaso);

        ps.setInt(2, idInstructor);

        int filas =
        ps.executeUpdate();

        // =========================
        // VALIDAR RESULTADO
        // =========================
        if(filas > 0){

            response.sendRedirect(
            "casosUsoInstructor.jsp?msg=eliminado");

        }else{

            response.sendRedirect(
            "casosUsoInstructor.jsp?msg=permiso");
        }

    }catch(SQLException e){

        response.sendRedirect(
        "casosUsoInstructor.jsp?msg=sql");

    }catch(Exception e){

        response.sendRedirect(
        "casosUsoInstructor.jsp?msg=error");

    }finally{

        try{

            if(ps != null){
                ps.close();
            }

        }catch(Exception e){}
    }
%>