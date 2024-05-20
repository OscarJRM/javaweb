/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.pruebarep;

import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import org.json.JSONArray;



/**
 *
 * @author ramir
 */
public class ApiConsumer {
    private final HttpClient httClient;
    private static String url = "http://localhost/practicaJavaWeb/apiRest.php";

    public ApiConsumer() {
        this.httClient = HttpClient.newHttpClient();
    }
    
    
    
    public JSONArray getRepuestosbyNomPa(String NOM_REP, String PAIS) throws IOException, InterruptedException{
        URI uri = URI.create(url+"?NOM_REP="+NOM_REP+"&PAIS="+PAIS);
        HttpRequest request = HttpRequest.newBuilder()
                .uri(uri)
                .GET()
                .build();
        HttpResponse<String> response = httClient.send(request, HttpResponse.BodyHandlers.ofString());
        return new JSONArray(response.body());
                
    }
}
