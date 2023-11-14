package com.example.proyectouwu.DTOs;

import com.example.proyectouwu.Beans.Usuario;

public class TopDonador {
    private Usuario usuario;
    private float montoTotal;

    public Usuario getUsuario() {
        return usuario;
    }

    public void setUsuario(Usuario usuario) {
        this.usuario = usuario;
    }

    public float getMontoTotal() {
        return montoTotal;
    }

    public void setMontoTotal(float montoTotal) {
        this.montoTotal = montoTotal;
    }
}
