<%-- 
    Document   : actualizarCasoUso
    Created on : 11/01/2026, 11:34:44 PM
    Author     : 16003
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../conexion.jsp"%>
<%
    // ¡La línea mágica ANTES de cualquier request.getParameter!
    request.setCharacterEncoding("UTF-8");

    String rol = (String) session.getAttribute("rol");
    int idInstructor = (Integer) session.getAttribute("id_usuario");
    if (rol == null || !"INSTRUCTOR".equalsIgnoreCase(rol)) {
        response.sendRedirect("../index.jsp");
        return;
    }

    String idStr = request.getParameter("id_caso");
    int idCaso = Integer.parseInt(idStr);

    // Ahora sí leemos los parámetros (ya en UTF-8)
    String titulo = request.getParameter("titulo");
    String problema = request.getParameter("problema");
    String solucion = request.getParameter("solucion");
    String explicacion = request.getParameter("explicacion_tecnica");
    String pobre = request.getParameter("resultado_pobre");
    String optimizado = request.getParameter("resultado_optimizado");

    if (titulo != null && problema != null && solucion != null && explicacion != null) {
        try {
            PreparedStatement ps = conexion.prepareStatement(
                "UPDATE casos_uso_ia SET titulo = ?, problema = ?, solucion = ?, explicacion_tecnica = ?, resultado_pobre = ?, resultado_optimizado = ? " +
                "WHERE id_caso = ? AND id_instructor = ?"
            );
            ps.setString(1, titulo.trim());
            ps.setString(2, problema.trim());
            ps.setString(3, solucion.trim());
            ps.setString(4, explicacion.trim());
            ps.setString(5, pobre != null && !pobre.trim().isEmpty() ? pobre.trim() : null);
            ps.setString(6, optimizado != null && !optimizado.trim().isEmpty() ? optimizado.trim() : null);
            ps.setInt(7, idCaso);
            ps.setInt(8, idInstructor);
            ps.executeUpdate();
            ps.close();

            response.sendRedirect("casosUsoInstructor.jsp?msg=actualizado");
        } catch (Exception e) {
            response.sendRedirect("editarCasoUso.jsp?id=" + idCaso + "&error=1");
        }
    } else {
        response.sendRedirect("editarCasoUso.jsp?id=" + idCaso + "&error=campos");
    }
%>