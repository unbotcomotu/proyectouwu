package com.example.proyectouwu.Beans;

import java.sql.Blob;
import java.util.ArrayList;

public class Actividad {
    //Atributos
    private int idActividad;
    private Usuario delegadoDeActividad=new Usuario();
    private String nombre;
    private Blob fotoMiniatura;
    private Blob fotoCabecera;
    private int cantPuntosPrimerLugar;
    private boolean actividadFinalizada = false;
    private boolean actividadOculta;

    public int getIdActividad() {
        return idActividad;
    }

    public void setIdActividad(int idActividad) {
        this.idActividad = idActividad;
    }

    public Usuario getDelegadoDeActividad() {
        return delegadoDeActividad;
    }

    public void setDelegadoDeActividad(Usuario delegadoDeActividad) {
        this.delegadoDeActividad = delegadoDeActividad;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public Blob getFotoMiniatura() {
        return fotoMiniatura;
    }

    public void setFotoMiniatura(Blob fotoMiniatura) {
        this.fotoMiniatura = fotoMiniatura;
    }

    public Blob getFotoCabecera() {
        return fotoCabecera;
    }

    public void setFotoCabecera(Blob fotoCabecera) {
        this.fotoCabecera = fotoCabecera;
    }

    public int getCantPuntosPrimerLugar() {
        return cantPuntosPrimerLugar;
    }

    public void setCantPuntosPrimerLugar(int cantPuntosPrimerLugar) {
        this.cantPuntosPrimerLugar = cantPuntosPrimerLugar;
    }

    public boolean isActividadFinalizada() {
        return actividadFinalizada;
    }

    public void setActividadFinalizada(boolean actividadFinalizada) {
        this.actividadFinalizada = actividadFinalizada;
    }

    public boolean isActividadOculta() {
        return actividadOculta;
    }

    public void setActividadOculta(boolean actividadOculta) {
        this.actividadOculta = actividadOculta;
    }
}
