package com.example.proyectouwu.Beans;
import java.util.Date;

public class Validacion {
    //ATRIBUTOS
    private int idCorreoValidacion;
    private int idUsuario;
    private String correo;
    private String tipo;
    private int codigoValidacion;
    private Date  fechaHora;
    private boolean  linkEnviado;
    //METODOS OTROS


    //GETTERS AND SETTERS
    public int getIdCorreoValidacion() {
        return idCorreoValidacion;
    }

    public void setIdCorreoValidacion(int idCorreoValidacion) {
        this.idCorreoValidacion = idCorreoValidacion;
    }

    public int getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(int idUsuario) {
        this.idUsuario = idUsuario;
    }

    public String getCorreo() {
        return correo;
    }

    public void setCorreo(String correo) {
        this.correo = correo;
    }

    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }

    public int getCodigoValidacion() {
        return codigoValidacion;
    }

    public void setCodigoValidacion(int codigoValidacion) {
        this.codigoValidacion = codigoValidacion;
    }

    public Date getFechaHora() {
        return fechaHora;
    }

    public void setFechaHora(Date fechaHora) {
        this.fechaHora = fechaHora;
    }

    public boolean isLinkEnviado() {
        return linkEnviado;
    }

    public void setLinkEnviado(boolean linkEnviado) {
        this.linkEnviado = linkEnviado;
    }
}
