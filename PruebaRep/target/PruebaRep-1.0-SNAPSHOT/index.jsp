
<%@page import="com.mycompany.pruebarep.ApiConsumer"%>
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <title>Buscar Repuestos</title>
</head>
<body>
    <h1>Buscar Repuestos</h1>
    <form method="post">
        <label for="NOM_REP">Nombre del Repuesto:</label>
        <input type="text" id="NOM_REP" name="NOM_REP" required><br>
        <label for="PAIS">País:</label>
        <input type="text" id="PAIS" name="PAIS" required><br>
        <button type="submit">Buscar</button>
    </form>

    <br>
    <h2>Resultados</h2>
    <table border="1">
        <thead>
            <tr>
                <th>Repuesto</th>
                <th>Cantidad</th>
                <th>Precio</th>
                <th>País</th>
            </tr>
        </thead>
        <tbody>
            <%
                if (request.getMethod().equals("POST")) {
                try {
                    String NOM_REP = request.getParameter("NOM_REP");
                    String PAIS = request.getParameter("PAIS");
                    
                    ApiConsumer apiConsumer = new ApiConsumer();
                    JSONArray repuestos = apiConsumer.getRepuestosbyNomPa(NOM_REP, PAIS);
                    for (int i = 0; i < repuestos.length(); i++) {
                            JSONObject repuesto = repuestos.getJSONObject(i);
                            String nomRep = repuesto.getString("NOM_REP");
                            String cant = repuesto.getString("CAN_REP");
                            String precio = repuesto.getString("PRE_REP");
                            String pais = repuesto.getString("PAIS");
                    
                            %>
                             <tr>
                <td><%= nomRep%></td>
                <td><%= cant%></td>
                <td><%= precio%></td>
                <td><%= pais%></td>
            </tr>     
                            <%
                            
                        }
                    } catch (Exception e) {
                    
                    }
                }
                
                // Verifica si existen resultados en la solicitud
               
            %>
      
        </tbody>
    </table>
</body>
</html>
