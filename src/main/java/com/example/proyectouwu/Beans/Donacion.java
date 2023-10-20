package com.example.proyectouwu.Beans;

import java.sql.Date;
import java.sql.Time;

public class Donacion {
    private int idDonacion;
    private int idUsuario;
    private int idMedioPago;
    private int monto;
    private Date fecha;
    private Time hora;
    private Foto captura;
    private Date fechaValidacion;
    private Time horaValidacion;
    private String estadoValidacion;
}
