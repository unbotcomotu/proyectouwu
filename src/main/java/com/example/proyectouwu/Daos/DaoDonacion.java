package com.example.proyectouwu.Daos;

import com.example.proyectouwu.Beans.Donacion;

import java.sql.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

public class DaoDonacion extends DaoPadre  {
    private Connection conn;
    {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn= DriverManager.getConnection("jdbc:mysql://localhost:3306/proyecto",super.getUser(),super.getPassword());
        } catch (ClassNotFoundException | SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public ArrayList<Donacion>listarDonacionesVistaUsuario(int idUsuario){
        ArrayList<Donacion>listaDonaciones=new ArrayList<>();
        String sql="select idDonacion,idUsuario,medioPago,monto,date(fechaHora) from Donacion where idUsuario=? and estadoDonacion='Validado' order by fechaHora desc";
        try(PreparedStatement pstmt= conn.prepareStatement(sql)){
            pstmt.setInt(1,idUsuario);
            try(ResultSet rs=pstmt.executeQuery()){
                while(rs.next()){
                    Donacion d=new Donacion();
                    d.setIdDonacion(rs.getInt(1));
                    d.setIdUsuario(rs.getInt(2));
                    d.setMedioPago(rs.getString(3));
                    d.setMonto(rs.getFloat(4));
                    d.setFecha(Date.valueOf(rs.getString(5)));
                    listaDonaciones.add(d);
                }return listaDonaciones;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public float totalDonaciones(int idUsuario){
        String sql="select sum(monto) from Donacion where idUsuario=? and estadoDonacion='Validado' group by idUsuario";
        try(PreparedStatement pstmt= conn.prepareStatement(sql)){
            pstmt.setInt(1,idUsuario);
            try(ResultSet rs=pstmt.executeQuery()){
                if(rs.next()){
                    return rs.getFloat(1);
                }else
                    return 0;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}