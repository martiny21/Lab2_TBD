package com.example.TBDBackendLab1.persistence.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class WarehouseEntity {
    private int warehouse_id;
    private String addres;
    private float latitude;
    private float longitude;
    private String geom;
    private String delivery_zone;
}
