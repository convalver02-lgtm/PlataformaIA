<%-- 
    Document   : eliminarTutorial
    Created on : 6/01/2026, 05:21:00 AM
    Author     : 16003
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../conexion.jsp"%>
<%
    String rol = (String) session.getAttribute("rol");
    int idInstructor = (Integer) session.getAttribute("id_usuario");
    if (rol == null || !"INSTRUCTOR".equalsIgnoreCase(rol)) {
        response.sendRedirect("../index.jsp");
        return;
    }

    String idStr = request.getParameter("id");
    if (idStr != null) {
        try {
            int idTutorial = Integer.parseInt(idStr);
            PreparedStatement ps = conexion.prepareStatement(
                "DELETE FROM tutoriales WHERE id_tutorial = ? AND id_instructor = ?"
            );
            ps.setInt(1, idTutorial);
            ps.setInt(2, idInstructor);
            int filas = ps.executeUpdate();
            ps.close();

            // También eliminar de favoritos
            ps = conexion.prepareStatement("DELETE FROM favoritos WHERE id_tutorial = ?");
            ps.setInt(1, idTutorial);
            ps.executeUpdate();
            ps.close();

            response.sendRedirect("panelInstructor.jsp?msg=" + (filas > 0 ? "eliminado" : "error"));
        } catch (Exception e) {
            response.sendRedirect("panelInstructor.jsp?msg=error");
        }
    } else {
        response.sendRedirect("panelInstructor.jsp");
    }
%>