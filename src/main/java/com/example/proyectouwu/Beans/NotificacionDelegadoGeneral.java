package com.example.proyectouwu.Beans;

import java.sql.*;
import java.util.ArrayList;

public class NotificacionDelegadoGeneral {
    private int idNotificacion;
    private Date fechaNotificacion;
    private Time horaNotificacion;
    private int idReporte;
    private int idDonacion;
    private int idUsuario;

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

    public int getIdReporte() {
        return idReporte;
    }

    public void setIdReporte(int idReporte) {
        this.idReporte = idReporte;
    }

    public int getIdDonacion() {
        return idDonacion;
    }

    public void setIdDonacion(int idDonacion) {
        this.idDonacion = idDonacion;
    }

    public int getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(int idUsuario) {
        this.idUsuario = idUsuario;
    }

    }
