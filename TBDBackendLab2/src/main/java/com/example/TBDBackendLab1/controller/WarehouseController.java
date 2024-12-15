package com.example.TBDBackendLab1.controller;

import com.example.TBDBackendLab1.persistence.entity.WarehouseEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.web.bind.annotation.*;
import com.example.TBDBackendLab1.service.WarehouseService;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/warehouse")
@CrossOrigin("*")
public class WarehouseController {

    @Autowired
    private WarehouseService warehouseService;

    @Autowired
    private JdbcTemplate jdbcTemplate;

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
        try {
            // Llama al procedimiento almacenado
            List<Map<String, Object>> warehouses = jdbcTemplate.queryForList(
                    "SELECT * FROM get_warehouses_in_region(?)",
                    regionName
            );
            return ResponseEntity.ok(warehouses);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
        }
    }

    @GetMapping("/nearest")
    public ResponseEntity<Map<String, Object>> getWarehousesByNearest(@RequestParam Integer id) {
        try {

            List<Map<String, Object>> warehouses = jdbcTemplate.queryForList(
                    "SELECT * FROM find_nearest_warehouse(?)",
                    id
            );
            return ResponseEntity.ok(warehouses.get(0));
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
        }
    }

}
