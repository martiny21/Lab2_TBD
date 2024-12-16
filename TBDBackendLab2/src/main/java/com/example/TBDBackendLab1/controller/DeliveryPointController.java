package com.example.TBDBackendLab1.controller;

import com.example.TBDBackendLab1.persistence.entity.DeliveryPersonEntity;
import com.example.TBDBackendLab1.service.DeliveryPersonService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

import org.springframework.web.bind.annotation.*;
import org.sql2o.Sql2o;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/delivery")
@CrossOrigin("*")
public class DeliveryPointController {

    @Autowired
    private DeliveryPersonService deliveryPersonService;

    @GetMapping("/personsByComuna")
    public ResponseEntity<List<DeliveryPersonEntity>> getDeliveryPersonsByComuna(@RequestParam String comunaName) {
        try {
            List<DeliveryPersonEntity> deliveryPersons = deliveryPersonService.getDeliveryPersonsByComuna(comunaName);
            return ResponseEntity.ok(deliveryPersons);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

}


