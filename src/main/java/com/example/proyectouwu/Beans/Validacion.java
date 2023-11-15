package com.example.proyectouwu.Beans;
import java.util.Date;

public class Validacion {
    //ATRIBUTOS
    private Integer idCorreoValidacion;
    private Usuario usuario=new Usuario();
    private String correo;
    private String tipo;
    private int codigoValidacion;
    private String codigoValidacion256;
    private Date  fechaHora;
    private boolean  linkEnviado;
    //METODOS OTROS


    //GETTERS AND SETTERS


    public Integer getIdCorreoValidacion() {
        return idCorreoValidacion;
    }

    public void setIdCorreoValidacion(Integer idCorreoValidacion) {
        this.idCorreoValidacion = idCorreoValidacion;
    }

    public Usuario getUsuario() {
        return usuario;
    }

    public void setUsuario(Usuario usuario) {
        this.usuario = usuario;
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

    public String getCodigoValidacion256() {
        return codigoValidacion256;
    }

    public void setCodigoValidacion256(String codigoValidacion256) {
        this.codigoValidacion256 = codigoValidacion256;
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
