package com.example.proyectouwu.Daos;

import java.sql.*;

public class DaoReporte extends DaoPadre {
    public Integer cantidadReportadosHaceNdias(int n){
        String sql = "select count(idReporte) from reporte where day(now())-day(fechaHora)=? group by day(fechaHora)";
        try(Connection conn=this.getConnection(); PreparedStatement pstmt=conn.prepareStatement(sql)){
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
