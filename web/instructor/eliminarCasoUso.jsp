<%-- 
    Document   : eliminarCasoUso
    Created on : 11/01/2026, 11:35:02 PM
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
    int idCaso = Integer.parseInt(idStr);

    try {
        PreparedStatement ps = conexion.prepareStatement(
            "DELETE FROM casos_uso_ia WHERE id_caso = ? AND id_instructor = ?"
        );
        ps.setInt(1, idCaso);
        ps.setInt(2, idInstructor);
        ps.executeUpdate();
        ps.close();

        response.sendRedirect("casosUsoInstructor.jsp?msg=eliminado");
    } catch (Exception e) {
        response.sendRedirect("casosUsoInstructor.jsp?msg=error");
    }
%>