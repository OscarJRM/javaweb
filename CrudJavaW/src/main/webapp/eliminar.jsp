<%-- 
    Document   : eliminar
    Created on : 13 may 2024, 12:18:43 p. m.
    Author     : ramir
--%>

<%@page import="java.net.http.HttpResponse"%>
<%@page import="com.mycompany.crudjavaw.ApiConsumer"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String CED_EST = request.getParameter("CED_EST");
    
    ApiConsumer apiConsumer = new ApiConsumer();
    HttpResponse<String> respuesta = apiConsumer.deleteEstudiante(CED_EST);
    if(apiConsumer.getResponseStatusCode(respuesta)==200){
        response.sendRedirect("index.jsp");
    } else{
    out.print("<div>No se pudo eliminar </div>");
    }
    %>
