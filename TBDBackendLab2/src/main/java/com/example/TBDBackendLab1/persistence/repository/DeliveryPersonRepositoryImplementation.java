package com.example.TBDBackendLab1.persistence.repository;

import com.example.TBDBackendLab1.persistence.entity.DeliveryPersonEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.sql2o.Sql2o;

import java.util.List;

@Repository
public class DeliveryPersonRepositoryImplementation implements DeliveryPersonRepository {

    @Autowired
    private Sql2o sql2o;

    @Override
    public List<DeliveryPersonEntity> getDeliveryPersonsByComuna(String comunaName) {
        String sql = "SELECT * FROM get_delivery_persons_in_comuna(:comunaName)";;
        try (org.sql2o.Connection con = sql2o.open()) {
            return con.createQuery(sql)
                    .addParameter("comunaName", comunaName)
                    .executeAndFetch(DeliveryPersonEntity.class);
        }catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }
}
