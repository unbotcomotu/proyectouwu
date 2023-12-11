package com.example.proyectouwu.Daos;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import com.example.proyectouwu.Beans.Validacion;

import java.sql.*;
import java.util.Random;

public class DaoValidacion extends DaoPadre {
    public void agregarCorreoParaEnviarLink(String correo){
        String sql = "insert into validacion( correo, tipo, codigoValidacion, fechaHora, linkEnviado,codigoValidacion256) values (?,?,?,?,?,sha2(?,256));";
        LocalDateTime fechaHoraActual = LocalDateTime.now();
        // Define el formato deseado
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        // Convierte la fecha y hora actual en un String formateado
        String dateStr = fechaHoraActual.format(formatter);
        try (Connection conn=this.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql,Statement.RETURN_GENERATED_KEYS)) {
            pstmt.setString(1,correo);
            pstmt.setString(2,"enviarLinkACorreo");
            int numero=new Random().nextInt(99999);
            pstmt.setInt(3,numero);
            pstmt.setString(4,dateStr);
            pstmt.setBoolean(5,false);
            pstmt.setInt(6,numero);
            pstmt.executeUpdate();
            ResultSet rskeys=pstmt.getGeneratedKeys();
            if(rskeys.next()){
                new DaoNotificacion().crearNotificacionValidacion(rskeys.getInt(1));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void agregarCorreoParaRecuperarContrasena(String correo){

            String sql = "insert into validacion( correo, tipo, codigoValidacion, fechaHora, linkEnviado, idUsuario,codigoValidacion256) values (?,?,?,?,?,?,sha2(?,256));";

            LocalDateTime fechaHoraActual = LocalDateTime.now();
            // Define el formato deseado
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
            // Convierte la fecha y hora actual en un String formateado
            String dateStr = fechaHoraActual.format(formatter);
            try (Connection conn=this.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql,Statement.RETURN_GENERATED_KEYS)) {
                pstmt.setString(1, correo);
                pstmt.setString(2, "recuperarContrasena");
                int numero=new Random().nextInt(99999);
                pstmt.setInt(3, numero);
                pstmt.setString(4, dateStr);
                pstmt.setBoolean(5, false);
                pstmt.setInt(6, new DaoUsuario().obtenerIdPorCorreo(correo));
                pstmt.setInt(7,numero);
                pstmt.executeUpdate();
                ResultSet rskeys=pstmt.getGeneratedKeys();
                if(rskeys.next()){
                    new DaoNotificacion().crearNotificacionValidacion(rskeys.getInt(1));
                }
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }

    }


    public void agregarCorreoParaElKit(int idUsuario){

        String sql = "insert into validacion(correo, tipo, fechaHora, linkEnviado, idUsuario) values (?,?,now(),?,?);";

        try (Connection conn=this.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql,Statement.RETURN_GENERATED_KEYS)) {
            pstmt.setString(1, new DaoUsuario().correoUsuarioPorId(idUsuario));
            pstmt.setString(2, "NecesitaUnKit");
            pstmt.setBoolean(3, false);
            pstmt.setInt(4, idUsuario);

            pstmt.executeUpdate();
            ResultSet rskeys=pstmt.getGeneratedKeys();
            if(rskeys.next()){
                new DaoNotificacion().crearNotificacionValidacion(rskeys.getInt(1));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

    }



    public String buscarCorreoPorIdCorreoValidacion(String idCorreoValidacion){
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
    public String codigoValidacion256PorID(int idCorreoValidacion){
        String sql = "select codigoValidacion256 from validacion where idCorreoValidacion = ?";
        try (Connection conn=this.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, idCorreoValidacion);
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

    public void linkEnviado(int idCorreoValidacion){
        String sql = "update validacion set linkEnviado=true where idCorreoValidacion = ?";
        try (Connection conn=this.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1,idCorreoValidacion);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public Blob getFotoPerfilPorIDCorreoValidacion(int idCorreoValidacion){
        String sql = "select u.fotoPerfil from usuario u inner join validacion v on u.idUsuario = v.idUsuario where v.idCorreoValidacion=?";
        try(Connection conn=this.getConnection(); PreparedStatement pstmt=conn.prepareStatement(sql)){
            pstmt.setInt(1,idCorreoValidacion);
            try(ResultSet rs = pstmt.executeQuery()){
                if(rs.next()){
                    return rs.getBlob(1);
                }else{
                    return null;
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public boolean verificarYaRecibioNotificacionKit(int idUsuario){
        String sql = "select idCorreoValidacion from validacion where idUsuario=? and tipo='NecesitaUnKit'";
        try(Connection conn=this.getConnection(); PreparedStatement pstmt=conn.prepareStatement(sql)){
            pstmt.setInt(1,idUsuario);
            try(ResultSet rs = pstmt.executeQuery()){
                return rs.next();
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public boolean existeValidacion(String idCorreoValidacion){
        String sql="select idCorreoValidacion from validacion where idCorreoValidacion=?";
        try(Connection conn=this.getConnection(); PreparedStatement pstmt= conn.prepareStatement(sql)){
            pstmt.setString(1,idCorreoValidacion);
            try(ResultSet rs=pstmt.executeQuery()){
                if(rs.next()){
                    return true;
                }else
                    return false;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    public Validacion getValidacionXId(int idCorreoValidacion ) {
        Validacion validacion = new Validacion();
        String sql = "select * from validacion where idCorreoValidacion=?";
        try (Connection conn = super.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, idCorreoValidacion);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    validacion.setIdCorreoValidacion(rs.getInt(1));
                    validacion.setCorreo(rs.getString(3));
                    validacion.setTipo(rs.getString(4));
                    validacion.setCodigoValidacion(rs.getInt(5));
                    validacion.setCodigoValidacion256(rs.getString(6));
                }
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return validacion;
    }

}
