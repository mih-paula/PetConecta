package com.petconecta.backend.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;

import java.util.Date;


@Entity

@Id
@GeneratedValue(strategy = GenerationType.IDENTITY)
public class Prescricao {
private long id;
private String medicamento;
private String frequencia;
private Date dataInicio;
private Date dataFim;

public Prescricao(long id, String medicamento, String frequencia) {
    this.id = id;
    this.medicamento = medicamento;
    this.frequencia = frequencia;
    this.dataInicio = new Date();
    this.dataFim = new Date();
}

public long getId() {
    return id;
}
public void setId(long id) {
    this.id = id;
}

public String getMedicamento() {
    return medicamento;
}
public void setMedicamento(String medicamento) {
    this.medicamento = medicamento;
}

public String getFrequencia() {
    return frequencia;
}
public void setFrequencia(String frequencia) {
    this.frequencia = frequencia;
}

public Date getDataInicio() {
    return dataInicio;
}
public void setDataInicio(Date dataInicio) {
    this.dataInicio = dataInicio;
}
public Date getDataFim() {
    return dataFim;
}
public void setDataFim(Date dataFim) {
    this.dataFim = dataFim;
}

}
