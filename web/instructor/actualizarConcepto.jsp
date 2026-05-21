<%-- 
    Document   : actualizarConcepto
    Created on : 12/01/2026, 09:47:38 PM
    Author     : 16003
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../conexion.jsp"%>
<%
    // Línea mágica para que los acentos y la ñ se mantengan al editar
    request.setCharacterEncoding("UTF-8");

    String rol = (String) session.getAttribute("rol");
    if (rol == null || !"INSTRUCTOR".equalsIgnoreCase(rol)) {
        response.sendRedirect("../index.jsp");
        return;
    }

    // Leer parámetros del formulario
    String idStr = request.getParameter("id_termino");
    String termino = request.getParameter("termino");
    String definicion = request.getParameter("definicion");

    if (idStr != null && !idStr.trim().isEmpty() &&
        termino != null && !termino.trim().isEmpty() && 
        definicion != null && !definicion.trim().isEmpty()) {
        try {
            int idConcepto = Integer.parseInt(idStr);

            PreparedStatement ps = conexion.prepareStatement(
                "UPDATE diccionario_ia SET termino = ?, definicion = ? WHERE id_termino = ?"
            );
            ps.setString(1, termino.trim());
            ps.setString(2, definicion.trim());
            ps.setInt(3, idConcepto);
            ps.executeUpdate();
            ps.close();

            // Redirigir a la lista con mensaje de éxito
            response.sendRedirect("diccionarioInstructor.jsp?msg=actualizado");
        } catch (Exception e) {
            e.printStackTrace();
            // Si hay error, redirigir al formulario de edición con mensaje
            response.sendRedirect("editarConcepto.jsp?id=" + idStr + "&error=1");
        }
    } else {
        // Si faltan campos, redirigir al formulario de edición
        response.sendRedirect("editarConcepto.jsp?id=" + idStr + "&error=campos");
    }
%>