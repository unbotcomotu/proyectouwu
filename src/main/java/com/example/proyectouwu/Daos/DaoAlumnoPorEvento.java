package com.example.proyectouwu.Daos;

import com.example.proyectouwu.Beans.Evento;

import java.sql.*;
import java.util.ArrayList;

public class DaoAlumnoPorEvento {
    private Connection conn;
    {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn= DriverManager.getConnection("jdbc:mysql://localhost:3306/proyecto","root","root");
        } catch (ClassNotFoundException | SQLException e) {
            throw new RuntimeException(e);
        }
    }
    public String verificarApoyo(int idEvento,int idUsuario){
        String sql="select estadoApoyo from AlumnoPorEvento where idAlumno=? and idEvento=?";
        try(PreparedStatement pstmt= conn.prepareStatement(sql)){
            pstmt.setInt(1,idUsuario);
            pstmt.setInt(2,idEvento);
            try(ResultSet rs=pstmt.executeQuery()){
                if(rs.next()){
                    return rs.getString(1);
                }else{
                    return null;
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    public ArrayList<Evento> listarEventosPorUsuario(int idUsuario){
        ArrayList<Evento>listaEventos=new ArrayList<>();
        String sql="select e.idEvento,e.idActividad,e.idLugarEvento,e.titulo,e.fecha,e.hora,e.descripcionEventoActivo,e.fraseMotivacional,e.eventoFinalizado,e.eventoOculto,e.resumen,e.resultadoEvento from AlumnoPorEvento ae inner join Evento e on ae.idEvento=e.idEvento where idAlumno=?";
        try(PreparedStatement pstmt= conn.prepareStatement(sql)){
            pstmt.setInt(1,idUsuario);
            try(ResultSet rs=pstmt.executeQuery()){
                while(rs.next()){
                    Evento e=new Evento();
                    e.setIdEvento(rs.getInt(1));
                    e.setIdActividad(rs.getInt(2));
                    e.setLugarEvento(rs.getInt(3));
                    e.setTitulo(rs.getString(4));
                    e.setFecha(rs.getDate(5));
                    e.setHora(rs.getTime(6));
                    e.setDescripcionEventoActivo(rs.getString(7));
                    e.setFraseMotivacional(rs.getString(8));
                    e.setEventoFinalizado(rs.getBoolean(9));
                    e.setEventoOculto(rs.getBoolean(10));
                    e.setResumen(rs.getString(11));
                    e.setResultadoEvento(rs.getString(12));
                    listaEventos.add(e);
                }return listaEventos;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
