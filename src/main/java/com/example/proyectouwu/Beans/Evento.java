package com.example.proyectouwu.Beans;

import java.sql.Blob;
import java.sql.Date;
import java.sql.Time;
import java.util.ArrayList;

public class Evento {
    //ATRIBUTOS
    private int idEvento;
    private Actividad actividad=new Actividad();
    private LugarEvento lugarEvento=new LugarEvento();
    private String titulo;
    private Date fecha;
    private Time hora;
    private String descripcionEventoActivo;
    private String fraseMotivacional;
    private Blob fotoMiniatura;
    private ArrayList<Blob> carruselFotos=new ArrayList<>();
    private boolean eventoFinalizado = false;
    private boolean eventoOculto;
    private String resultadoEvento;
    private String resumen;


    //GETTERS AND SETTERS

    public int getIdEvento() {
        return idEvento;
    }

    public void setIdEvento(int idEvento) {
        this.idEvento = idEvento;
    }

    public Actividad getActividad() {
        return actividad;
    }

    public void setActividad(Actividad actividad) {
        this.actividad = actividad;
    }

    public LugarEvento getLugarEvento() {
        return lugarEvento;
    }

    public void setLugarEvento(LugarEvento lugarEvento) {
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

    public Blob getFotoMiniatura() {
        return fotoMiniatura;
    }

    public void setFotoMiniatura(Blob fotoMiniatura) {
        this.fotoMiniatura = fotoMiniatura;
    }

    public ArrayList<Blob> getCarruselFotos() {
        return carruselFotos;
    }

    public void setCarruselFotos(ArrayList<Blob> carruselFotos) {
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
