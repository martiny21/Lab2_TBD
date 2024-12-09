package com.example.TBDBackendLab1.controller;

import com.example.TBDBackendLab1.persistence.entity.WarehouseEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import com.example.TBDBackendLab1.service.WarehouseService;

@RestController
@RequestMapping("/warehouse")
@CrossOrigin("*")
public class WarehouseController {

    @Autowired
    private WarehouseService warehouseService;

    @PostMapping("/add")
    public WarehouseEntity addWarehouse(@RequestBody WarehouseEntity warehouse){
        return warehouseService.addWarehouse(warehouse);
    }

    @GetMapping("/getById/{id}")
    public WarehouseEntity getById(@PathVariable Integer id){
        return warehouseService.getById(id);
    }
}
