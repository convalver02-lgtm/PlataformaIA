<%-- 
    Document   : cerrarSesion
    Created on : 6/01/2026, 04:36:18 AM
    Author     : 16003
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page session="true"%>
<%
    session.invalidate();
    response.sendRedirect("login.jsp");
%>



