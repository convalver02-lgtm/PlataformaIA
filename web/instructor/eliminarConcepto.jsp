<%-- 
    Document   : eliminarConcepto
    Created on : 12/01/2026, 08:58:48 PM
    Author     : 16003
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../conexion.jsp"%>
<%
    String rol = (String) session.getAttribute("rol");
    if (rol == null || !"INSTRUCTOR".equalsIgnoreCase(rol)) {
        response.sendRedirect("../index.jsp");
        return;
    }

    // Obtener id del concepto a eliminar
    String idStr = request.getParameter("id");
    if (idStr != null && !idStr.trim().isEmpty()) {
        try {
            int idConcepto = Integer.parseInt(idStr);

            PreparedStatement ps = conexion.prepareStatement(
                "DELETE FROM diccionario_ia WHERE id_termino = ?"
            );
            ps.setInt(1, idConcepto);
            int filas = ps.executeUpdate();
            ps.close();

            // Redirigir con mensaje de éxito si se eliminó algo
            if (filas > 0) {
                response.sendRedirect("diccionarioInstructor.jsp?msg=eliminado");
            } else {
                response.sendRedirect("diccionarioInstructor.jsp?msg=error");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("diccionarioInstructor.jsp?msg=error");
        }
    } else {
        response.sendRedirect("diccionarioInstructor.jsp");
    }
%>
