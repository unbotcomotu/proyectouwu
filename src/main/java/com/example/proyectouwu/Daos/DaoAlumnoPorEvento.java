package com.example.proyectouwu.Daos;

import com.example.proyectouwu.Beans.AlumnoPorEvento;
import com.example.proyectouwu.Beans.Evento;
import com.example.proyectouwu.DTOs.TopApoyo;

import java.sql.*;
import java.util.ArrayList;

public class DaoAlumnoPorEvento extends DaoPadre {
    public String verificarApoyo(int idEvento, int idUsuario) {
        String sql = "select estadoApoyo from alumnoporevento where idAlumno=? and idEvento=?";
        try (Connection conn = this.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, idUsuario);
            pstmt.setInt(2, idEvento);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getString(1);
                } else {
                    return null;
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public ArrayList<Evento> listarEventosPorUsuario(int idUsuario) {
        ArrayList<Evento> listaEventos = new ArrayList<>();
        String sql = "select e.idEvento,e.idActividad,e.idLugarEvento,e.titulo,e.fecha,e.hora,e.descripcionEventoActivo,e.fraseMotivacional,e.eventoFinalizado,e.eventoOculto,e.resumen,e.resultadoEvento,e.fotoMiniatura from alumnoporevento ae inner join evento e on ae.idEvento=e.idEvento where idAlumno=?";
        try (Connection conn = this.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, idUsuario);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Evento e = new Evento();
                    e.setIdEvento(rs.getInt(1));
                    e.getActividad().setIdActividad(rs.getInt(2));
                    e.getLugarEvento().setIdLugarEvento(rs.getInt(3));
                    e.setTitulo(rs.getString(4));
                    e.setFecha(rs.getDate(5));
                    e.setHora(rs.getTime(6));
                    e.setDescripcionEventoActivo(rs.getString(7));
                    e.setFraseMotivacional(rs.getString(8));
                    e.setEventoFinalizado(rs.getBoolean(9));
                    e.setEventoOculto(rs.getBoolean(10));
                    e.setResumen(rs.getString(11));
                    e.setResultadoEvento(rs.getString(12));
                    e.setFotoMiniatura(rs.getBlob(13));
                    listaEventos.add(e);
                }
                return listaEventos;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public Integer cantidadTotalApoyosEstudiantes() {
        String sql = "select count(ae.idAlumnoPorEvento) from alumnoporevento ae inner join usuario u on ae.idAlumno=u.idUsuario where ae.estadoApoyo!='Pendiente' and u.condicion='Estudiante'";
        try (Connection conn = this.getConnection(); ResultSet rs = conn.createStatement().executeQuery(sql);) {
            if (rs.next()) {
                return rs.getInt(1);
            } else {
                return 0;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public Integer cantidadTotalApoyosEgresados() {
        String sql = "select count(ae.idAlumnoPorEvento) from alumnoporevento ae inner join usuario u on ae.idAlumno=u.idUsuario where ae.estadoApoyo!='Pendiente' and u.condicion='Egresado'";
        try (Connection conn = this.getConnection(); ResultSet rs = conn.createStatement().executeQuery(sql);) {
            if (rs.next()) {
                return rs.getInt(1);
            } else {
                return 0;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public Integer solicitudesApoyoHaceNdias(int n) {
        String sql = "select count(idAlumnoPorEvento) from alumnoporevento where day(now())-day(fechaHoraSolicitud)=? group by day(fechaHoraSolicitud)";
        try (Connection conn = this.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, n);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                } else {
                    return 0;
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void usuarioApoyaEvento(int idUsuario, int idEvento) {
        String sql = "insert into alumnoporevento (  idAlumno, idEvento , estadoApoyo, fechaHoraSolicitud,notificacionLeida) values (?, ?, ? , now(),false)";
        try (Connection conn = this.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
            //pstmt.setInt(1,idUser);
            pstmt.setInt(1, idUsuario); //nuevos usuarios se registran como alumnos
            pstmt.setInt(2, idEvento);
            pstmt.setString(3, "Pendiente");
            pstmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public TopApoyo topApoyoUltimaSemana() {
        String sql = "select u.nombre,u.apellido,u.fotoPerfil,aux.cantidadApoyos from usuario u inner join (select uAux.idUsuario as 'id',count(ae.idAlumnoPorEvento) as 'cantidadApoyos' from alumnoporevento ae inner join usuario uAux on uAux.idUsuario=ae.idAlumno and datediff(now(),ae.fechaHoraSolicitud)<=7 group by ae.idAlumno order by count(ae.idAlumnoPorEvento) desc,max(fechaHoraSolicitud) desc limit 1) aux on u.idUsuario=aux.id";
        try (Connection conn = this.getConnection(); ResultSet rs = conn.createStatement().executeQuery(sql)) {
            if (rs.next()) {
                TopApoyo t = new TopApoyo();
                t.getUsuario().setNombre(rs.getString(1));
                t.getUsuario().setApellido(rs.getString(2));
                t.getUsuario().setFotoPerfil(rs.getBlob(3));
                t.setCantidadEventosApoyados(rs.getInt(4));
                return t;
            } else {
                return null;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public TopApoyo topApoyoTotal() {
        String sql = "select u.nombre,u.apellido,u.fotoPerfil,aux.cantidadApoyos from usuario u inner join (select uAux.idUsuario as 'id',count(ae.idAlumnoPorEvento) as 'cantidadApoyos' from alumnoporevento ae inner join usuario uAux on uAux.idUsuario=ae.idAlumno group by ae.idAlumno order by count(ae.idAlumnoPorEvento) desc,max(fechaHoraSolicitud) desc limit 1) aux on u.idUsuario=aux.id";
        try (Connection conn = this.getConnection(); ResultSet rs = conn.createStatement().executeQuery(sql)) {
            if (rs.next()) {
                TopApoyo t = new TopApoyo();
                t.getUsuario().setNombre(rs.getString(1));
                t.getUsuario().setApellido(rs.getString(2));
                t.getUsuario().setFotoPerfil(rs.getBlob(3));
                t.setCantidadEventosApoyados(rs.getInt(4));
                return t;
            } else {
                return null;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public boolean existeAlumnoPorEvento(String idAlumnoPorEvento) {
        String sql = "select idAlumnoPorEvento from alumnoporevento where idAlumnoPorEvento=?";
        try (Connection conn = this.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, idAlumnoPorEvento);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return true;
                } else
                    return false;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public AlumnoPorEvento getAlumnoPorEventoXId(int idAlumnoPorEvento) {
        AlumnoPorEvento alumnoPorEvento = new AlumnoPorEvento();
        String sql = "select * from alumnoporevento where idAlumnoPorEvento=? ";
        try (Connection conn = this.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, idAlumnoPorEvento);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    alumnoPorEvento.setIdAlumnoPorEvento(rs.getInt(1));
                    alumnoPorEvento.setAlumno(new DaoUsuario().getUsuarioPorId(rs.getInt(2)));
                    alumnoPorEvento.setEvento(new DaoEvento().obtenerEventoPorId(rs.getInt(3)));
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return alumnoPorEvento;
    }

    public ArrayList<AlumnoPorEvento> listaDeApoyosPorEvento(int idEvento) {
        ArrayList<AlumnoPorEvento>lista = new ArrayList<>();
        String sql = "select ae.idAlumnoPorEvento,ae.idAlumno,u.nombre,u.apellido,u.fotoPerfil,ae.estadoApoyo from alumnoporevento ae inner join usuario u on ae.idAlumno = u.idUsuario where ae.idEvento=? and estadoApoyo!='Pendiente' ";
        try (Connection conn = this.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, idEvento);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()){
                    AlumnoPorEvento ae=new AlumnoPorEvento();
                    ae.setIdAlumnoPorEvento(rs.getInt(1));
                    ae.getAlumno().setIdUsuario(rs.getInt(2));
                    ae.getAlumno().setNombre(rs.getString(3));
                    ae.getAlumno().setApellido(rs.getString(4));
                    ae.getAlumno().setFotoPerfil(rs.getBlob(5));
                    ae.setEstadoApoyo(rs.getString(6));
                    lista.add(ae);
                }
                return lista;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    public boolean verificacionParaApoyarEvento(int idUsuario,int idEvento){
        boolean verificacion=true;
        String sql ="select idEvento from evento where eventoFinalizado=false and eventoOculto=false and idEvento=?";
        try (Connection conn=this.getConnection(); PreparedStatement pstmt= conn.prepareStatement(sql)) {
            pstmt.setInt(1,idEvento);
            try(ResultSet rs=pstmt.executeQuery()){
                if(!rs.next()){
                    verificacion=false;
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        sql ="select idAlumnoPorEvento from alumnoporevento where idAlumno=? and idEvento=?";
        try (Connection conn=this.getConnection(); PreparedStatement pstmt= conn.prepareStatement(sql)) {
            pstmt.setInt(1,idUsuario);
            pstmt.setInt(2,idEvento);
            try(ResultSet rs=pstmt.executeQuery()){
                if(rs.next()){
                    verificacion=false;
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        sql="select a.idActividad from actividad a inner join evento e on a.idActividad = e.idActividad inner join usuario u on a.idDelegadoDeActividad = u.idUsuario where e.idEvento=? and a.idDelegadoDeActividad=?";
        try (Connection conn=this.getConnection(); PreparedStatement pstmt= conn.prepareStatement(sql)) {
            pstmt.setInt(1,idEvento);
            pstmt.setInt(2,idUsuario);
            try(ResultSet rs=pstmt.executeQuery()){
                if(rs.next()){
                    verificacion=false;
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return verificacion;
    }
    public boolean verificarUsuarioApoyaActividad(int idActividad,int idUsuario) {
        String sql = "select a.idActividad from actividad a inner join evento e on a.idActividad=e.idActividad inner join alumnoPorEvento ae on e.idEvento=ae.idEvento where ae.idAlumno=? and a.idActividad=?";
        try (Connection conn=this.getConnection(); PreparedStatement pstmt= conn.prepareStatement(sql)) {
            pstmt.setInt(1,idUsuario);
            pstmt.setInt(2,idActividad);
            try(ResultSet rs=pstmt.executeQuery()){
                return rs.next();
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
