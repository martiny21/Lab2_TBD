package com.example.TBDBackendLab1.persistence.repository;

import com.example.TBDBackendLab1.persistence.entity.WarehouseEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.sql2o.Sql2o;

@Repository
public class WarehouseRepositoryImplementation implements WarehouseRepository {

    @Autowired
    private Sql2o sql2o;

    @Override
    public WarehouseEntity addWarehouse(WarehouseEntity warehouse) {
        String sql = "INSERT INTO warehouse (addres, latitude, longitude, geom, delivery_zone)" +
                "VALUES (:addres, :latitude, :longitude, ST_GeomFromGeoJSON(:geom), ST_GeomFromGeoJSON(:deliveryZone))";

        try (org.sql2o.Connection con = sql2o.open()) {
            Integer generatedId = (Integer) con.createQuery(sql, true)
                    .addParameter("addres", warehouse.getAddres())
                    .addParameter("latitude", warehouse.getLatitude())
                    .addParameter("longitude", warehouse.getLongitude())
                    .addParameter("geom", warehouse.getGeom())
                    .addParameter("deliveryZone", warehouse.getDelivery_zone())
                    .executeUpdate()
                    .getKey();

            warehouse.setWarehouse_id(generatedId);
            return warehouse;
        } catch (Exception e) {
            e.printStackTrace();
            throw e; // Manejar la excepción si es necesario
        }
    }

    @Override
    public WarehouseEntity getById(Integer warehouseId) {
        try(org.sql2o.Connection con = sql2o.open()){
            return con.createQuery("SELECT warehouse_id," +
                            "latitude," +
                            "longitude" +
                            "ST_AsGeoJSON(geom) AS geom," +
                            "ST_AsGeoJSON(delivery_zone) AS deliveryZone" +
                            "FROM warehouse WHERE warehouse_id=:warehouse_id")
                    .addParameter("warehouse_id",warehouseId)
                    .executeAndFetchFirst(WarehouseEntity.class);
        } catch (Exception e) {
            e.printStackTrace();
            throw e; // Manejar la excepción si es necesario
        }
    }




}
