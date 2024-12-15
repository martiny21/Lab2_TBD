package com.example.TBDBackendLab1.service;

import com.example.TBDBackendLab1.persistence.entity.ClientAlert;
import com.example.TBDBackendLab1.persistence.entity.ClientEntity;
import com.example.TBDBackendLab1.persistence.entity.ClientQueryReport;
import com.example.TBDBackendLab1.persistence.entity.Client_p;
import com.example.TBDBackendLab1.persistence.repository.ClientRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Locale;

@Service
public class ClientService {

    @Autowired
    private ClientRepository clientRepository;

    public ClientEntity addClient(ClientEntity client) {
        // Verifica que latitude y longitude no sean nulos
        if (client.getLatitude() != null && client.getLongitude() != null) {
            // Construye el WKT del punto con Locale.US
            String wktPoint = String.format(Locale.US, "POINT(%f %f)", client.getLongitude(), client.getLatitude());
            client.setDirection_geom(wktPoint); // Establece el valor WKT en el atributo direction_geom
        } else {
            throw new IllegalArgumentException("Latitude and Longitude must not be null.");
        }

        // Llama al repositorio para insertar el cliente
        return clientRepository.addClient(client);
    }

    public ClientEntity getById(Integer client_id) {
        return clientRepository.getById(client_id);
    }

    public ClientEntity getByEmail(String email) {
        return clientRepository.getByEmail(email);
    }

    public List<ClientQueryReport> getReports() {
        return clientRepository.getClientQueryReport();
    }

    public List<ClientAlert> getClientAlerts() {
        return clientRepository.getClientAlerts();
    }

    public List<Client_p> getproblem() {
        return clientRepository.getClientIssueReport();
    }

    public  List<String> getRegion() {return clientRepository.getRegion() ;}

    public  List<String> getComunas() {return clientRepository.getComuna() ;}
}
