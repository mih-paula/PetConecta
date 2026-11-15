package com.petconecta.backend.model;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;

import java.time.Instant;
import java.time.LocalDate;

@Entity
@Table(name= "tb_animais")
public class Animal {

    // Informações Gerais
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    Long id;
    String tipo;
    String racaEspecie;
    String nome;
    int idade;
    float peso;
    boolean sexo; // 0=macho 1=fêmea
    boolean disponivelAdocao;
    LocalDate dataChegada;

    // Funcionamento interno
    boolean statusArquivamento;

    // Usuario adicionadoPor;
    // Usuario editadoPor; vai ficar comentado pois nao estudei como fazer associais ainda kkkkk
    Instant ultimaEdicao;





    // ID, Nome, Idade, Tipo, Raça/Espécie, peso, sexo, status de arquivamento, Disponível para adoção, Data chegada, Adicionado por, Editado por, Última Edição
}
