package com.example.proyectouwu.Beans;

import java.sql.Blob;
import java.sql.Date;
import java.sql.Time;

public class Usuario {
    private int idUsuario;
    private String rol;
    private String nombre;
    private String apellido;
    private String correo;
    private String contrasena;
    private String codigoPUCP;
    private String estadoRegistro = "Pendiente";
    private Date fechaRegistro;
    private Time horaRegistro;
    private String condicion;
    private Blob fotoPerfil;
    private Blob fotoSeguro;
    private String descripcionPerfil;
    private boolean recibioKit;

    public int getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(int idUsuario) {
        this.idUsuario = idUsuario;
    }

    public String getRol() {
        return rol;
    }

    public void setRol(String rol) {
        this.rol = rol;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getApellido() {
        return apellido;
    }

    public void setApellido(String apellido) {
        this.apellido = apellido;
    }

    public String getCorreo() {
        return correo;
    }

    public void setCorreo(String correo) {
        this.correo = correo;
    }

    public String getContrasena() {
        return contrasena;
    }

    public void setContrasena(String contrasena) {
        this.contrasena = contrasena;
    }

    public String getCodigoPUCP() {
        return codigoPUCP;
    }

    public void setCodigoPUCP(String codigoPUCP) {
        this.codigoPUCP = codigoPUCP;
    }

    public String getEstadoRegistro() {
        return estadoRegistro;
    }

    public void setEstadoRegistro(String estadoRegistro) {
        this.estadoRegistro = estadoRegistro;
    }

    public Date getFechaRegistro() {
        return fechaRegistro;
    }

    public void setFechaRegistro(Date fechaRegistro) {
        this.fechaRegistro = fechaRegistro;
    }

    public Time getHoraRegistro() {
        return horaRegistro;
    }

    public void setHoraRegistro(Time horaRegistro) {
        this.horaRegistro = horaRegistro;
    }

    public String getCondicion() {
        return condicion;
    }

    public void setCondicion(String condicion) {
        this.condicion = condicion;
    }

    public Blob getFotoPerfil() {
        return fotoPerfil;
    }

    public void setFotoPerfil(Blob fotoPerfil) {
        this.fotoPerfil = fotoPerfil;
    }

    public Blob getFotoSeguro() {
        return fotoSeguro;
    }

    public void setFotoSeguro(Blob fotoSeguro) {
        this.fotoSeguro = fotoSeguro;
    }

    public String getDescripcionPerfil() {
        return descripcionPerfil;
    }

    public void setDescripcionPerfil(String descripcionPerfil) {
        this.descripcionPerfil = descripcionPerfil;
    }

    public boolean isRecibioKit() {
        return recibioKit;
    }

    public void setRecibioKit(boolean recibioKit) {
        this.recibioKit = recibioKit;
    }
}
