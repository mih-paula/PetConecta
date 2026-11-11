package com.petconecta.backend.model;


public class Voluntario extends Usuario{

    public Voluntario (long id, String nomeCompleto, String telefone, String email, String senha, boolean ativo) {
        super(id, nomeCompleto, telefone, email, senha, ativo);
    }
}
