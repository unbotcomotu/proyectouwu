package com.example.proyectouwu.Beans;

import java.sql.Time;
import java.sql.Date;

public class MensajeChat {
    //ATRIBUTOS
    private int idMensajeChat;
    private int idUsuario;
    private int idEvento;
    private String mensaje;
    private Date fecha;
    private Time hora;

    //GETTERS AND SETTERS
    public int getIdMensajeChat() {
        return idMensajeChat;
    }

    public void setIdMensajeChat(int idMensajeChat) {
        this.idMensajeChat = idMensajeChat;
    }

    public int getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(int idUsuario) {
        this.idUsuario = idUsuario;
    }

    public int getIdEvento() {
        return idEvento;
    }

    public void setIdEvento(int idEvento) {
        this.idEvento = idEvento;
    }

    public String getMensaje() {
        return mensaje;
    }

    public void setMensaje(String mensaje) {
        this.mensaje = mensaje;
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
