package com.petconecta.backend.model;

import jakarta.persistence.Entity;


@Entity
public class Coordenador extends Usuario{

    public Coordenador(long id, String nomeCompleto, String telefone, String email, String senha, boolean ativo) {
        super(id, nomeCompleto, telefone, email, senha, ativo);
    }


}


