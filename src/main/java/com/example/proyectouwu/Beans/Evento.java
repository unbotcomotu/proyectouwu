package com.example.proyectouwu.Beans;

import java.sql.Date;
import java.sql.Time;
import java.util.ArrayList;

public class Evento {
    private int idEvento;
    private int idActividad;

    private int lugarEvento;
    private String titulo;
    private Date fecha;
    private Time hora;
    private String descripcionEventoActivo;
    private String fraseMotivacional;
    private Foto fotoMiniatura;
    private ArrayList<Foto> carruselFotos;
    private boolean eventoFinalizado;
    private boolean eventoOculto;
    private String resultadoEvento;
    private String resumen;

    public int getIdEvento() {
        return idEvento;
    }

    public void setIdEvento(int idEvento) {
        this.idEvento = idEvento;
    }

    public int getIdActividad() {
        return idActividad;
    }

    public void setIdActividad(int idActividad) {
        this.idActividad = idActividad;
    }

    public int getLugarEvento() {
        return lugarEvento;
    }

    public void setLugarEvento(int lugarEvento) {
        this.lugarEvento = lugarEvento;
    }

    public String getTitulo() {
        return titulo;
    }

    public void setTitulo(String titulo) {
        this.titulo = titulo;
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

    public String getDescripcionEventoActivo() {
        return descripcionEventoActivo;
    }

    public void setDescripcionEventoActivo(String descripcionEventoActivo) {
        this.descripcionEventoActivo = descripcionEventoActivo;
    }

    public String getFraseMotivacional() {
        return fraseMotivacional;
    }

    public void setFraseMotivacional(String fraseMotivacional) {
        this.fraseMotivacional = fraseMotivacional;
    }

    public Foto getFotoMiniatura() {
        return fotoMiniatura;
    }

    public void setFotoMiniatura(Foto fotoMiniatura) {
        this.fotoMiniatura = fotoMiniatura;
    }

    public ArrayList<Foto> getCarruselFotos() {
        return carruselFotos;
    }

    public void setCarruselFotos(ArrayList<Foto> carruselFotos) {
        this.carruselFotos = carruselFotos;
    }

    public boolean isEventoFinalizado() {
        return eventoFinalizado;
    }

    public void setEventoFinalizado(boolean eventoFinalizado) {
        this.eventoFinalizado = eventoFinalizado;
    }

    public boolean isEventoOculto() {
        return eventoOculto;
    }

    public void setEventoOculto(boolean eventoOculto) {
        this.eventoOculto = eventoOculto;
    }

    public String getResultadoEvento() {
        return resultadoEvento;
    }

    public void setResultadoEvento(String resultadoEvento) {
        this.resultadoEvento = resultadoEvento;
    }

    public String getResumen() {
        return resumen;
    }

    public void setResumen(String resumen) {
        this.resumen = resumen;
    }
}