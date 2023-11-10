package com.example.proyectouwu.Beans;

import java.sql.Time;
import java.sql.Date;

public class AlumnoPorEvento {

    //Atributos
    private int idAlumnoPorEvento;
    private Usuario alumno=new Usuario();
    private Evento evento=new Evento();
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

    public Usuario getAlumno() {
        return alumno;
    }

    public void setAlumno(Usuario alumno) {
        this.alumno = alumno;
    }

    public Evento getEvento() {
        return evento;
    }

    public void setEvento(Evento evento) {
        this.evento = evento;
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

    public void setFechaSolicitud(Date fechaSolicitud) {
        this.fechaSolicitud = fechaSolicitud;
    }

    public Time getHoraSolicitud() {
        return horaSolicitud;
    }

    public void setHoraSolicitud(Time horaSolicitud) {
        this.horaSolicitud = horaSolicitud;
    }
}
