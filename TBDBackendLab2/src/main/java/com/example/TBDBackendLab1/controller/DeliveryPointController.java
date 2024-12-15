package com.example.TBDBackendLab1.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/delivery")
public class DeliveryPointController {

        @Autowired
        private JdbcTemplate jdbcTemplate;

        @GetMapping("/persons-in-comuna")
        public ResponseEntity<List<Map<String, Object>>> getDeliveryPersonsByComuna(@RequestParam String comunaName) {
            try {
                // Llama al procedimiento almacenado
                List<Map<String, Object>> deliveryPersons = jdbcTemplate.queryForList(
                        "SELECT * FROM get_delivery_persons_in_comuna(?)",
                        comunaName
                );

                // Retorna los datos
                return ResponseEntity.ok(deliveryPersons);
            } catch (Exception e) {
                e.printStackTrace();
                return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
            }
        }
    }


