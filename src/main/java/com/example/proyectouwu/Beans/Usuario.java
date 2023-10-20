package com.example.proyectouwu.Beans;

import java.sql.Date;
import java.sql.Time;

public class Usuario {
    private int idUsuario;
    private int idCondicion;
    private int idRol;
    private String nombre;
    private String apellido;
    private String correo;
    private String contrasena;
    private String codigoPUCP;
    private boolean registrado;
    private Foto fotoPerfil;
    private Foto fotoSeguro;
    private String descripcionPerfil;
    private boolean recibioKit;
    private Date fechaRegistro;
    private Time horaRegistro;
}
