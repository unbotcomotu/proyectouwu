package com.example.proyectouwu.Daos;

import com.example.proyectouwu.Beans.Actividad;

import java.sql.*;
import java.util.ArrayList;

public class DaoActividad extends DaoPadre {
    //Atributos
    private Connection conn;

    {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn= DriverManager.getConnection("jdbc:mysql://localhost:3306/proyecto",super.getUser(),super.getPassword());
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

    public ArrayList<Actividad>listarActividades(String nombre){
        ArrayList<Actividad>listaActividades=new ArrayList<>();
        String sql="select idActividad,idDelegadoDeActividad,nombre,fotoMiniatura,cantidadPuntosPrimerLugar,actividadFinalizada,actividadOculta from actividad where lower(nombre) like ?";
        try(PreparedStatement pstmt=conn.prepareStatement(sql)){
            pstmt.setString(1,"%"+nombre+"%");
            try (ResultSet rs=pstmt.executeQuery()){
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
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    public ArrayList<Actividad>listarActividades(int idFiltroActividades,int idOrdenarActividades,int idUsuario){
        ArrayList<Actividad>listaActividades=new ArrayList<>();
        String sql="";
        if(idFiltroActividades==0){
            if(idOrdenarActividades==0){
                sql="select idActividad,idDelegadoDeActividad,nombre,fotoMiniatura,cantidadPuntosPrimerLugar,actividadFinalizada,actividadOculta from actividad order by nombre desc";
            }else{
                sql="select idActividad,idDelegadoDeActividad,nombre,fotoMiniatura,cantidadPuntosPrimerLugar,actividadFinalizada,actividadOculta from actividad order by nombre asc";
            }
        }else if(idFiltroActividades==1){
            if(idOrdenarActividades==0){
                sql="select a.idActividad,a.idDelegadoDeActividad,a.nombre,a.fotoMiniatura,a.cantidadPuntosPrimerLugar,a.actividadFinalizada,a.actividadOculta from actividad a inner join evento e on a.idActividad=e.idActividad group by e.idActividad order by count(e.idEvento) desc";
            }else{
                sql="select a.idActividad,a.idDelegadoDeActividad,a.nombre,a.fotoMiniatura,a.cantidadPuntosPrimerLugar,a.actividadFinalizada,a.actividadOculta from actividad a inner join evento e on a.idActividad=e.idActividad group by e.idActividad order by count(e.idEvento) asc";
            }
        }else if(idFiltroActividades==2){
            if(idOrdenarActividades==0){
                sql="select idActividad,idDelegadoDeActividad,nombre,fotoMiniatura,cantidadPuntosPrimerLugar,actividadFinalizada,actividadOculta from actividad order by cantidadPuntosPrimerLugar desc";
            }else{
                sql="select idActividad,idDelegadoDeActividad,nombre,fotoMiniatura,cantidadPuntosPrimerLugar,actividadFinalizada,actividadOculta from actividad order by cantidadPuntosPrimerLugar asc";
            }
        }else if(idFiltroActividades==3){
            if(idOrdenarActividades==0){
                sql="select idActividad,idDelegadoDeActividad,nombre,fotoMiniatura,cantidadPuntosPrimerLugar,actividadFinalizada,actividadOculta from actividad order by if(actividadFinalizada is true, 0, 1)";
            }else{
                sql="select idActividad,idDelegadoDeActividad,nombre,fotoMiniatura,cantidadPuntosPrimerLugar,actividadFinalizada,actividadOculta from actividad order by if(actividadFinalizada is true, 1, 0)";
            }
        }else if(idFiltroActividades==4){
            if(idOrdenarActividades==0){
                sql="select idActividad,idDelegadoDeActividad,nombre,fotoMiniatura,cantidadPuntosPrimerLugar,actividadFinalizada,actividadOculta from actividad order by if(actividadOculta is true, 0, 1)";
            }else{
                sql="select idActividad,idDelegadoDeActividad,nombre,fotoMiniatura,cantidadPuntosPrimerLugar,actividadFinalizada,actividadOculta from actividad order by if(actividadOculta is true, 1, 0)";
            }
        }else{
            if(idOrdenarActividades==0){
                sql="select idActividad,idDelegadoDeActividad,nombre,fotoMiniatura,cantidadPuntosPrimerLugar,actividadFinalizada,actividadOculta from actividad order by if(idDelegadoDeActividad="+idUsuario+",0,1)";
            }else{
                sql="select idActividad,idDelegadoDeActividad,nombre,fotoMiniatura,cantidadPuntosPrimerLugar,actividadFinalizada,actividadOculta from actividad order by if(idDelegadoDeActividad="+idUsuario+",1,0)";
            }
        }
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

