package com.example.proyectouwu.Beans;

import java.sql.Blob;
import java.sql.Date;
import java.sql.Time;

public class Donacion {
    //ATRIBUTOS
    private Integer idDonacion;
    private Usuario usuario=new Usuario();
    private String medioPago;
    private float monto;
    private Date fecha;
    private Time hora;
    private Blob captura;
    private Date fechaValidacion;
    private Time horaValidacion;
    private String estadoDonacion;

    //GETTERS AND SETTERS


    public Integer getIdDonacion() {
        return idDonacion;
    }

    public void setIdDonacion(Integer idDonacion) {
        this.idDonacion = idDonacion;
    }

    public Usuario getUsuario() {
        return usuario;
    }

    public void setUsuario(Usuario usuario) {
        this.usuario = usuario;
    }

    public String getMedioPago() {
        return medioPago;
    }

    public void setMedioPago(String medioPago) {
        this.medioPago = medioPago;
    }

    public float getMonto() {
        return monto;
    }

    public void setMonto(float monto) {
        this.monto = monto;
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

    public Blob getCaptura() {
        return captura;
    }

    public void setCaptura(Blob captura) {
        this.captura = captura;
    }

    public Date getFechaValidacion() {
        return fechaValidacion;
    }

    public void setFechaValidacion(Date fechaValidacion) {
        this.fechaValidacion = fechaValidacion;
    }

    public Time getHoraValidacion() {
        return horaValidacion;
    }

    public void setHoraValidacion(Time horaValidacion) {
        this.horaValidacion = horaValidacion;
    }

    public String getEstadoDonacion() {
        return estadoDonacion;
    }

    public void setEstadoDonacion(String estadoDonacion) {
        this.estadoDonacion = estadoDonacion;
    }
}
