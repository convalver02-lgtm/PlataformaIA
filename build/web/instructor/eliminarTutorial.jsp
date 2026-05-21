<%-- 
    Document   : eliminarTutorial
    Created on : 6/01/2026, 05:21:00 AM
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
        "panelInstructor.jsp?msg=metodo");

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
        "panelInstructor.jsp?msg=id");

        return;
    }

    idStr = idStr.trim();

    // =========================
    // VALIDAR ID NUMÉRICO
    // =========================
    int idTutorial = 0;

    try{

        idTutorial =
        Integer.parseInt(idStr);

        if(idTutorial <= 0){

            response.sendRedirect(
            "panelInstructor.jsp?msg=id");

            return;
        }

    }catch(NumberFormatException e){

        response.sendRedirect(
        "panelInstructor.jsp?msg=id");

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
        "panelInstructor.jsp?msg=confirmar");

        return;
    }

    PreparedStatement psDeleteFav = null;
    PreparedStatement psDeleteTutorial = null;

    try{

        // =========================
        // ELIMINAR FAVORITOS
        // =========================
        psDeleteFav =
        conexion.prepareStatement(
        "DELETE FROM favoritos " +
        "WHERE id_tutorial = ?"
        );

        psDeleteFav.setInt(
        1,
        idTutorial);

        psDeleteFav.executeUpdate();

        // =========================
        // ELIMINAR TUTORIAL
        // SOLO SI PERTENECE
        // AL INSTRUCTOR
        // =========================
        psDeleteTutorial =
        conexion.prepareStatement(
        "DELETE FROM tutoriales " +
        "WHERE id_tutorial = ? " +
        "AND id_instructor = ?"
        );

        psDeleteTutorial.setInt(
        1,
        idTutorial);

        psDeleteTutorial.setInt(
        2,
        idInstructor);

        int filas =
        psDeleteTutorial.executeUpdate();

        // =========================
        // VALIDAR RESULTADO
        // =========================
        if(filas > 0){

            response.sendRedirect(
            "panelInstructor.jsp?msg=eliminado");

        }else{

            response.sendRedirect(
            "panelInstructor.jsp?msg=permiso");
        }

    }catch(SQLException e){

        response.sendRedirect(
        "panelInstructor.jsp?msg=sql");

    }catch(Exception e){

        response.sendRedirect(
        "panelInstructor.jsp?msg=error");

    }finally{

        try{

            if(psDeleteFav != null){
                psDeleteFav.close();
            }

        }catch(Exception e){}

        try{

            if(psDeleteTutorial != null){
                psDeleteTutorial.close();
            }

        }catch(Exception e){}
    }
%>