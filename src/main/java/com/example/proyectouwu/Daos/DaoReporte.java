package com.example.proyectouwu.Daos;

import java.sql.*;

public class DaoReporte extends DaoPadre {
    private Connection conn;
    {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn= DriverManager.getConnection("jdbc:mysql://localhost:3306/proyecto",super.getUser(),super.getPassword());
        } catch (ClassNotFoundException | SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public Integer cantidadReportadosHaceNdias(int n){
        String sql = "select count(idReporte) from reporte where day(current_date())-day(fechaHora)=? group by day(fechaHora)";
        try(PreparedStatement pstmt=conn.prepareStatement(sql)){
            pstmt.setInt(1,n);
            try(ResultSet rs= pstmt.executeQuery()){
                if (rs.next()){
                    return rs.getInt(1);
                }else{
                    return 0;
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void reportaUsuario(int idUsuario, String motivoReporte){


    }

}
