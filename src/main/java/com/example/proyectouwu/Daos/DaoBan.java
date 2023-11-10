package com.example.proyectouwu.Daos;

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

    public void  banearPorId(int idUsuarioABanear){
        String sql = "insert into ban ( idUsuario, motivoBan, fechaHora) values (?, ?,Now())";
        try (Connection conn=this.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
            //pstmt.setInt(1,idUser);
            pstmt.setInt(1,idUsuarioABanear); //nuevos usuarios se registran como alumnos
            pstmt.setString(2,"No se que poner"); //Luego tenemos que modificar esto
            pstmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
