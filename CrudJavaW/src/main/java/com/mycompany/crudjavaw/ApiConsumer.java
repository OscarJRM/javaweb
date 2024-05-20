/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.crudjavaw;

import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.json.JSONArray;
import org.json.JSONObject;

/**
 *
 * @author ramir
 */
public class ApiConsumer {

    private final HttpClient httpClient;
    private static String url = "http://localhost/SOAcopia/controller/apiRest.php";

    public ApiConsumer() {
        this.httpClient = HttpClient.newHttpClient();

    }

    public JSONArray getEstudiantes() throws Exception {
        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(url))
                .GET()
                .build();
        HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());
        return new JSONArray(response.body());
    }

    public HttpResponse<String> postEstudiante(String CED_EST, String NOM_EST, String APE_EST, String DIR_EST, String TEL_EST) {
        try {
            JSONObject estudiante = new JSONObject();
            estudiante.put("CED_EST", CED_EST);
            estudiante.put("NOM_EST", NOM_EST);
            estudiante.put("APE_EST", APE_EST);
            estudiante.put("DIR_EST", DIR_EST);
            estudiante.put("TEL_EST", TEL_EST);
            
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(URI.create(url))
                    .header("Content-Type", "application/json")
                    .POST(HttpRequest.BodyPublishers.ofString(estudiante.toString()))
                    .build();
            HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());
            return response;
        } catch (Exception ex) {
            System.out.println("Error al enviar un estudiante " + ex);
            return null;
        } 

    }
    
    public HttpResponse<String> deleteEstudiante(String CED_EST){
        HttpResponse<String> response = null;
        try {
            URI uri = URI.create(url+"?CED_EST="+CED_EST);
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(uri)
                    .DELETE()
                    .build();
            
             response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());
            return response;
        } catch (Exception ex) {
            System.out.println("Error al eliminar: "+ex);
            return response;
        } 
    }
    
    public JSONObject getUserById(String cedula) throws Exception {
        // Realiza una solicitud GET para obtener todos los usuarios
        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(url))
                .GET()
                .build();

        // Obtiene la respuesta del servidor
        HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());

        // Convierte la respuesta en un JSONArray
        JSONArray jsonArray = new JSONArray(response.body());

        // Itera a través del JSONArray y encuentra el usuario con la cedula especificada
        for (int i = 0; i < jsonArray.length(); i++) {
            JSONObject jsonObject = jsonArray.getJSONObject(i);
            if (jsonObject.getString("cedula").equals(cedula)) {
                // Retorna el objeto JSON del usuario encontrado
                return jsonObject;
            }
        }

        // Si no se encuentra el usuario, retorna null
        return null;
    }
    
     public HttpResponse<String> updateUser(String cedula, String nombre, String apellido, String direccion, String telefono) throws Exception {
        // Crea el objeto JSON con los datos a actualizar
        JSONObject data = new JSONObject();
        data.put("CED_EST", cedula);
        data.put("NOM_EST", nombre);
        data.put("APE_EST", apellido);
        data.put("DIR_EST", direccion);
        data.put("TEL_EST", telefono);

        // Construye la URI
        URI uri = URI.create(url);

        // Crea una solicitud PUT para actualizar el usuario
        HttpRequest request = HttpRequest.newBuilder()
                .uri(uri)
                .header("Content-Type", "application/json")
                .PUT(HttpRequest.BodyPublishers.ofString(data.toString()))
                .build();
        
         System.out.println(request);

        // Envía la solicitud y devuelve la respuesta
        return httpClient.send(request, HttpResponse.BodyHandlers.ofString());
    }
    
     public int getResponseStatusCode(HttpResponse<String> response) {
        return response.statusCode();
    }
     
     public int getResponceStatus(HttpResponse<String> response){
        return response.statusCode();
     }
}
