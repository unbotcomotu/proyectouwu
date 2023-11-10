package com.example.proyectouwu.Beans;

import java.sql.Time;
import java.sql.Date;

public class MensajeChat {
    //ATRIBUTOS
    private int idMensajeChat;
    private Usuario usuario=new Usuario();
    private Evento evento=new Evento();
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

    public Usuario getUsuario() {
        return usuario;
    }

    public void setUsuario(Usuario usuario) {
        this.usuario = usuario;
    }

    public Evento getEvento() {
        return evento;
    }

    public void setEvento(Evento evento) {
        this.evento = evento;
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
