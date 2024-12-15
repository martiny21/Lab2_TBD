package com.example.TBDBackendLab1.persistence.repository;

import com.example.TBDBackendLab1.persistence.entity.Delivery;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;
import java.util.Map;

public interface DeliveryRepository {
    Delivery addDelivery(Delivery delivery);
    ResponseEntity<List<Map<String, Object>>> getDeliveryPersonsByComuna( String comunaName);
}
