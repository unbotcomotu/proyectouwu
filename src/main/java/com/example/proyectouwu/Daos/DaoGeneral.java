package com.example.proyectouwu.Daos;

import java.sql.*;

public class DaoGeneral {
    private Connection conn;
    {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn= DriverManager.getConnection("jdbc:mysql://localhost:3306/hr","root","root");
        } catch (ClassNotFoundException | SQLException e) {
            throw new RuntimeException(e);
        }
    }
    public int idRolUsuarioPorId(int idUsuario){
        String sql="select idRol from Usuario where idUsuario=?";
        try(PreparedStatement pstmt= conn.prepareStatement(sql)){
            pstmt.setInt(1,idUsuario);
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


}
