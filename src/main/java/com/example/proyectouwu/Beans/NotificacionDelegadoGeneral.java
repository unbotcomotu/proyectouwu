package com.example.proyectouwu.Beans;

import java.sql.*;
import java.util.ArrayList;

public class NotificacionDelegadoGeneral {
    //ATRIBUTOS
    private int idNotificacion;
    private Date fechaNotificacion;
    private Time horaNotificacion;
    private Reporte reporte=new Reporte();
    private Donacion donacion=new Donacion();
    private Usuario usuario=new Usuario();

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
}
