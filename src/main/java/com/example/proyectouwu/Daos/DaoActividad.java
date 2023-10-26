package com.example.proyectouwu.Daos;

import com.example.proyectouwu.Beans.Actividad;

import java.sql.*;
import java.util.ArrayList;

public class DaoActividad {
    private Connection conn;
    {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn= DriverManager.getConnection("jdbc:mysql://localhost:3306/proyecto","root","123456");
        } catch (ClassNotFoundException | SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public Integer idDelegaturaPorIdDelegadoDeActividad(int idDelegadoDeActividad){
        String sql="select idActividad from actividad where idDelegadoDeActividad=?";
        try(PreparedStatement pstmt= conn.prepareStatement(sql)){
            pstmt.setInt(1,idDelegadoDeActividad);
            try(ResultSet rs=pstmt.executeQuery()){
                if(rs.next()){
                    return rs.getInt(1);
                }else
                    return null;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public Integer idDelegadoDeActividadPorActividad(int idActividad){
        String sql="select idDelegadoDeActividad from actividad where idActividad=?";
        try(PreparedStatement pstmt= conn.prepareStatement(sql)){
            pstmt.setInt(1,idActividad);
            try(ResultSet rs=pstmt.executeQuery()){
                if(rs.next()){
                    return rs.getInt(1);
                }else
                    return null;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    public ArrayList<Actividad>listarActividades(){
        ArrayList<Actividad>listaActividades=new ArrayList<>();
        String sql="select idActividad,idDelegadoDeActividad,nombre,fotoMiniatura,cantidadPuntosPrimerLugar,actividadFinalizada,actividadOculta from actividad";
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

    public String nombreActividadPorID(int idActividad){
        String sql="select nombre from Actividad where idActividad=?";
        try(PreparedStatement pstmt= conn.prepareStatement(sql)){
            pstmt.setInt(1,idActividad );
            try(ResultSet rs=pstmt.executeQuery()){
                if(rs.next()){
                    return rs.getString(1);
                }else
                    return null;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public String cantidadEventosPorActividad(int idActividad){
        String sql="select count(idEvento) from Actividad a inner join Evento e on a.idActividad=e.idActividad where a.idActividad=? group by a.idActividad";
        try(PreparedStatement pstmt= conn.prepareStatement(sql)){
            pstmt.setInt(1,idActividad);
            try(ResultSet rs=pstmt.executeQuery()){
                if(rs.next()){
                    return rs.getString(1);
                }else
                    return null;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}

