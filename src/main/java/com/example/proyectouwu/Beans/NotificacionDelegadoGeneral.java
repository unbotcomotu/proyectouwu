package com.example.proyectouwu.Beans;

import javax.swing.*;
import java.sql.*;
import java.util.ArrayList;

public class NotificacionDelegadoGeneral {
    //ATRIBUTOS
    private int idNotificacion;
    private Date fechaNotificacion;
    private Time horaNotificacion;
    private String estado;
    private Reporte reporte=new Reporte();
    private Donacion donacion=new Donacion();
    private Usuario usuario=new Usuario();
    private Validacion validacion=new Validacion();

    //GETTERS AND SETTERS


    public int getIdNotificacion() {
        return idNotificacion;
    }

    public void setIdNotificacion(int idNotificacion) {
        this.idNotificacion = idNotificacion;
    }

    public Date getFechaNotificacion() {
        return fechaNotificacion;
    }

    public void setFechaNotificacion(Date fechaNotificacion) {
        this.fechaNotificacion = fechaNotificacion;
    }

    public Time getHoraNotificacion() {
        return horaNotificacion;
    }

    public void setHoraNotificacion(Time horaNotificacion) {
        this.horaNotificacion = horaNotificacion;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public Reporte getReporte() {
        return reporte;
    }

    public void setReporte(Reporte reporte) {
        this.reporte = reporte;
    }

    public Donacion getDonacion() {
        return donacion;
    }

    public void setDonacion(Donacion donacion) {
        this.donacion = donacion;
    }

    public Usuario getUsuario() {
        return usuario;
    }

    public void setUsuario(Usuario usuario) {
        this.usuario = usuario;
    }

    public Validacion getValidacion() {
        return validacion;
    }

    public void setValidacion(Validacion validacion) {
        this.validacion = validacion;
    }
}
