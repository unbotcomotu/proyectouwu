package com.example.proyectouwu.Daos;

import com.example.proyectouwu.Beans.Reporte;

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

    public Reporte reportePorIdReporteNotificacion(int idReporte){
        String sql = "select u1.idUsuario,u1.nombre,u1.apellido,u1.fotoPerfil,u2.idUsuario,u2.nombre,u2.apellido,date(r.fechaHora),time(r.fechaHora) from reporte r inner join usuario u1 on r.idUsuarioReportado=u1.idUsuario inner join usuario u2 on r.idUsuarioQueReporta=u2.idUsuario where r.idReporte=?";
        try(Connection conn=this.getConnection(); PreparedStatement pstmt=conn.prepareStatement(sql)){
            pstmt.setInt(1,idReporte);
            try(ResultSet rs= pstmt.executeQuery()){
                if (rs.next()){
                    Reporte r=new Reporte();
                    r.getUsuarioReportado().setIdUsuario(rs.getInt(1));
                    r.getUsuarioReportado().setNombre(rs.getString(2));
                    r.getUsuarioReportado().setApellido(rs.getString(3));
                    r.getUsuarioReportado().setFotoPerfil(rs.getBlob(4));
                    r.getUsuarioQueReporta().setIdUsuario(rs.getInt(5));
                    r.getUsuarioQueReporta().setNombre(rs.getString(6));
                    r.getUsuarioQueReporta().setApellido(rs.getString(7));
                    r.setFecha(rs.getDate(7));
                    r.setHora(rs.getTime(8));
                    return r;
                }else{
                    return null;
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public Integer cantidadTotalReportados(){
        String sql = "select count(idReporte) from reporte";
        try(Connection conn=this.getConnection(); ResultSet rs=conn.createStatement().executeQuery(sql)) {
            if(rs.next()){
                return rs.getInt(1);
            }else{
                return 0;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

}
