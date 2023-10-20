package com.example.proyectouwu.Beans;

import java.sql.Date;
import java.sql.Time;
import java.util.ArrayList;

public class Evento {
    private int idEvento;
    private int idActividad;
    private int resultadoEvento;
    private int lugarEvento;
    private String titulo;
    private Date fecha;
    private Time hora;
    private String descripcionEventoActivo;
    private String fraseMotivacional;
    private String resumen;
    private Foto fotoMiniatura;
    private ArrayList<Foto> carruselFotos;
    private boolean eventoFinalizado;
    private boolean eventoOculto;
}
