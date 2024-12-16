package com.example.TBDBackendLab1.service;

import com.example.TBDBackendLab1.persistence.entity.DeliveryPersonEntity;
import com.example.TBDBackendLab1.persistence.repository.DeliveryPersonRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class DeliveryPersonService {

    @Autowired
    private DeliveryPersonRepository deliveryPersonRepository;

    public List<DeliveryPersonEntity> getDeliveryPersonsByComuna(String comunaName) {
        return deliveryPersonRepository.getDeliveryPersonsByComuna(comunaName);
    }
}
