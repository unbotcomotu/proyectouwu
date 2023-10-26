package com.example.proyectouwu.Daos;

import java.sql.*;

public class DaoBan {
    public boolean usuarioBaneadoPorId(int idUsuario){
        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
        }catch (ClassNotFoundException e){
            throw new RuntimeException(e);
        }

        String sql = "select * from ban where idUsuario=?";

        try(Connection conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/proyecto","root","123456");
            PreparedStatement pstmt=conn.prepareStatement(sql)){
            pstmt.setInt(1,idUsuario);
            try(ResultSet rs = pstmt.executeQuery()){
                if(rs.next()){
                    return true;
                }else{
                    return false;
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public String obtenerMotivoBanPorId(int idUsuario){
        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
        }catch (ClassNotFoundException e){
            throw new RuntimeException(e);
        }

        String sql = "select motivoBan from ban where idUsuario=?";

        try(Connection conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/proyecto","root","123456");
            PreparedStatement pstmt=conn.prepareStatement(sql)){
            pstmt.setInt(1,idUsuario);
            try(ResultSet rs = pstmt.executeQuery()){
                if(rs.next()){
                    return rs.getString(1);
                }else{
                    return "";
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
