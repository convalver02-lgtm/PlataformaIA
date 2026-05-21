<%-- 
    Document   : eliminarUsuario
    Created on : 21/05/2026, 05:47:40 PM
    Author     : 16003
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="java.sql.*"%>

<%@include file="../conexion.jsp"%>

<%
    // =========================
    // VALIDAR SESIÓN ADMIN
    // =========================
    String rol = (String) session.getAttribute("rol");

    Integer idAdminObj =
    (Integer) session.getAttribute("id_usuario");

    if(
        rol == null ||
        !"ADMIN".equalsIgnoreCase(rol) ||
        idAdminObj == null
    ){

        response.sendRedirect("../index.jsp");
        return;
    }

    int idAdmin = idAdminObj;

    // =========================
    // VALIDAR MÉTODO POST
    // =========================
    if(!"POST".equalsIgnoreCase(request.getMethod())){

        response.sendRedirect(
        "panelAdmin.jsp?msg=metodo_invalido");

        return;
    }

    // =========================
    // VALIDAR ID
    // =========================
    String idStr =
    request.getParameter("id_usuario");

    if(
        idStr == null ||
        idStr.trim().isEmpty()
    ){

        response.sendRedirect(
        "panelAdmin.jsp?msg=id_invalido");

        return;
    }

    int idUsuario = 0;

    try{

        idUsuario =
        Integer.parseInt(idStr);

        if(idUsuario <= 0){

            response.sendRedirect(
            "panelAdmin.jsp?msg=id_invalido");

            return;
        }

    } catch(NumberFormatException e){

        response.sendRedirect(
        "panelAdmin.jsp?msg=id_invalido");

        return;
    }

    // =========================
    // EVITAR AUTOELIMINACIÓN
    // =========================
    if(idUsuario == idAdmin){

        response.sendRedirect(
        "panelAdmin.jsp?msg=no_autEliminar");

        return;
    }

    PreparedStatement psVerificar = null;
    PreparedStatement psEliminarFavoritos = null;
    PreparedStatement psEliminarVistas = null;
    PreparedStatement psEliminarUsuario = null;

    ResultSet rs = null;

    try{

        // =========================
        // VERIFICAR EXISTENCIA
        // =========================
        psVerificar =
        conexion.prepareStatement(
        "SELECT id_usuario FROM usuarios WHERE id_usuario = ?"
        );

        psVerificar.setInt(1, idUsuario);

        rs = psVerificar.executeQuery();

        if(!rs.next()){

            response.sendRedirect(
            "panelAdmin.jsp?msg=no_existe");

            return;
        }

        rs.close();
        psVerificar.close();

        // =========================
        // ELIMINAR RELACIONES
        // =========================

        // Favoritos
        psEliminarFavoritos =
        conexion.prepareStatement(
        "DELETE FROM favoritos WHERE id_usuario = ?"
        );

        psEliminarFavoritos.setInt(1, idUsuario);

        psEliminarFavoritos.executeUpdate();

        // Vistas
        psEliminarVistas =
        conexion.prepareStatement(
        "DELETE FROM vistas_tutoriales WHERE id_usuario = ?"
        );

        psEliminarVistas.setInt(1, idUsuario);

        psEliminarVistas.executeUpdate();

        // =========================
        // ELIMINAR USUARIO
        // =========================
        psEliminarUsuario =
        conexion.prepareStatement(
        "DELETE FROM usuarios WHERE id_usuario = ?"
        );

        psEliminarUsuario.setInt(1, idUsuario);

        int filas =
        psEliminarUsuario.executeUpdate();

        if(filas > 0){

            response.sendRedirect(
            "panelAdmin.jsp?msg=usuario_eliminado&section=usuarios"
            );

        } else {

            response.sendRedirect(
            "panelAdmin.jsp?msg=error&section=usuarios"
            );
        }

    } catch(Exception e){

        e.printStackTrace();

        response.sendRedirect(
        "panelAdmin.jsp?msg=error&section=usuarios"
        );

    } finally {

        try{
            if(rs != null){
                rs.close();
            }
        } catch(Exception e){}

        try{
            if(psVerificar != null){
                psVerificar.close();
            }
        } catch(Exception e){}

        try{
            if(psEliminarFavoritos != null){
                psEliminarFavoritos.close();
            }
        } catch(Exception e){}

        try{
            if(psEliminarVistas != null){
                psEliminarVistas.close();
            }
        } catch(Exception e){}

        try{
            if(psEliminarUsuario != null){
                psEliminarUsuario.close();
            }
        } catch(Exception e){}
    }
%>
