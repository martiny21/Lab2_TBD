package com.example.TBDBackendLab1.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.sql2o.Sql2o;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/delivery")
public class DeliveryPointController {

    @Autowired
    private Sql2o sql2o;

        @GetMapping("/persons-in-comuna")
        public ResponseEntity<List<Map<String, Object>>> getDeliveryPersonsByComuna(@RequestParam String comunaName) {
            String sql = "SELECT * FROM get_delivery_persons_in_comuna(:comunaName)";

            try (org.sql2o.Connection connection = sql2o.open()) {
                // Ejecuta la consulta y obtiene los resultados
                List<Map<String, Object>> deliveryPersons = connection.createQuery(sql)
                        .addParameter("comunaName", comunaName) // Agrega el parámetro
                        .executeAndFetchTable()
                        .asList();

                // Retorna los datos en el ResponseEntity
                return ResponseEntity.ok(deliveryPersons);
            } catch (Exception e) {
                // Manejo de excepciones
                e.printStackTrace();
                return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
            }
        }

}


