package com.example.proyectouwu.Daos;

import com.example.proyectouwu.Beans.Actividad;

import java.sql.*;
import java.util.ArrayList;

public class ListaDeActividadesDao {
    private Connection conn;
    {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn= DriverManager.getConnection("jdbc:mysql://localhost:3306/hr","root","root");
        } catch (ClassNotFoundException | SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public int idDelegaturaPorIdDelegadoDeActividad(int idDelegadoDeActividad){
        String sql="select idActividad from Actividad where idDelegadoDeActividad=?";
        try(PreparedStatement pstmt= conn.prepareStatement(sql)){
            pstmt.setInt(1,idDelegadoDeActividad);
            try(ResultSet rs=pstmt.executeQuery()){
                if(rs.next()){
                    return rs.getInt(1);
                }else
                    return -1;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public ArrayList<Actividad>listarActividades(){
        ArrayList<Actividad>listaActividades=new ArrayList<>();
        String sql="select idActividad,idDelegadoDeActividad,nombre,fotoMiniatura,cantidadPuntosPrimerLugar,actividadFinalizada,actividadOculta from Actividad";
        try(ResultSet rs=conn.createStatement().executeQuery(sql);){
            while (rs.next()){
                Actividad a=new Actividad();
                a.setIdActividad(rs.getInt(1));
                a.setIdDelegadoDeActividad(rs.getInt(2));
                a.setNombre(rs.getString(3));
                a.setFotoMiniatura(rs.getBlob(4));
                a.setCantPuntosPrimerLugar(rs.getInt(5));
                a.setActividadFinalizada(rs.getBoolean(6));
                a.setActividadOculta(rs.getBoolean(7));
                listaActividades.add(a);
            }return listaActividades;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

}
