package com.example.TBDBackendLab1.persistence.repository;

import com.example.TBDBackendLab1.persistence.entity.WarehouseEntity;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;
import java.util.Map;

public interface WarehouseRepository {
    WarehouseEntity addWarehouse(WarehouseEntity warehouse);
    WarehouseEntity getById(Integer warehouseId);
    ResponseEntity<List<Map<String, Object>>>  getWarehousesByRegion(String regionName);
    ResponseEntity<Map<String, Object>> getWarehousesByNearest(Integer id);
}
