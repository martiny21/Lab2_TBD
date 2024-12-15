package com.example.TBDBackendLab1.persistence.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.awt.*;
import java.time.LocalDateTime;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Delivery {
    Integer id;
    Integer delivery_peroson_id;
    Integer order_id;
    private Point deliveryGeom;
    private LocalDateTime deliveryDate;


}
