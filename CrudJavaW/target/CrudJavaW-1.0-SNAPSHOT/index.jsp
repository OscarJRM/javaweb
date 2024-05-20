<%@page import="java.net.http.HttpResponse"%>
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>
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
        <jsp:include page="navbar.jsp" />
    </div>
    <table class="table">
        <thead>
            <tr>
                <th scope="col">CEDULA</th>
                <th scope="col">NOMBRE</th>
                <th scope="col">APELLIDO</th>
                <th scope="col">DIRECCION</th>
                <th scope="col">TELEFONO</th>
                <th scope="col">ACCIONES</th> <!-- Agrega una columna para los botones de editar -->
            </tr>
        </thead>
        <tbody>
            <% 
                ApiConsumer apiConsumer = new ApiConsumer();    
                JSONArray estudiantes = apiConsumer.getEstudiantes();
                for (int i = 0; i < estudiantes.length(); i++) {
                    JSONObject estudiante = estudiantes.getJSONObject(i);
                    String CED_EST = estudiante.getString("CED_EST");
                    String NOM_EST = estudiante.getString("NOM_EST");
                    String APE_EST = estudiante.getString("APE_EST");
                    String DIR_EST = estudiante.getString("DIR_EST");
                    String TEL_EST = estudiante.getString("TEL_EST");
            %>
            <tr>
                <td><%= CED_EST%></td>
                <td><%= NOM_EST%></td>
                <td><%= APE_EST%></td>
                <td><%= DIR_EST%></td>
                <td><%= TEL_EST%></td>
                <td>
                    <!-- Agrega un botón de editar con un evento onclick -->
                    <button type="button" class="btn btn-primary" onclick="editarEstudiante('<%= CED_EST%>', '<%= NOM_EST%>', '<%= APE_EST%>', '<%= DIR_EST%>', '<%= TEL_EST%>')">Editar</button>
                </td>
                <td><a href="eliminar.jsp?CED_EST=<%= CED_EST%>" class="btn btn-danger">Eliminar</a></td>
            </tr>
            <% } %>
        </tbody>
    </table>
    
    <!-- Modal -->
    <div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLongTitle">Editar Estudiante</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form method="POST" autocomplete="off">
                        <div class="mb-3">
                            <label for="cedula" class="form-label">Cedula</label>
                            <input type="text" class="form-control" id="cedula" name="cedula" readonly>
                        </div>
                        <div class="mb-3">
                            <label for="nombre" class="form-label">Nombre</label>
                            <input type="text" class="form-control" id="nombre" name="nombre" required>
                        </div>
                        <div class="mb-3">
                            <label for="apellido" class="form-label">Apellido</label>
                            <input type="text" class="form-control" id="apellido" name="apellido" required>
                        </div>
                        <div class="mb-3">
                            <label for="direccion" class="form-label">Dirección</label>
                            <input type="text" class="form-control" id="direccion" name="direccion" required>
                        </div>
                        <div class="mb-3">
                            <label for="telefono" class="form-label">Teléfono</label>
                            <input type="text" class="form-control" id="telefono" name="telefono" oninput="limitarInput(event)" pattern="\d{10}" title="Ingrese un número de teléfono de 10 dígitos." required>
                        </div>

                        <button type="submit" class="btn btn-primary">Actualizar</button>
                    </form>
                    <%
            if (request.getMethod().equals("POST")) {
                try {
                    // Obtén los valores del formulario
                    String cedula = request.getParameter("cedula");
                    String nombre = request.getParameter("nombre");
                    String apellido = request.getParameter("apellido");
                    String direccion = request.getParameter("direccion");
                    String telefono = request.getParameter("telefono");

                    // Llama a updateUser en UserService para actualizar el usuario
                    HttpResponse<String> respuesta = apiConsumer.updateUser(cedula, nombre, apellido, direccion, telefono);

                    // Maneja la respuesta y muestra un mensaje según el resultado
                    if (apiConsumer.getResponseStatusCode(respuesta) == 200) {
                        out.print("<br>");
                        out.print("<div class='alert alert-success' role='alert'>Registro actualizado con éxitoo</div>");
                        out.print("<div>"+cedula+nombre+respuesta.body()+"</div>");
                        // Redirige a la página principal si se requiere
                        response.sendRedirect("index.jsp");
                    } else {
                        out.print("<br>");
                        out.print("<div class='alert alert-danger' role='alert'>Error al actualizar el registro</div>");
                    }
                } catch (Exception e) {
                    // Muestra un mensaje de error si ocurre alguna excepción
                    out.print("Error: " + e.getMessage());
                }
            }
        %>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>
            
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

<script>
    // Función para llenar el modal con los datos del estudiante seleccionado
    function editarEstudiante(cedula, nombre, apellido, direccion, telefono) {
        document.getElementById('cedula').value = cedula;
        document.getElementById('nombre').value = nombre;
        document.getElementById('apellido').value = apellido;
        document.getElementById('direccion').value = direccion;
        document.getElementById('telefono').value = telefono;
        
        // Actualiza el action del formulario para que envíe los datos al servlet o página adecuada para la edición
        //document.querySelector('form').action = 'editar.jsp?CED_EST=' + cedula;
        
        // Abre el modal
        $('#exampleModalCenter').modal('show');
    }
</script>
</body>
</html>
