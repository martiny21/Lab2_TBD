package com.example.TBDBackendLab1.persistence.repository;

import com.example.TBDBackendLab1.persistence.entity.WarehouseEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.RequestParam;
import org.sql2o.Connection;
import org.sql2o.Sql2o;

import java.util.List;
import java.util.Map;

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
        try (org.sql2o.Connection con = sql2o.open()) {
            return con.createQuery("SELECT warehouse_id," +
                            "latitude," +
                            "longitude" +
                            "ST_AsGeoJSON(geom) AS geom," +
                            "ST_AsGeoJSON(delivery_zone) AS deliveryZone" +
                            "FROM warehouse WHERE warehouse_id=:warehouse_id")
                    .addParameter("warehouse_id", warehouseId)
                    .executeAndFetchFirst(WarehouseEntity.class);
        } catch (Exception e) {
            e.printStackTrace();
            throw e; // Manejar la excepción si es necesario
        }
    }

    @Override
    public ResponseEntity<List<Map<String, Object>>> getWarehousesByRegion(String regionName) {
            try (Connection connection = sql2o.open()) {
                // Llama al procedimiento almacenado o consulta SQL
                String sql = "SELECT * FROM get_warehouses_in_region(:regionName)";
                List<Map<String, Object>> warehouses = connection.createQuery(sql)
                        .addParameter("regionName", regionName) // Añade el parámetro
                        .executeAndFetchTable()
                        .asList();

                return ResponseEntity.ok(warehouses);
            } catch (Exception e) {
                e.printStackTrace();
                return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
            }
        }

     public ResponseEntity<Map<String, Object>> getWarehousesByNearest( Integer id){
            try (org.sql2o.Connection connection = sql2o.open()) {
                // Consulta al procedimiento almacenado o función
                String sql = "SELECT * FROM find_nearest_warehouse(:id)";

                // Ejecuta la consulta y obtiene el resultado
                List<Map<String, Object>> warehouses = connection.createQuery(sql)
                        .addParameter("id", id) // Pasa el parámetro
                        .executeAndFetchTable()
                        .asList();

                // Retorna el primer resultado
                if (!warehouses.isEmpty()) {
                    return ResponseEntity.ok(warehouses.get(0));
                } else {
                    // Si no hay resultados, retorna NOT FOUND
                    return ResponseEntity.ok(null);
                }
            } catch (Exception e) {
                e.printStackTrace();
                return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
            }
        }



}

