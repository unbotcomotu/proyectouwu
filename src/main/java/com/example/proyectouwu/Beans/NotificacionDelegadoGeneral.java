package com.example.proyectouwu.Beans;

import java.sql.*;
import java.util.ArrayList;

public class NotificacionDelegadoGeneral {
    private int idNotificacion;
    private Date fechaNotificacion;
    private Time horaNotificacion;
    private int idReporte;
    private int idDonacion;
    private int idUsuario;

    public int getIdNotificacion() {
        return idNotificacion;
    }

    public void setIdNotificacion(int idNotificacion) {
        this.idNotificacion = idNotificacion;
    }

    public Date getFechaNotificacion() {
        return fechaNotificacion;
    }

    public void setFechaNotificacion(Date fechaNotificacion) {
        this.fechaNotificacion = fechaNotificacion;
    }

    public Time getHoraNotificacion() {
        return horaNotificacion;
    }

    public void setHoraNotificacion(Time horaNotificacion) {
        this.horaNotificacion = horaNotificacion;
    }

    public int getIdReporte() {
        return idReporte;
    }

    public void setIdReporte(int idReporte) {
        this.idReporte = idReporte;
    }

    public int getIdDonacion() {
        return idDonacion;
    }

    public void setIdDonacion(int idDonacion) {
        this.idDonacion = idDonacion;
    }

    public int getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(int idUsuario) {
        this.idUsuario = idUsuario;
    }


    public ArrayList<Usuario> listar_usuario(){

        ArrayList<Usuario> listaUsuario = new ArrayList<>();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }

        String url = "jdbc:mysql://localhost:3306/proyecto";
        String username = "root";
        String password = "root";

        String sql = "select nombre, apellido, codigoPUCP, correo from Usuarios where condicion = pendiente";


        try (Connection conn = DriverManager.getConnection(url, username, password);
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                Usuario usuario = new Usuario();
                Usuario.setNombre(rs.getString(1));
                Usuario.setApellido(rs.getString(2));
                Usuario.setMinSalary(rs.getInt(3));
                Usuario.setMaxSalary(rs.getInt(4));

                Usuario.add(usuario);
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return lista;

    }



    }
