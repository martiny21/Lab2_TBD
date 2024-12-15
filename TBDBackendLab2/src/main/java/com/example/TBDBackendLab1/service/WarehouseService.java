package com.example.TBDBackendLab1.service;

import com.example.TBDBackendLab1.persistence.entity.WarehouseEntity;
import com.example.TBDBackendLab1.persistence.repository.WarehouseRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class WarehouseService {

    @Autowired
    private WarehouseRepository warehouseRepository;

    public WarehouseEntity addWarehouse(WarehouseEntity warehouse) {
        return warehouseRepository.addWarehouse(warehouse);
    }

    public WarehouseEntity getById(Integer warehouseId) {
        return warehouseRepository.getById(warehouseId);
    }

    public ResponseEntity<List<Map<String, Object>>> getWarehousesByRegion(String region) {
        return warehouseRepository.getWarehousesByRegion(region);
    }

    public ResponseEntity<Map<String, Object>> getWarehousesByNearest(Integer id) {
        return warehouseRepository.getWarehousesByNearest(id);
    }
}