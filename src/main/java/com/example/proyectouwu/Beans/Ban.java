package com.example.proyectouwu.Beans;

import java.sql.Time;
import java.sql.Date;

public class Ban {
    //Atributos
    private Integer idBan;
    private Usuario usuario=new Usuario();
    private String motivoBan;
    private Date fecha;
    private Time hora;


    //Getters and setters


    public Integer getIdBan() {
        return idBan;
    }

    public void setIdBan(Integer idBan) {
        this.idBan = idBan;
    }

    public Usuario getUsuario() {
        return usuario;
    }

    public void setUsuario(Usuario usuario) {
        this.usuario = usuario;
    }

    public String getMotivoBan() {
        return motivoBan;
    }

    public void setMotivoBan(String motivoBan) {
        this.motivoBan = motivoBan;
    }

    public Date getFecha() {
        return fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }

    public Time getHora() {
        return hora;
    }

    public void setHora(Time hora) {
        this.hora = hora;
    }
}
