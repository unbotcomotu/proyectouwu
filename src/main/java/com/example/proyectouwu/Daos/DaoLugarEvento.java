package com.example.proyectouwu.Daos;

import com.example.proyectouwu.Beans.LugarEvento;

import java.sql.*;
import java.util.ArrayList;

public class DaoLugarEvento extends DaoPadre  {
    private Connection conn;
    {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn= DriverManager.getConnection("jdbc:mysql://localhost:3306/proyecto",super.getUser(),super.getPassword());
        } catch (ClassNotFoundException | SQLException e) {
            throw new RuntimeException(e);
        }
    }
    public ArrayList<LugarEvento> listarLugares(){
        ArrayList<LugarEvento>listaLugares=new ArrayList<>();
        String sql="select * from LugarEvento";
        try(ResultSet rs=conn.createStatement().executeQuery(sql)){
            while(rs.next()){
                LugarEvento l=new LugarEvento();
                l.setIdLugarEvento(rs.getInt(1));
                l.setLugar(rs.getString(2));
                listaLugares.add(l);
            }return listaLugares;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    public String lugarPorID(int idLugarEvento){
        String sql="select lugar from LugarEvento where idLugarEvento=?";
        try(PreparedStatement pstmt= conn.prepareStatement(sql)){
            pstmt.setInt(1,idLugarEvento);
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
