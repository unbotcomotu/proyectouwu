package com.example.proyectouwu.Daos;

import com.example.proyectouwu.Beans.Actividad;

import java.io.IOException;
import java.io.InputStream;
import java.sql.*;
import java.util.ArrayList;

public class DaoActividad extends DaoPadre {
    
    public Integer idDelegaturaPorIdDelegadoDeActividad(int idDelegadoDeActividad){
        String sql="select idActividad from actividad where idDelegadoDeActividad=?";
        try(Connection conn=this.getConnection(); PreparedStatement pstmt= conn.prepareStatement(sql)){
            pstmt.setInt(1,idDelegadoDeActividad);
            try(ResultSet rs=pstmt.executeQuery()){
                if(rs.next()){
                    return rs.getInt(1);
                }else
                    return null;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public Integer idDelegadoDeActividadPorActividad(int idActividad){
        String sql="select idDelegadoDeActividad from actividad where idActividad=?";
        try(Connection conn=this.getConnection(); PreparedStatement pstmt= conn.prepareStatement(sql)){
            pstmt.setInt(1,idActividad);
            try(ResultSet rs=pstmt.executeQuery()){
                if(rs.next()){
                    return rs.getInt(1);
                }else
                    return null;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    public ArrayList<Actividad>listarActividades(){
        ArrayList<Actividad>listaActividades=new ArrayList<>();
        String sql="select idActividad,idDelegadoDeActividad,nombre,fotoMiniatura,cantidadPuntosPrimerLugar,actividadFinalizada,actividadOculta from actividad";
        try(Connection conn=this.getConnection(); ResultSet rs=conn.createStatement().executeQuery(sql);){
            while (rs.next()){
                Actividad a=new Actividad();
                a.setIdActividad(rs.getInt(1));
                a.getDelegadoDeActividad().setIdUsuario(rs.getInt(2));
                a.setNombre(rs.getString(3));
                a.setFotoMiniatura(rs.getBlob(4));
                a.setCantPuntosPrimerLugar(rs.getInt(5));
                a.setActividadFinalizada(rs.getBoolean(6));
                a.setActividadOculta(rs.getBoolean(7));
                listaActividades.add(a);
            }return listaActividades;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public ArrayList<Actividad>listarActividades(String nombre){
        ArrayList<Actividad>listaActividades=new ArrayList<>();
        String sql="select idActividad,idDelegadoDeActividad,nombre,fotoMiniatura,cantidadPuntosPrimerLugar,actividadFinalizada,actividadOculta from actividad where lower(nombre) like ?";
        try(Connection conn=this.getConnection(); PreparedStatement pstmt=conn.prepareStatement(sql)){
            pstmt.setString(1,"%"+nombre+"%");
            try (ResultSet rs=pstmt.executeQuery()){
                while (rs.next()){
                    Actividad a=new Actividad();
                    a.setIdActividad(rs.getInt(1));
                    a.getDelegadoDeActividad().setIdUsuario(rs.getInt(2));
                    a.setNombre(rs.getString(3));
                    a.setFotoMiniatura(rs.getBlob(4));
                    a.setCantPuntosPrimerLugar(rs.getInt(5));
                    a.setActividadFinalizada(rs.getBoolean(6));
                    a.setActividadOculta(rs.getBoolean(7));
                    listaActividades.add(a);
                }return listaActividades;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    public ArrayList<Actividad>listarActividades(int idFiltroActividades,int idOrdenarActividades,int idUsuario){
        ArrayList<Actividad>listaActividades=new ArrayList<>();
        String sql="";
        if(idFiltroActividades==0){
            if(idOrdenarActividades==0){
                sql="select idActividad,idDelegadoDeActividad,nombre,fotoMiniatura,cantidadPuntosPrimerLugar,actividadFinalizada,actividadOculta from actividad order by nombre desc";
            }else{
                sql="select idActividad,idDelegadoDeActividad,nombre,fotoMiniatura,cantidadPuntosPrimerLugar,actividadFinalizada,actividadOculta from actividad order by nombre asc";
            }
        }else if(idFiltroActividades==1){
            if(idOrdenarActividades==0){
                sql="select a.idActividad,a.idDelegadoDeActividad,a.nombre,a.fotoMiniatura,a.cantidadPuntosPrimerLugar,a.actividadFinalizada,a.actividadOculta from actividad a inner join evento e on a.idActividad=e.idActividad group by e.idActividad order by count(e.idEvento) desc";
            }else{
                sql="select a.idActividad,a.idDelegadoDeActividad,a.nombre,a.fotoMiniatura,a.cantidadPuntosPrimerLugar,a.actividadFinalizada,a.actividadOculta from actividad a inner join evento e on a.idActividad=e.idActividad group by e.idActividad order by count(e.idEvento) asc";
            }
        }else if(idFiltroActividades==2){
            if(idOrdenarActividades==0){
                sql="select idActividad,idDelegadoDeActividad,nombre,fotoMiniatura,cantidadPuntosPrimerLugar,actividadFinalizada,actividadOculta from actividad order by cantidadPuntosPrimerLugar desc";
            }else{
                sql="select idActividad,idDelegadoDeActividad,nombre,fotoMiniatura,cantidadPuntosPrimerLugar,actividadFinalizada,actividadOculta from actividad order by cantidadPuntosPrimerLugar asc";
            }
        }else if(idFiltroActividades==3){
            if(idOrdenarActividades==0){
                sql="select idActividad,idDelegadoDeActividad,nombre,fotoMiniatura,cantidadPuntosPrimerLugar,actividadFinalizada,actividadOculta from actividad order by if(actividadFinalizada is true, 0, 1)";
            }else{
                sql="select idActividad,idDelegadoDeActividad,nombre,fotoMiniatura,cantidadPuntosPrimerLugar,actividadFinalizada,actividadOculta from actividad order by if(actividadFinalizada is true, 1, 0)";
            }
        }else if(idFiltroActividades==4){
            if(idOrdenarActividades==0){
                sql="select idActividad,idDelegadoDeActividad,nombre,fotoMiniatura,cantidadPuntosPrimerLugar,actividadFinalizada,actividadOculta from actividad order by if(actividadOculta is true, 0, 1)";
            }else{
                sql="select idActividad,idDelegadoDeActividad,nombre,fotoMiniatura,cantidadPuntosPrimerLugar,actividadFinalizada,actividadOculta from actividad order by if(actividadOculta is true, 1, 0)";
            }
        }else{
            if(idOrdenarActividades==0){
                sql="select idActividad,idDelegadoDeActividad,nombre,fotoMiniatura,cantidadPuntosPrimerLugar,actividadFinalizada,actividadOculta from actividad order by if(idDelegadoDeActividad="+idUsuario+",0,1)";
            }else{
                sql="select idActividad,idDelegadoDeActividad,nombre,fotoMiniatura,cantidadPuntosPrimerLugar,actividadFinalizada,actividadOculta from actividad order by if(idDelegadoDeActividad="+idUsuario+",1,0)";
            }
        }
        try(Connection conn=this.getConnection(); ResultSet rs=conn.createStatement().executeQuery(sql);){
            while (rs.next()){
                Actividad a=new Actividad();
                a.setIdActividad(rs.getInt(1));
                a.getDelegadoDeActividad().setIdUsuario(rs.getInt(2));
                a.setNombre(rs.getString(3));
                a.setFotoMiniatura(rs.getBlob(4));
                a.setCantPuntosPrimerLugar(rs.getInt(5));
                a.setActividadFinalizada(rs.getBoolean(6));
                a.setActividadOculta(rs.getBoolean(7));
                listaActividades.add(a);
            }return listaActividades;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public String nombreActividadPorID(int idActividad){
        String sql="select nombre from Actividad where idActividad=?";
        try(Connection conn=this.getConnection(); PreparedStatement pstmt= conn.prepareStatement(sql)){
            pstmt.setInt(1,idActividad );
            try(ResultSet rs=pstmt.executeQuery()){
                if(rs.next()){
                    return rs.getString(1);
                }else
                    return null;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public String cantidadEventosPorActividad(int idActividad){
        String sql="select count(idEvento) from Actividad a inner join Evento e on a.idActividad=e.idActividad where a.idActividad=? group by a.idActividad";
        try(Connection conn=this.getConnection(); PreparedStatement pstmt= conn.prepareStatement(sql)){
            pstmt.setInt(1,idActividad);
            try(ResultSet rs=pstmt.executeQuery()){
                if(rs.next()){
                    return rs.getString(1);
                }else
                    return null;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public Integer cantidadEventosFinalizadosPorActividad(int idActividad){
        String sql="select count(idEvento) from Actividad a inner join Evento e on a.idActividad=e.idActividad where a.idActividad=? and e.eventoFinalizado is true";
        try(Connection conn=this.getConnection(); PreparedStatement pstmt= conn.prepareStatement(sql)){
            pstmt.setInt(1,idActividad);
            try(ResultSet rs=pstmt.executeQuery()){
                if(rs.next()){
                    return rs.getInt(1);
                }else
                    return 0;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public Integer cantidadEventosOcultosPorActividad(int idActividad){
        String sql="select count(idEvento) from Actividad a inner join Evento e on a.idActividad=e.idActividad where a.idActividad=? and e.eventoOculto is true";
        try(Connection conn=this.getConnection(); PreparedStatement pstmt= conn.prepareStatement(sql)){
            pstmt.setInt(1,idActividad);
            try(ResultSet rs=pstmt.executeQuery()){
                if(rs.next()){
                    return rs.getInt(1);
                }else
                    return 0;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    public Integer cantidadEventosApoyandoPorActividad(int idActividad,int idUsuario){
        String sql="select count(ae.idEvento) from Actividad a inner join Evento e on a.idActividad=e.idActividad inner join AlumnoPorEvento ae on e.idEvento=ae.idEvento where a.idActividad=? and ae.idAlumno=? and ae.estadoApoyo!='Pendiente'";
        try(Connection conn=this.getConnection(); PreparedStatement pstmt= conn.prepareStatement(sql)){
            pstmt.setInt(1,idActividad);
            pstmt.setInt(2,idUsuario);
            try(ResultSet rs=pstmt.executeQuery()){
                if(rs.next()){
                    return rs.getInt(1);
                }else
                    return 0;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public ArrayList<Integer[]>lugaresConMayorCantidadDeEventos_cantidad_idLugarEvento(int idActividad){
        ArrayList<Integer[]>lista=new ArrayList<>();
        String sql="select l.idLugarEvento,count(e.idEvento) from LugarEvento l inner join Evento e on l.idLugarEvento=e.idLugarEvento inner join Actividad a on e.idActividad=a.idActividad where a.idActividad=? group by e.idLugarEvento order by count(e.idEvento)";
        try(Connection conn=this.getConnection(); PreparedStatement pstmt= conn.prepareStatement(sql)){
            pstmt.setInt(1,idActividad);
            try(ResultSet rs=pstmt.executeQuery()){
                while(rs.next()){
                    Integer[] par={rs.getInt(1),rs.getInt(2)};
                    lista.add(par);
                }return lista;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public Integer cantidadEventosEnNdiasPorActividad(int idActividad,int N){
        String sql="select count(e.idEvento) from Evento e inner join Actividad a on e.idActividad=a.idActividad where a.idActividad=? and datediff(e.fecha,now())=?";
        try(Connection conn=this.getConnection(); PreparedStatement pstmt= conn.prepareStatement(sql)){
            pstmt.setInt(1,idActividad);
            pstmt.setInt(2,N);
            try(ResultSet rs=pstmt.executeQuery()){
                if(rs.next()){
                    return rs.getInt(1);
                }else
                    return 0;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    public Integer cantidadEventosEn2DiasAMasPorActividad(int idActividad){
        String sql="select count(e.idEvento) from Evento e inner join Actividad a on e.idActividad=a.idActividad where a.idActividad=? and datediff(e.fecha,now())>1";
        try(Connection conn=this.getConnection(); PreparedStatement pstmt= conn.prepareStatement(sql)){
            pstmt.setInt(1,idActividad);
            try(ResultSet rs=pstmt.executeQuery()){
                if(rs.next()){
                    return rs.getInt(1);
                }else
                    return 0;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public ArrayList<String> listaNombresActividadesOrden(){
        ArrayList<String>lista=new ArrayList<>();
        String sql="select nombre from Actividad order by nombre";
        try(Connection conn=this.getConnection(); ResultSet rs=conn.createStatement().executeQuery(sql)){
            while (rs.next()){
                lista.add(rs.getString(1));
            }return lista;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public ArrayList<Integer>cantidadApoyosEstudiantesPorActividadOrden(){
        ArrayList<Integer>lista=new ArrayList<>();
        String sql="select count(aux.idActividad) from actividad ac left join (select a.idActividad as 'idActividad' from actividad a left join evento e on a.idActividad=e.idActividad left join alumnoporevento ae on e.idEvento=ae.idEvento inner join usuario u on ae.idAlumno=u.idUsuario where u.condicion='Estudiante') aux on ac.idActividad=aux.idActividad group by ac.nombre order by ac.nombre";
        try(Connection conn=this.getConnection(); ResultSet rs=conn.createStatement().executeQuery(sql)){
            while (rs.next()){
                lista.add(rs.getInt(1));
            }return lista;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    public ArrayList<Integer>cantidadApoyosEgresadosPorActividadOrden(){
        ArrayList<Integer>lista=new ArrayList<>();
        String sql="select count(aux.idActividad) from actividad ac left join (select a.idActividad as 'idActividad' from actividad a left join evento e on a.idActividad=e.idActividad left join alumnoporevento ae on e.idEvento=ae.idEvento inner join usuario u on ae.idAlumno=u.idUsuario where u.condicion='Egresado') aux on ac.idActividad=aux.idActividad group by ac.nombre order by ac.nombre";
        try(Connection conn=this.getConnection(); ResultSet rs=conn.createStatement().executeQuery(sql)){
            while (rs.next()){
                lista.add(rs.getInt(1));
            }return lista;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void finalizarActividad(int idActividad){
        String sql="update actividad set actividadFinalizada=1 where idActividad=?";
        try(Connection conn=this.getConnection(); PreparedStatement pstmt= conn.prepareStatement(sql)){
            pstmt.setInt(1,idActividad);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void crearActividad(String nombre, int idDelegadoDeActividad, int puntaje, boolean oculto, InputStream fotoCabecera, InputStream fotoMiniatura)throws SQLException, IOException {
        String sql="insert into actividad (idDelegadoDeActividad,nombre,fotoMiniatura,fotoCabecera,cantidadPuntosPrimerLugar,actividadFinalizada,actividadOculta) values(?,?,?,?,?,false,?)";
        try(Connection conn=this.getConnection(); PreparedStatement pstmt= conn.prepareStatement(sql)){
            pstmt.setInt(1,idDelegadoDeActividad);
            pstmt.setString(2,nombre);
            pstmt.setBinaryStream(3, fotoMiniatura,(int)fotoMiniatura.available());
            pstmt.setBinaryStream(4, fotoCabecera,(int)fotoCabecera.available());
            pstmt.setInt(5,puntaje);
            pstmt.setBoolean(6,oculto);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        sql="update usuario set rol='Delegado de Actividad' where idUsuario=?";
        try(Connection conn=this.getConnection(); PreparedStatement pstmt= conn.prepareStatement(sql)){
            pstmt.setInt(1,idDelegadoDeActividad);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void editarActividad(int idActividad,String nombre,int idDelegadoDeActividad,int puntaje,boolean oculto,String fotoCabecera,String fotoMiniatura,int idDelegadoActividadAnterior){
        String sql="update actividad set idDelegadoDeActividad=?,nombre=?,fotoMiniatura=?,fotoCabecera=?,cantidadPuntosPrimerLugar=?,actividadOculta=? where idActividad=?";
        try(Connection conn=this.getConnection(); PreparedStatement pstmt= conn.prepareStatement(sql)){
            pstmt.setInt(1,idDelegadoDeActividad);
            pstmt.setString(2,nombre);
            pstmt.setString(3,fotoMiniatura);
            pstmt.setString(4,fotoCabecera);
            pstmt.setInt(5,puntaje);
            pstmt.setBoolean(6,oculto);
            pstmt.setInt(7,idActividad);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        sql="update usuario set rol='Delegado de Actividad' where idUsuario=?";
        try(Connection conn=this.getConnection(); PreparedStatement pstmt= conn.prepareStatement(sql)){
            pstmt.setInt(1,idDelegadoDeActividad);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        sql="update usuario set rol='Alumno' where idUsuario=?";
        try(Connection conn=this.getConnection(); PreparedStatement pstmt= conn.prepareStatement(sql)){
            pstmt.setInt(1,idDelegadoActividadAnterior);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public Integer eventosNoFinalizadosActividad(int idActividad){
        String sql="select count(e.idEvento) from Evento e inner join Actividad a on e.idActividad=a.idActividad where e.eventoFinalizado=false and a.idActividad=?";
        try(Connection conn=this.getConnection(); PreparedStatement pstmt= conn.prepareStatement(sql)){
            pstmt.setInt(1,idActividad);
            try(ResultSet rs=pstmt.executeQuery()){
                if(rs.next()){
                    return rs.getInt(1);
                }else
                    return 0;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public boolean verificarActividadRepetida(String nombre){
        String sql="select idActividad from Actividad where lower(nombre)=lower(?)";
        try(Connection conn=this.getConnection(); PreparedStatement pstmt= conn.prepareStatement(sql)){
            pstmt.setString(1,nombre);
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
}

