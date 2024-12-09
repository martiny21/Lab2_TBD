package com.example.TBDBackendLab1.service;

import com.example.TBDBackendLab1.persistence.entity.ClientEntity;
import com.example.TBDBackendLab1.persistence.repository.ClientRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

@Service
public class CustomUserDetailsService implements UserDetailsService {
    @Autowired
    private ClientRepository clientRepository;

    @Override
    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
        ClientEntity client = clientRepository.getByEmail(email);
        if (client == null){
            throw new UsernameNotFoundException("User not found");
        }
        return User.builder()
                .username(client.getEmail())
                .password(client.getClient_password()) // Asegúrate de que la contraseña esté encriptada
                .build();
    }
}
