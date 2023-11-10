package com.example.proyectouwu.Beans;

import java.sql.Blob;

public class FotoEventoCarrusel {

    //ATRIBUTOS
    private int idFotoEventoCarrusel;
    private Evento evento=new Evento();
    private Blob foto;


    //GETTERS AND SETTERS

    public int getIdFotoEventoCarrusel() {
        return idFotoEventoCarrusel;
    }

    public void setIdFotoEventoCarrusel(int idFotoEventoCarrusel) {
        this.idFotoEventoCarrusel = idFotoEventoCarrusel;
    }

    public Evento getEvento() {
        return evento;
    }

    public void setEvento(Evento evento) {
        this.evento = evento;
    }

    public Blob getFoto() {
        return foto;
    }

    public void setFoto(Blob foto) {
        this.foto = foto;
    }
}
