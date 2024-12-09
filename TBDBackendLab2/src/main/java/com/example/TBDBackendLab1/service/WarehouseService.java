package com.example.TBDBackendLab1.service;

import com.example.TBDBackendLab1.persistence.entity.WarehouseEntity;
import com.example.TBDBackendLab1.persistence.repository.WarehouseRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
}
