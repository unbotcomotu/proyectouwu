package com.example.proyectouwu.Beans;

import java.sql.Time;
import java.sql.Date;

public class Reporte {
    //ATRIBUTOS
    private int idReporte;
    private Usuario usuarioReportado=new Usuario();
    private Usuario usuarioQueReporta=new Usuario();
    private String motivoReporte;
    private Date fecha;
    private Time hora;

//GETTERS AND SETTERS

    public int getIdReporte() {
        return idReporte;
    }

    public void setIdReporte(int idReporte) {
        this.idReporte = idReporte;
    }

    public Usuario getUsuarioReportado() {
        return usuarioReportado;
    }

    public void setUsuarioReportado(Usuario usuarioReportado) {
        this.usuarioReportado = usuarioReportado;
    }

    public Usuario getUsuarioQueReporta() {
        return usuarioQueReporta;
    }

    public void setUsuarioQueReporta(Usuario usuarioQueReporta) {
        this.usuarioQueReporta = usuarioQueReporta;
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
