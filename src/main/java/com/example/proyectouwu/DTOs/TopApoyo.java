package com.example.proyectouwu.DTOs;

import com.example.proyectouwu.Beans.Usuario;

public class TopApoyo {
    Usuario usuario=new Usuario();
    Integer cantidadEventosApoyados;

    public Usuario getUsuario() {
        return usuario;
    }

    public void setUsuario(Usuario usuario) {
        this.usuario = usuario;
    }

    public Integer getCantidadEventosApoyados() {
        return cantidadEventosApoyados;
    }

    public void setCantidadEventosApoyados(Integer cantidadEventosApoyados) {
        this.cantidadEventosApoyados = cantidadEventosApoyados;
    }
}
