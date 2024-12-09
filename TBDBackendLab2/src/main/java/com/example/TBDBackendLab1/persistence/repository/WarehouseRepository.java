package com.example.TBDBackendLab1.persistence.repository;

import com.example.TBDBackendLab1.persistence.entity.WarehouseEntity;

public interface WarehouseRepository {
    WarehouseEntity addWarehouse(WarehouseEntity warehouse);
    WarehouseEntity getById(Integer warehouseId);
}
