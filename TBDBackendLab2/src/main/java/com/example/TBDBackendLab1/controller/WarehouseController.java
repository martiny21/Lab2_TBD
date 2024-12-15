package com.example.TBDBackendLab1.controller;

import com.example.TBDBackendLab1.persistence.entity.WarehouseEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.web.bind.annotation.*;
import com.example.TBDBackendLab1.service.WarehouseService;
import org.sql2o.Sql2o;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/warehouse")
@CrossOrigin("*")
public class WarehouseController {

    @Autowired
    private WarehouseService warehouseService;

    @Autowired
    private Sql2o sql2o;

    @PostMapping("/add")
    public WarehouseEntity addWarehouse(@RequestBody WarehouseEntity warehouse){
        return warehouseService.addWarehouse(warehouse);
    }

    @GetMapping("/getById/{id}")
    public WarehouseEntity getById(@PathVariable Integer id){
        return warehouseService.getById(id);
    }

    @GetMapping("/region")
    public ResponseEntity<List<Map<String, Object>>> getWarehousesByRegion(@RequestParam String regionName) {
        return warehouseService.getWarehousesByRegion(regionName);
    }

    @GetMapping("/nearest")
    public ResponseEntity<Map<String, Object>> getWarehousesByNearest(@RequestParam Integer id) {
        return warehouseService.getWarehousesByNearest(id);
    }

}
