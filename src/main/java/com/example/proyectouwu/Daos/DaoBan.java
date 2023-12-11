package com.example.proyectouwu.Daos;

import java.io.IOException;
import java.sql.*;

public class DaoBan extends DaoPadre {
    public boolean usuarioBaneadoPorId(int idUsuario){
        String sql = "select * from ban where idUsuario=?";

        try(Connection conn=this.getConnection(); PreparedStatement pstmt=conn.prepareStatement(sql)){
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

        String sql = "select motivoBan from ban where idUsuario=?";

        try(Connection conn=this.getConnection(); PreparedStatement pstmt=conn.prepareStatement(sql)){
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

    public Integer cantidadTotalBaneados(){
        String sql = "select count(idBan) from ban";
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

    public Integer cantidadBaneadosHaceNdias(int n){
        String sql = "select count(idBan) from ban where day(now())-day(fechaHora)=? group by day(fechaHora)";
        try(Connection conn=this.getConnection(); PreparedStatement pstmt=conn.prepareStatement(sql)) {
            pstmt.setInt(1,n);
            try (ResultSet rs=pstmt.executeQuery()){
                if(rs.next()){
                    return rs.getInt(1);
                }else{
                    return 0;
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void  banearPorId(String idUsuarioABanear,String motivoBan){
        String sql = "insert into ban ( idUsuario, motivoBan, fechaHora) values (?, ?,Now())";
        try (Connection conn=this.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
            //pstmt.setInt(1,idUser);
            pstmt.setString(1,idUsuarioABanear); //nuevos usuarios se registran como alumnos
            pstmt.setString(2,motivoBan); //Luego tenemos que modificar esto
            pstmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void  banearPorId(String idUsuarioABanear,String motivoBan,String idDelegadoActividadReemplazar,String idActividad){
        String sql = "insert into ban ( idUsuario, motivoBan, fechaHora) values (?, ?,Now())";
        try (Connection conn=this.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1,idUsuarioABanear);
            pstmt.setString(2,motivoBan);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            return;
        }sql="update usuario set rol='Alumno' where idUsuario=?";
        try(Connection conn=this.getConnection(); PreparedStatement pstmt= conn.prepareStatement(sql)){
            pstmt.setString(1,idUsuarioABanear);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            return;
        }sql="update usuario set rol='Delegado de Actividad' where idUsuario=?";
        try(Connection conn=this.getConnection(); PreparedStatement pstmt= conn.prepareStatement(sql)){
            pstmt.setString(1,idDelegadoActividadReemplazar);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            return;
        }sql="update actividad set idDelegadoDeActividad=? where idActividad=?";
        try(Connection conn=this.getConnection(); PreparedStatement pstmt= conn.prepareStatement(sql)){
            pstmt.setString(1,idDelegadoActividadReemplazar);
            pstmt.setString(2,idActividad);
            pstmt.executeUpdate();
        }catch (SQLException e) {
            return;
        }
    }

}
