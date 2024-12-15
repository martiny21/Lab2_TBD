package com.example.TBDBackendLab1.persistence.repository;

import com.example.TBDBackendLab1.persistence.entity.Delivery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.RequestParam;
import org.sql2o.Sql2o;

import java.util.List;
import java.util.Map;

@Repository
public class DeliveryRepositoryImplementation implements DeliveryRepository {

    @Autowired
    private Sql2o sql2o;

    @Override
    public Delivery addDelivery(Delivery delivery) {
        String sql = "INSERT INTO delivery_points (delivery_person_id, order_id, delivery_geom, delivery_date) " +
                "VALUES (:delivery_person_id, :order_id, ST_GeomFromText(:delivery_geom, 4326), :delivery_date)";

        try (org.sql2o.Connection con = sql2o.open()) {
            Integer generatedId = (Integer) con.createQuery(sql, true)
                    .addParameter("delivery_person_id", delivery.getDelivery_peroson_id())
                    .addParameter("order_id", delivery.getOrder_id())
                    .addParameter("delivery_geom", String.format("POINT(%f %f)",
                            delivery.getDeliveryGeom().getX(), delivery.getDeliveryGeom().getY())) // Convertir el punto a WKT
                    .addParameter("delivery_date", delivery.getDeliveryDate())
                    .executeUpdate()
                    .getKey();

            delivery.setId(generatedId);
            return delivery;
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }

    @Override
    public ResponseEntity<List<Map<String, Object>>> getDeliveryPersonsByComuna(String comunaName){
        String sql = "SELECT * FROM get_delivery_persons_in_comuna(:comunaName)";

        try (org.sql2o.Connection connection = sql2o.open()) {
            // Ejecuta la consulta y obtiene los resultados
            List<Map<String, Object>> deliveryPersons = connection.createQuery(sql)
                    .addParameter("comunaName", comunaName) // Agrega el parámetro
                    .executeAndFetchTable()
                    .asList();

            // Retorna los datos en el ResponseEntity
            return ResponseEntity.ok(deliveryPersons);
        } catch (Exception e) {
            // Manejo de excepciones
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
        }
    }


}
