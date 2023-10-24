package com.example.proyectouwu.Daos;

import com.example.proyectouwu.Beans.AlumnoPorEvento;
import com.example.proyectouwu.Beans.Usuario;

import java.sql.*;
import java.util.ArrayList;

public class DaoNotificacionesDeleActividad {


    public ArrayList<AlumnoPorEvento> listarSolicitudesDeApoyo(){

        ArrayList<AlumnoPorEvento> listaSolicitudesApoyo = new ArrayList<>();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }

        String url = "jdbc:mysql://localhost:3306/proyecto";
        String username = "root";
        String password = "root"; //Cambiar segun tu contraseña

        String sql = "select idUsuario  from alumnoporevento where estadoApoyo = 'En espera'";


        try (Connection conn = DriverManager.getConnection(url, username, password);
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()){
                AlumnoPorEvento alumnoPorEvento=new AlumnoPorEvento();
                alumnoPorEvento.setIdAlumno(rs.getInt(1));

                listaSolicitudesApoyo.add(alumnoPorEvento);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return listaSolicitudesApoyo;
    }


}
