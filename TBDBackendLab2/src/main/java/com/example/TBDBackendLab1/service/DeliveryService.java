package com.example.TBDBackendLab1.service;

import com.example.TBDBackendLab1.dto.DeliveryPerson;
import com.example.TBDBackendLab1.persistence.entity.Delivery;
import com.example.TBDBackendLab1.persistence.repository.DeliveryRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class DeliveryService {

    @Autowired
    DeliveryRepository DeliveryRepository;

    public Delivery AddDelivery(Delivery delivery) {return DeliveryRepository.addDelivery(delivery) ;}

    public List<Map<String, Object>> getDeliveryPersonsByComuna(String comunaName){return DeliveryRepository.getDeliveryPersonsByComuna(comunaName);}
}
