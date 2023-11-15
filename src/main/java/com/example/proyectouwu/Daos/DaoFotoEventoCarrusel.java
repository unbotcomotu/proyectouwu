package com.example.proyectouwu.Daos;

import java.io.IOException;
import java.io.InputStream;
import java.sql.*;
import java.util.ArrayList;

public class DaoFotoEventoCarrusel extends DaoPadre {
    public ArrayList<Blob> carruselFotosPorID(int idEvento){
        ArrayList<Blob>carrusel=new ArrayList<>();
        String sql="select foto from fotoeventocarrusel where idEvento=?";
        try(Connection conn=this.getConnection(); PreparedStatement pstmt= conn.prepareStatement(sql)){
            pstmt.setInt(1,idEvento);
            try(ResultSet rs=pstmt.executeQuery()){
                while (rs.next()){
                    carrusel.add(rs.getBlob(1));
                }return carrusel;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public ArrayList<Integer> idsFotosCarrusel(int idEvento){
        ArrayList<Integer> lista=new ArrayList<>();
        String sql="select idFotoEventoCarrusel from fotoeventocarrusel where idEvento=?";
        try(Connection conn=this.getConnection(); PreparedStatement pstmt= conn.prepareStatement(sql)){
            pstmt.setInt(1,idEvento);
            try(ResultSet rs=pstmt.executeQuery()){
                while (rs.next()){
                    lista.add(rs.getInt(1));
                }return lista;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    public void actualizarImagenCarrusel(int idFotoEventoCarrusel, InputStream foto){
        String sql="update fotoeventocarrusel set foto=? where idFotoEventoCarrusel=?";
        try(Connection conn=this.getConnection(); PreparedStatement pstmt= conn.prepareStatement(sql)){
            pstmt.setBinaryStream(1,foto,foto.available());
            pstmt.setInt(2,idFotoEventoCarrusel);
            pstmt.executeUpdate();
        } catch (SQLException | IOException e) {
            throw new RuntimeException(e);
        }
    }
}
