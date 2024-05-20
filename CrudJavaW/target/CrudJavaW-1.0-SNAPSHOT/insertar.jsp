<%-- 
    Document   : insertar
    Created on : 13 may 2024, 10:48:30 a. m.
    Author     : ramir
--%>

<%@page import="java.net.http.HttpResponse"%>
<%@page import="com.mycompany.crudjavaw.ApiConsumer"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
    <jsp:include page="head.jsp" />
     <script>
        function limitarInput(event) {
            var input = event.target;
            var valor = input.value;
            // Eliminar cualquier carácter que no sea un dígito
            input.value = valor.replace(/\D/g, '');
            // Limitar la longitud del valor a 10 dígitos
            if (input.value.length > 10) {
                input.value = input.value.slice(0, 10);
            }
        }
    </script>
    </head>
    <body>
        <div>
            <jsp:include page= "navbar.jsp"/>
        </div>
        <form method="POST">
  <div class="mb-3">
    <label for="CED_EST" class="form-label">Cedula</label>
    <input type="text" class="form-control" id="CED_EST" name="CED_EST" oninput="limitarInput(event)" pattern="\d{10}" title="La cédula debe contener exactamente 10 dígitos numéricos." required>
  </div>
  <div class="mb-3">
    <label for="NOM_EST" class="form-label">Nombre</label>
    <input type="text" class="form-control" id="NOM_EST" name="NOM_EST" required>
  </div>    
  <div class="mb-3">
    <label for="APE_EST" class="form-label">Apellido</label>
    <input type="text" class="form-control" id="APE_EST" name="APE_EST" required>
  </div>
  <div class="mb-3">
    <label for="DIR_EST" class="form-label">Direccion</label>
    <input type="text" class="form-control" id="DIR_EST" name="DIR_EST" required>
  </div>
  <div class="mb-3">
    <label for="TEL_EST" class="form-label">Telefono</label>
    <input type="text" class="form-control" id="TEL_EST" name="TEL_EST" oninput="limitarInput(event)" pattern="\d{10}" title="Ingrese un número de teléfono de 10 dígitos." required>
  </div>
  <button type="submit" class="btn btn-primary">Crear</button>
</form>
        
            <%
                if(request.getMethod().equals("POST")){
                ApiConsumer api = new ApiConsumer();
                HttpResponse<String> respuesta = api.postEstudiante(request.getParameter("CED_EST"), request.getParameter("NOM_EST"), request.getParameter("APE_EST"), request.getParameter("DIR_EST"), request.getParameter("TEL_EST"));
                if (api.getResponseStatusCode(respuesta)==200) {
                    response.sendRedirect("index.jsp");
                    }else{
                    out.print("Se guardo");
                    }
                }
                
                %>
    </body>
</html>
