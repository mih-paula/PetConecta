package com.petconecta.backend.service;

import com.petconecta.backend.model.Usuario;
import com.petconecta.backend.model.Animal;
import com.petconecta.backend.repository.AnimalRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.ArrayList;
import java.util.List;

@Service
public class UsuarioService {

@Autowired
private AnimalRepository animalRepository;

public boolean fazerLogin(String login, String senha) {
    if (login == null || senha == null) {
        return false;
    }
    return true;
}

public void cadastrarAnimal(Usuario usuario) {
    // Lógica futura de cadastro
}

public List<Animal> filtrarAnimais(Usuario usuario) {
    if (usuario == null) {
        throw new IllegalArgumentException("Usuário inválido para realizar o filtro.");
    }
    return animalRepository.findByUsuario(usuario);
}

public void atualizarAnimal(Usuario usuario) {
    // Lógica futura de atualização
}

public List<Animal> consultarHistorico(Usuario usuario) {
        return new ArrayList<>();
    }

public void generarRelatorio(Usuario usuario) {
    // Lógica futura de relatório
}
}
