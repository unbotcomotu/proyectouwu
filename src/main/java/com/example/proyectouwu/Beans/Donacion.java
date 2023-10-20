package com.example.proyectouwu.Beans;

import java.sql.Date;
import java.sql.Time;

public class Donacion {
    private int idDonacion;
    private int idUsuario;
    private String medioPago;
    private float monto;
    private Date fecha;
    private Time hora;
    private Foto captura;
    private Date fechaValidacion;
    private Time horaValidacion;
    private String estadoDonacion;
}
