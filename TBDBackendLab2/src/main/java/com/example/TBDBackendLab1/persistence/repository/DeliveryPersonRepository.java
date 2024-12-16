package com.example.TBDBackendLab1.persistence.repository;

import com.example.TBDBackendLab1.persistence.entity.DeliveryPersonEntity;

import java.util.List;

public interface DeliveryPersonRepository {
    public List<DeliveryPersonEntity> getDeliveryPersonsByComuna(String comunaName);
}
