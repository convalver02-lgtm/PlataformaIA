<%-- 
    Document   : conexion
    Created on : 6/01/2026, 04:27:37 AM
    Author     : 16003
--%>

<%--
    Document : conexion
    Created on : 6/01/2026, 04:27:37 AM
    Author : 16003
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%
    Connection conexion = null;
    try {
        Class.forName("com.mysql.jdbc.Driver");
        String url = "jdbc:mysql://localhost:3306/plataforma_ia?" +
                     "useUnicode=true&characterEncoding=UTF-8&useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";
        conexion = DriverManager.getConnection(url, "root", "");
    } catch (Exception e) {
        out.println("<div class='alert alert-danger'>Error de conexión: " + e.getMessage() + "</div>");
    }
%>