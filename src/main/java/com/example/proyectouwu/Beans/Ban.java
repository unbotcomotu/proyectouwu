package com.example.proyectouwu.Beans;

import java.sql.Time;
import java.util.Date;

public class Ban {
    private int idBan;
    private int idUsuario;
    private String motivoBan;
    private Date fecha;
    private Time hora;

    public int getIdBan() {
        return idBan;
    }

    public void setIdBan(int idBan) {
        this.idBan = idBan;
    }

    public int getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(int idUsuario) {
        this.idUsuario = idUsuario;
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
