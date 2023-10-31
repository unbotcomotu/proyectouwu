package com.example.proyectouwu.Daos;

import com.example.proyectouwu.Beans.Donacion;
import com.example.proyectouwu.Beans.Evento;

import java.sql.*;
import java.util.ArrayList;

public class DaoEvento extends DaoPadre {
    private Connection conn;

    {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/proyecto", super.getUser(), super.getPassword());
        } catch (ClassNotFoundException | SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public Evento eventoPorIDsinMiniatura(int idEvento) {
        Evento e = new Evento();
        String sql = "select idEvento,idActividad,idLugarEvento,titulo,fecha,hora,descripcionEventoActivo,fraseMotivacional,eventoFinalizado,eventoOculto,resumen,resultadoEvento from Evento where idEvento=?";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, idEvento);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    e.setIdEvento(rs.getInt(1));
                    e.setIdActividad(rs.getInt(2));
                    e.setLugarEvento(rs.getInt(3));
                    e.setTitulo(rs.getString(4));
                    e.setFecha(rs.getDate(5));
                    e.setHora(rs.getTime(6));
                    e.setDescripcionEventoActivo(rs.getString(7));
                    e.setFraseMotivacional(rs.getString(8));
                    e.setEventoFinalizado(rs.getBoolean(9));
                    e.setEventoOculto(rs.getBoolean(10));
                    e.setResumen(rs.getString(11));
                    e.setResultadoEvento(rs.getString(12));
                    String sql2 = "select c.foto from Evento e inner join FotoEventoCarrusel c on e.idEvento=c.idEvento";
                    try (ResultSet rs2 = conn.createStatement().executeQuery(sql2)) {
                        while (rs2.next()) {
                            e.getCarruselFotos().add(rs2.getBlob(1));
                        }
                    }
                    return e;
                } else {
                    return null;
                }
            }
        } catch (SQLException ex) {
            throw new RuntimeException(ex);
        }
    }

    public ArrayList<Evento> listarEventos(int idActividad) {
        ArrayList<Evento> listaEventos = new ArrayList<>();
        String sql = "select e.idEvento,e.idLugarEvento,e.titulo,e.fecha,e.hora,e.descripcionEventoActivo,e.fraseMotivacional,e.fotoMiniatura,e.eventoFinalizado,e.eventoOculto,e.resumen,e.resultadoEvento from Evento e inner join Actividad a on e.idActividad=a.idActividad where a.idActividad=?";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, idActividad);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Evento e = new Evento();
                    e.setIdEvento(rs.getInt(1));
                    e.setLugarEvento(rs.getInt(2));
                    e.setTitulo(rs.getString(3));
                    e.setFecha(rs.getDate(4));
                    e.setHora(rs.getTime(5));
                    e.setDescripcionEventoActivo(rs.getString(6));
                    e.setFraseMotivacional(rs.getString(7));
                    e.setFotoMiniatura(rs.getBlob(8));
                    e.setEventoFinalizado(rs.getBoolean(9));
                    e.setEventoOculto(rs.getBoolean(10));
                    e.setResumen(rs.getString(11));
                    e.setResultadoEvento(rs.getString(12));
                    listaEventos.add(e);
                }
            }
            return listaEventos;
        } catch (SQLException ex) {
            throw new RuntimeException(ex);
        }
    }

    public String actividadDeEventoPorID(int idEvento) {
        //Busqueda de un evento
        String sql = "select a.nombre from Evento e inner join Actividad a on e.idActividad=a.idActividad where idEvento=?";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, idEvento);
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

    public String lugarPorEventoID(int idEvento) {
        String sql = "select l.lugar from LugarEvento l inner join Evento e on l.idLugarEvento=e.idLugarEvento where e.idEvento=?";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, idEvento);
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

    public Integer diferenciaDiasEventoActualidad(int idEvento) {
        String sql = "select datediff(fecha,current_date()) from Evento where idEvento=?";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, idEvento);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                } else {
                    return null;
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public Integer idDelegadoDeActividadPorEvento(int idEvento) {
        String sql = "select a.idDelegadoDeActividad from Actividad a inner join Evento e on e.idActividad=a.idActividad where idEvento=?";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, idEvento);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                } else {
                    return null;
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public ArrayList<Integer> cantidadApoyosBarraEquipoPorEvento(int idEvento) {
        ArrayList<Integer> cantidadApoyos = new ArrayList<>();
        String sql = "select count(estadoApoyo) from AlumnoPorEvento where idEvento=? group by estadoApoyo having estadoApoyo='Equipo'";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, idEvento);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    cantidadApoyos.add(rs.getInt(1));
                } else {
                    cantidadApoyos.add(0);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        sql = "select count(estadoApoyo) from AlumnoPorEvento where idEvento=? group by estadoApoyo having estadoApoyo='Barra'";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, idEvento);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    cantidadApoyos.add(rs.getInt(1));
                } else {
                    cantidadApoyos.add(0);
                }
            }
            return cantidadApoyos;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public Integer solicitudesSinAtenderPorEvento(int idEvento) {
        String sql = "select count(idAlumnoPorEvento) from AlumnoPorEvento where idEvento=? group by estadoApoyo having estadoApoyo='Pendiente'";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, idEvento);
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

    public void crearEvento(int idEvento, int idActividad, int lugarEvento, String titulo, String fecha, String hora, String descripcionEventoActivo, String fraseMotivacional, String fotoMiniatura) {
        String sql = "insert into evento(idEvento,idActividad,idLugarEvento,titulo,fecha,hora,descripcionEventoActivo,fraseMotivacional,fotoMinuatura) values (?,?,?,?,?,?,?,?,?)";
        //, String eventoFinalizado, String eventoOculto, String resumen, String resultadoEvento
        Evento e = new Evento();
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, idEvento);
            pstmt.setInt(2, idActividad);
            pstmt.setInt(3, lugarEvento);
            pstmt.setString(4, titulo);
            pstmt.setString(5, fecha);
            pstmt.setString(6, hora);
            pstmt.setString(7, descripcionEventoActivo);
            pstmt.setString(8, fraseMotivacional);
            pstmt.setString(10, fotoMiniatura);
            //pstmt.setString(11, eventoFinalizado);
            //pstmt.setString(12, eventoOculto);
            //pstmt.setString(13, resumen);
            //pstmt.setString(14, resultadoEvento);
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            throw new RuntimeException(ex);
        }
    }

    public void actualizarEditarEvento(int idEvento, int idActividad, int lugarEvento, String titulo, String fecha, String hora, String descripcionEventoActivo, String fraseMotivacional, String fotoMiniatura, String eventoFinalizado, String eventoOculto, String resumen, String resultadoEvento) {
        String sql = "update evento set idEvento = ?,idActividad= ?,idLugarEvento= ?,titulo= ?,fecha= ?,hora= ?,descripcionEventoActivo= ?,fraseMotivacional= ?,fotoMinuatura= ?,eventoFinalizado= ?,eventoOculto= ?,resumen= ?,resultadoEvento= ?";

        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(2, lugarEvento);
            pstmt.setString(3, titulo);
            pstmt.setString(4, fecha);
            pstmt.setString(5, hora);
            pstmt.setString(6, descripcionEventoActivo);
            pstmt.setString(7, fraseMotivacional);
            pstmt.setString(8, fotoMiniatura);
            pstmt.setString(9, eventoFinalizado);
            pstmt.setString(10, eventoOculto);
            pstmt.setString(11, resumen);
            pstmt.setString(12, resultadoEvento);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
