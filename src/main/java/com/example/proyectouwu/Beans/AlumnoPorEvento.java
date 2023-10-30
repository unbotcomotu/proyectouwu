package com.example.proyectouwu.Beans;

import java.sql.Time;
import java.sql.Date;

public class AlumnoPorEvento {

    //Atributos
    private int idAlumnoPorEvento;
    private int idAlumno;
    private int idEvento;
    private String estadoApoyo = "En espera";
    private java.sql.Date fechaSolicitud;
    private Time horaSolicitud;

    //Metodos otros



    //Getters and setters
    public int getIdAlumnoPorEvento() {
        return idAlumnoPorEvento;
    }

    public void setIdAlumnoPorEvento(int idAlumnoPorEvento) {
        this.idAlumnoPorEvento = idAlumnoPorEvento;
    }

    public int getIdAlumno() {
        return idAlumno;
    }

    public void setIdAlumno(int idAlumno) {
        this.idAlumno = idAlumno;
    }

    public int getIdEvento() {
        return idEvento;
    }

    public void setIdEvento(int idEvento) {
        this.idEvento = idEvento;
    }

    public String getEstadoApoyo() {
        return estadoApoyo;
    }

    public void setEstadoApoyo(String estadoApoyo) {
        this.estadoApoyo = estadoApoyo;
    }

    public Date getFechaSolicitud() {
        return fechaSolicitud;
    }

    public void setFechaSolicitud(java.sql.Date fechaSolicitud) {
        this.fechaSolicitud = fechaSolicitud;
    }

    public Time getHoraSolicitud() {
        return horaSolicitud;
    }

    public void setHoraSolicitud(Time horaSolicitud) {
        this.horaSolicitud = horaSolicitud;
    }
}
