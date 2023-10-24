package com.example.proyectouwu.Beans;

import java.sql.Time;
import java.sql.Date;

public class Reporte {
    private int idReporte;
    private int idUsuarioReportado;
    private int idUsuarioQueReporta;
    private String motivoReporte;
    private Date fecha;
    private Time hora;

    public String getNombreReportado() {
        return nombreReportado;
    }

    public void setNombreReportado(String nombreReportado) {
        this.nombreReportado = nombreReportado;
    }

    public String getNombreReportante() {
        return nombreReportante;
    }

    public void setNombreReportante(String nombreReportante) {
        this.nombreReportante = nombreReportante;
    }

    private String nombreReportado;

    private String nombreReportante;

    public int getIdReporte() {
        return idReporte;
    }

    public void setIdReporte(int idReporte) {
        this.idReporte = idReporte;
    }

    public int getIdUsuarioReportado() {
        return idUsuarioReportado;
    }

    public void setIdUsuarioReportado(int idUsuarioReportado) {
        this.idUsuarioReportado = idUsuarioReportado;
    }

    public int getIdUsuarioQueReporta() {
        return idUsuarioQueReporta;
    }

    public void setIdUsuarioQueReporta(int idUsuarioQueReporta) {
        this.idUsuarioQueReporta = idUsuarioQueReporta;
    }

    public String getMotivoReporte() {
        return motivoReporte;
    }

    public void setMotivoReporte(String motivoReporte) {
        this.motivoReporte = motivoReporte;
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
