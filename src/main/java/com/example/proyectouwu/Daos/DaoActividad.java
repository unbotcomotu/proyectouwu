package com.example.proyectouwu.Daos;

import com.example.proyectouwu.Beans.Actividad;
import com.example.proyectouwu.Beans.Evento;

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
        String sql="select idActividad,idDelegadoDeActividad,nombre,fotoMiniatura,cantidadPuntosPrimerLugar,actividadFinalizada,actividadOculta,fotoCabecera from actividad";
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
                a.setFotoCabecera(rs.getBlob(8));
                listaActividades.add(a);
            }return listaActividades;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public boolean actividadOcultaPorId(String idActividad){
        String sql = "select actividadOculta from actividad where idActividad=?";
        try(Connection conn = getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql)){
            pstmt.setString(1,idActividad);
            try(ResultSet rs = pstmt.executeQuery()){
                if(rs.next()){
                    return rs.getBoolean(1);
                }else{
                    return false;
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public ArrayList<Actividad>listarActividades(String nombre){
        ArrayList<Actividad>listaActividades=new ArrayList<>();
        String sql="select idActividad,idDelegadoDeActividad,nombre,fotoMiniatura,fotoCabecera,cantidadPuntosPrimerLugar,actividadFinalizada,actividadOculta from actividad where lower(nombre) like ?";
        try(Connection conn=this.getConnection(); PreparedStatement pstmt=conn.prepareStatement(sql)){
            pstmt.setString(1,"%"+nombre+"%");
            try (ResultSet rs=pstmt.executeQuery()){
                while (rs.next()){
                    Actividad a=new Actividad();
                    a.setIdActividad(rs.getInt(1));
                    a.getDelegadoDeActividad().setIdUsuario(rs.getInt(2));
                    a.setNombre(rs.getString(3));
                    a.setFotoMiniatura(rs.getBlob(4));
                    a.setFotoCabecera(rs.getBlob(5));
                    a.setCantPuntosPrimerLugar(rs.getInt(6));
                    a.setActividadFinalizada(rs.getBoolean(7));
                    a.setActividadOculta(rs.getBoolean(8));
                    listaActividades.add(a);
                }return listaActividades;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public int obtenerIdActividadPorIdEvento(int idEvento){
        String sql = "select idActividad from evento where idEvento=?";
        try(Connection conn = getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql)){
            pstmt.setInt(1,idEvento);
            try(ResultSet rs = pstmt.executeQuery()){
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

    public ArrayList<Actividad>listarActividades(String idFiltroActividades,String idOrdenarActividades,int idUsuario){
        ArrayList<Actividad>listaActividades=new ArrayList<>();
        String sql="";
        switch (idFiltroActividades) {
            case "0":
                if (idOrdenarActividades.equals("0")) {
                    sql = "select idActividad,idDelegadoDeActividad,nombre,fotoMiniatura,cantidadPuntosPrimerLugar,actividadFinalizada,actividadOculta from actividad order by nombre desc";
                } else {
                    sql = "select idActividad,idDelegadoDeActividad,nombre,fotoMiniatura,cantidadPuntosPrimerLugar,actividadFinalizada,actividadOculta from actividad order by nombre asc";
                }
                break;
            case "1":
                if (idOrdenarActividades.equals("1")) {
                    sql = "select a.idActividad,a.idDelegadoDeActividad,a.nombre,a.fotoMiniatura,a.cantidadPuntosPrimerLugar,a.actividadFinalizada,a.actividadOculta from actividad a left join evento e on a.idActividad=e.idActividad group by a.idActividad order by count(e.idEvento) desc";
                } else {
                    sql = "select a.idActividad,a.idDelegadoDeActividad,a.nombre,a.fotoMiniatura,a.cantidadPuntosPrimerLugar,a.actividadFinalizada,a.actividadOculta from actividad a left join evento e on a.idActividad=e.idActividad group by a.idActividad order by count(e.idEvento) asc";
                }
                break;
            case "2":
                if (idOrdenarActividades.equals("1")) {
                    sql = "select idActividad,idDelegadoDeActividad,nombre,fotoMiniatura,cantidadPuntosPrimerLugar,actividadFinalizada,actividadOculta from actividad order by cantidadPuntosPrimerLugar desc";
                } else {
                    sql = "select idActividad,idDelegadoDeActividad,nombre,fotoMiniatura,cantidadPuntosPrimerLugar,actividadFinalizada,actividadOculta from actividad order by cantidadPuntosPrimerLugar asc";
                }
                break;
            case "3":
                if (idOrdenarActividades.equals("1")) {
                    sql = "select idActividad,idDelegadoDeActividad,nombre,fotoMiniatura,cantidadPuntosPrimerLugar,actividadFinalizada,actividadOculta from actividad order by if(actividadFinalizada is true, 0, 1)";
                } else {
                    sql = "select idActividad,idDelegadoDeActividad,nombre,fotoMiniatura,cantidadPuntosPrimerLugar,actividadFinalizada,actividadOculta from actividad order by if(actividadFinalizada is true, 1, 0)";
                }
                break;
            case "4":
                if (idOrdenarActividades.equals("1")) {
                    sql = "select idActividad,idDelegadoDeActividad,nombre,fotoMiniatura,cantidadPuntosPrimerLugar,actividadFinalizada,actividadOculta from actividad order by if(actividadOculta is true, 0, 1)";
                } else {
                    sql = "select idActividad,idDelegadoDeActividad,nombre,fotoMiniatura,cantidadPuntosPrimerLugar,actividadFinalizada,actividadOculta from actividad order by if(actividadOculta is true, 1, 0)";
                }
                break;
            default:
                if (idOrdenarActividades.equals("0")) {
                    sql = "select idActividad,idDelegadoDeActividad,nombre,fotoMiniatura,cantidadPuntosPrimerLugar,actividadFinalizada,actividadOculta from actividad order by if(idDelegadoDeActividad=" + idUsuario + ",0,1)";
                } else {
                    sql = "select idActividad,idDelegadoDeActividad,nombre,fotoMiniatura,cantidadPuntosPrimerLugar,actividadFinalizada,actividadOculta from actividad order by if(idDelegadoDeActividad=" + idUsuario + ",1,0)";
                }
                break;
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
        String sql="select nombre from actividad where idActividad=?";
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
        String sql="select count(idEvento) from actividad a inner join evento e on a.idActividad=e.idActividad where a.idActividad=? group by a.idActividad";
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
        String sql="select count(idEvento) from actividad a inner join evento e on a.idActividad=e.idActividad where a.idActividad=? and e.eventoFinalizado is true";
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
        String sql="select count(idEvento) from actividad a inner join evento e on a.idActividad=e.idActividad where a.idActividad=? and e.eventoOculto is true";
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
        String sql="select count(ae.idEvento) from actividad a inner join evento e on a.idActividad=e.idActividad inner join alumnoporevento ae on e.idEvento=ae.idEvento where a.idActividad=? and ae.idAlumno=? and ae.estadoApoyo!='Pendiente'";
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
        String sql="select l.idLugarEvento,count(e.idEvento) from lugarevento l inner join evento e on l.idLugarEvento=e.idLugarEvento inner join actividad a on e.idActividad=a.idActividad where a.idActividad=? group by e.idLugarEvento order by count(e.idEvento)";
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

    public ArrayList<Integer[]>lugaresConMayorCantidadDeEventos_cantidad_idLugarEventoSinOcultos(int idActividad){
        ArrayList<Integer[]>lista=new ArrayList<>();
        String sql="select l.idLugarEvento,count(e.idEvento) from lugarevento l inner join evento e on l.idLugarEvento=e.idLugarEvento inner join actividad a on e.idActividad=a.idActividad where a.idActividad=? and e.eventoOculto=false group by e.idLugarEvento order by count(e.idEvento)";
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
        String sql="select count(e.idEvento) from evento e inner join actividad a on e.idActividad=a.idActividad where a.idActividad=? and datediff(e.fecha,now())=?";
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
        String sql="select count(e.idEvento) from evento e inner join actividad a on e.idActividad=a.idActividad where a.idActividad=? and datediff(e.fecha,now())>1";
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
        String sql="select nombre from actividad order by nombre";
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
        String sql="update actividad set actividadFinalizada=1 where idActividad=? and actividadFinalizada=0";
        try(Connection conn=this.getConnection(); PreparedStatement pstmt= conn.prepareStatement(sql)){
            pstmt.setInt(1,idActividad);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void crearActividad(String nombre, String idDelegadoDeActividad, int puntaje, boolean oculto, InputStream fotoCabecera, InputStream fotoMiniatura){
        String sql="insert into actividad (idDelegadoDeActividad,nombre,fotoMiniatura,fotoCabecera,cantidadPuntosPrimerLugar,actividadFinalizada,actividadOculta) values(?,?,?,?,?,false,?)";
        try(Connection conn=this.getConnection(); PreparedStatement pstmt= conn.prepareStatement(sql)){
            pstmt.setString(1,idDelegadoDeActividad);
            pstmt.setString(2,nombre);
            pstmt.setBinaryStream(3, fotoMiniatura,(int)fotoMiniatura.available());
            pstmt.setBinaryStream(4, fotoCabecera,(int)fotoCabecera.available());
            pstmt.setInt(5,puntaje);
            pstmt.setBoolean(6,oculto);
            pstmt.executeUpdate();
        } catch (SQLException | IOException e) {
            throw new RuntimeException(e);
        }
        sql="update usuario set rol='Delegado de Actividad' where idUsuario=?";
        try(Connection conn=this.getConnection(); PreparedStatement pstmt= conn.prepareStatement(sql)){
            pstmt.setString(1,idDelegadoDeActividad);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    public void editarActividad(int idActividad,String nombre,int idDelegadoDeActividad,int puntaje,boolean oculto,InputStream fotoCabecera,InputStream fotoMiniatura,int idDelegadoActividadAnterior, boolean validarLongitudCab, boolean validarLongitudMin){
        //validar la longitud minima 10
        String secFotoCab = "";
        String secFotoMin = "";
        if(validarLongitudCab){
            secFotoCab = ",fotoCabecera=?";
        }
        if(validarLongitudMin){
            secFotoMin = ",fotoMiniatura=?";
        }

        String sql="update actividad set idDelegadoDeActividad=?,nombre=?"+secFotoMin+secFotoCab+",cantidadPuntosPrimerLugar=?,actividadOculta=? where idActividad=?";

        try(Connection conn=this.getConnection(); PreparedStatement pstmt= conn.prepareStatement(sql)){
            pstmt.setInt(1,idDelegadoDeActividad);
            pstmt.setString(2,nombre);
            //pstmt.setInt(7,idActividad);
            if(validarLongitudCab && validarLongitudMin){
                pstmt.setBinaryStream(3,fotoMiniatura,fotoMiniatura.available()); //pstmt.setString(3,fotoMiniatura);
                pstmt.setBinaryStream(4,fotoCabecera,fotoCabecera.available());//pstmt.setString(4,fotoCabecera);
                pstmt.setInt(5,puntaje);
                pstmt.setBoolean(6,oculto);
                pstmt.setInt(7,idActividad);
            }else if(validarLongitudMin){
                //pstmt.setString(3,fotoMiniatura);
                pstmt.setBinaryStream(3,fotoMiniatura,fotoMiniatura.available());
                pstmt.setInt(4,puntaje);
                pstmt.setBoolean(5,oculto);
                pstmt.setInt(6,idActividad);
            }else if(validarLongitudCab){
                //pstmt.setString(4,fotoCabecera);
                pstmt.setBinaryStream(3,fotoCabecera,fotoCabecera.available());
                pstmt.setInt(4,puntaje);
                pstmt.setBoolean(5,oculto);
                pstmt.setInt(6,idActividad);
            }else{
                pstmt.setInt(3,puntaje);
                pstmt.setBoolean(4,oculto);
                pstmt.setInt(5,idActividad);
            }
            pstmt.executeUpdate();
        }catch (SQLException | IOException e) {
            throw new RuntimeException(e);
        }

        sql="update usuario set rol='Alumno' where idUsuario=?";
        try(Connection conn=this.getConnection(); PreparedStatement pstmt= conn.prepareStatement(sql)){
            pstmt.setInt(1,idDelegadoActividadAnterior);
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

    public Integer eventosNoFinalizadosActividad(int idActividad){
        String sql="select count(e.idEvento) from evento e inner join actividad a on e.idActividad=a.idActividad where e.eventoFinalizado=false and a.idActividad=?";
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

    public boolean verificarActividadRepetida(String nombre,int idActividad){
        String sql="select idActividad from actividad where lower(nombre)=lower(?) and idActividad!=?";
        try(Connection conn=this.getConnection(); PreparedStatement pstmt= conn.prepareStatement(sql)){
            pstmt.setString(1,nombre);
            pstmt.setInt(2,idActividad);
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
    public Blob obtenerFotoMiniaturaXIdActividad(int idActividad){
        String sql="select fotoMiniatura from actividad where idActividad=?";

        try(Connection conn=this.getConnection(); PreparedStatement pstmt= conn.prepareStatement(sql)){
            pstmt.setInt(1,idActividad);
            try(ResultSet rs=pstmt.executeQuery()){
                if(rs.next()){
                    return rs.getBlob(1);
                }else
                    return null;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
   //Separa metodos para poder facilitar mostrar las notificaciones de validar foto en delegado general
    public Blob obtenerFotoCabeceraXIdActividad(int idActividad){
        String sql="select fotoCabecera from actividad where idActividad=?";

        try(Connection conn=this.getConnection(); PreparedStatement pstmt= conn.prepareStatement(sql)){
            pstmt.setInt(1,idActividad);
            try(ResultSet rs=pstmt.executeQuery()){
                if(rs.next()){
                    return rs.getBlob(1);
                }else
                    return null;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public boolean existeActividad(String idActividad){
        String sql="select idActividad from actividad where idActividad=?";
        try(Connection conn=this.getConnection(); PreparedStatement pstmt= conn.prepareStatement(sql)){
            pstmt.setString(1,idActividad);
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

    public Actividad obtenerActividadPorIDDelegado(int idUsuario){
        String sql="select * from actividad where idDelegadoDeActividad=?";
        try(Connection conn=this.getConnection(); PreparedStatement pstmt= conn.prepareStatement(sql)){
            pstmt.setInt(1,idUsuario);
            try(ResultSet rs=pstmt.executeQuery()){
                if(rs.next()){
                    Actividad a=new Actividad();
                    a.setIdActividad(rs.getInt(1));
                    a.getDelegadoDeActividad().setIdUsuario(rs.getInt(2));
                    a.setNombre(rs.getString(3));
                    a.setFotoMiniatura(rs.getBlob(4));
                    a.setFotoCabecera(rs.getBlob(5));
                    a.setCantPuntosPrimerLugar(rs.getInt(6));
                    a.setActividadFinalizada(rs.getBoolean(7));
                    a.setActividadOculta(rs.getBoolean(8));
                    return a;
                }else{
                    return null;
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}

