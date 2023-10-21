package com.example.proyectouwu.Beans;

import java.sql.Blob;

public class FotoEventoCarrusel {
    private int idFotoEventoCarrusel;
    private int idEvento;
    private Blob foto;

    public int getIdFotoEventoCarrusel() {
        return idFotoEventoCarrusel;
    }

    public void setIdFotoEventoCarrusel(int idFotoEventoCarrusel) {
        this.idFotoEventoCarrusel = idFotoEventoCarrusel;
    }

    public int getIdEvento() {
        return idEvento;
    }

    public void setIdEvento(int idEvento) {
        this.idEvento = idEvento;
    }

    public Blob getFoto() {
        return foto;
    }

    public void setFoto(Blob foto) {
        this.foto = foto;
    }
}
