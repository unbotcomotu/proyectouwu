package com.example.proyectouwu.Daos;

import com.example.proyectouwu.Beans.Donacion;

import java.sql.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

public class DaoDonacion {
    private Connection conn;
    {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn= DriverManager.getConnection("jdbc:mysql://localhost:3306/hr","root","root");
        } catch (ClassNotFoundException | SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public ArrayList<Donacion>listarDonaciones(int idUsuario){
        ArrayList<Donacion>listaDonaciones=new ArrayList<>();
        String sql="select * from Donacion where idUsuario=?";
        try(PreparedStatement pstmt= conn.prepareStatement(sql)){
            pstmt.setInt(1,idUsuario);
            try(ResultSet rs=pstmt.executeQuery()){
                while(rs.next()){
                    Donacion d=new Donacion();
                    d.setIdDonacion(rs.getInt(1));
                    d.setIdUsuario(rs.getInt(2));
                    d.setMedioPago(rs.getString(3));
                    d.setMonto(rs.getFloat(4));
                    String dateTime[]=rs.getString(5).split(" ");
                    d.setFecha(Date.valueOf(dateTime[0]));
                    d.setHora(Time.valueOf(dateTime[1]));
                    d.setCaptura(rs.getBlob(6));
                    d.setEstadoDonacion((rs.getString(7)));
                    String dateTime2[]=rs.getString(5).split(" ");
                    d.setFechaValidacion(Date.valueOf(dateTime2[0]));
                    d.setHoraValidacion(Time.valueOf(dateTime2[1]));
                    listaDonaciones.add(d);
                }return listaDonaciones;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}