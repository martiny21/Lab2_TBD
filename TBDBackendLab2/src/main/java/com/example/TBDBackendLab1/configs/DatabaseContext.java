package com.example.TBDBackendLab1.configs;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.jdbc.core.JdbcTemplate;
import org.sql2o.Sql2o;

import javax.sql.DataSource;

@Configuration
public class DatabaseContext {
    @Bean
    public Sql2o sql2o(){
        return new Sql2o("jdbc:postgresql://localhost:5432/TBDLab2","postgres","1234");
    }

}
