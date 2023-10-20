package com.example.proyectouwu.Beans;

import java.sql.Blob;
import java.util.ArrayList;

public class Actividad {
    private int idActividad;
    private int idDelegadoDeActividad;
    private String nombre;
    private String descripcion;
    private Blob fotoMiniatura;
    private Blob fotoCabecera;
    private int cantPuntosPrimerLugar;
    private boolean actividadFinalizada;
    private boolean actividadOculta;
    private String resumenActividad;

    public int getIdActividad() {
        return idActividad;
    }

    public void setIdActividad(int idActividad) {
        this.idActividad = idActividad;
    }

    public int getIdDelegadoDeActividad() {
        return idDelegadoDeActividad;
    }

    public void setIdDelegadoDeActividad(int idDelegadoDeActividad) {
        this.idDelegadoDeActividad = idDelegadoDeActividad;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
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

    public String getResumenActividad() {
        return resumenActividad;
    }

    public void setResumenActividad(String resumenActividad) {
        this.resumenActividad = resumenActividad;
    }
}
