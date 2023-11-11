package com.example.proyectouwu.Daos;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import com.example.proyectouwu.Beans.Validacion;
import java.time.format.DateTimeFormatter;
import java.sql.*;
import java.util.Random;
import java.util.Date;

public class DaoValidacion extends DaoPadre {
    public void agregarCorreoParaEnviarLink(String correo){
        String sql = "insert into validacion( correo, tipo, codigoValidacion, fechaHora, linkEnviado) values (?,?,?,?,?);";
        LocalDateTime fechaHoraActual = LocalDateTime.now();
        // Define el formato deseado
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        // Convierte la fecha y hora actual en un String formateado
        String dateStr = fechaHoraActual.format(formatter);
        try (Connection conn=this.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql,Statement.RETURN_GENERATED_KEYS)) {
            pstmt.setString(1,correo);
            pstmt.setString(2,"enviarLinkACorreo");
            pstmt.setInt(3,new Random().nextInt(99999));
            pstmt.setString(4,dateStr);
            pstmt.setBoolean(5,false);
            pstmt.executeUpdate();
            ResultSet rskeys=pstmt.getGeneratedKeys();
            if(rskeys.next()){
                new DaoNotificacionDelegadoGeneral().crearNotificacionValidacion(rskeys.getInt(1));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void agregarCorreoParaRecuperarContrasena(String correo){

            String sql = "insert into validacion( correo, tipo, codigoValidacion, fechaHora, linkEnviado, idUsuario) values (?,?,?,?,?,?);";

            LocalDateTime fechaHoraActual = LocalDateTime.now();
            // Define el formato deseado
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
            // Convierte la fecha y hora actual en un String formateado
            String dateStr = fechaHoraActual.format(formatter);
            try (Connection conn=this.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql,Statement.RETURN_GENERATED_KEYS)) {
                pstmt.setString(1, correo);
                pstmt.setString(2, "recuperarContrasena");
                pstmt.setInt(3, new Random().nextInt(99999));
                pstmt.setString(4, dateStr);
                pstmt.setBoolean(5, false);
                pstmt.setInt(6, new DaoUsuario().obtenerIdPorCorreo(correo));
                pstmt.executeUpdate();
                ResultSet rskeys=pstmt.getGeneratedKeys();
                if(rskeys.next()){
                    new DaoNotificacionDelegadoGeneral().crearNotificacionValidacion(rskeys.getInt(1));
                }
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }

    }
    public String buscarCorreoPorIdCorreoValidacion(String idCorreoValidacion ){
        String sql = "select correo from validacion where idCorreoValidacion = ?";
        try (Connection conn=this.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, idCorreoValidacion);
            try(ResultSet rs = pstmt.executeQuery()){
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
    public int getCodigoValidacionPorIdCorreoValidacion(String idCorreoValidacion){
        String sql = "select codigoValidacion from validacion where idCorreoValidacion = ?";
        try (Connection conn=this.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, idCorreoValidacion);
            try(ResultSet rs = pstmt.executeQuery()){
                if(rs.next()){
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        //Nunca se va a dar este caso porque siempre que se crea IdCorreoValidacion con un correo
        return 1;
    }


    public int getIdPorcodigoValidacion(int codigoValidacion){
        String sql = "select idCorreoValidacion  from validacion where codigoValidacion = ?";
        try (Connection conn=this.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, codigoValidacion);
            try(ResultSet rs = pstmt.executeQuery()){
                if(rs.next()){
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return 0;
    }

    public String tipoValidacionPorID(int idCorreoValidacion){
        String sql = "select tipo from validacion where idCorreoValidacion = ?";
        try (Connection conn=this.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1,idCorreoValidacion);
            try(ResultSet rs = pstmt.executeQuery()){
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

    public Validacion validacionPorIDNotificacionCorreo(int idCorreoValidacion){
        String sql = "select correo,codigoValidacion from validacion where idCorreoValidacion = ?";
        try (Connection conn=this.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1,idCorreoValidacion);
            try(ResultSet rs = pstmt.executeQuery()){
                if(rs.next()){
                    Validacion v=new Validacion();
                    v.setCorreo(rs.getString(1));
                    v.setCodigoValidacion(rs.getInt(2));
                    return v;
                }else{
                    return null;
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public Validacion validacionPorIDNotificacionContrasena(int idCorreoValidacion){
        String sql = "select v.codigoValidacion,u.nombre,u.apellido,u.fotoPerfil from validacion v inner join usuario u on v.idUsuario=u.idUsuario where v.idCorreoValidacion = ?";
        try (Connection conn=this.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1,idCorreoValidacion);
            try(ResultSet rs = pstmt.executeQuery()){
                if(rs.next()){
                    Validacion v=new Validacion();
                    v.setCodigoValidacion(rs.getInt(1));
                    v.getUsuario().setNombre(rs.getString(2));
                    v.getUsuario().setApellido(rs.getString(3));
                    v.getUsuario().setFotoPerfil(rs.getBlob(4));
                    return v;
                }else{
                    return null;
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
