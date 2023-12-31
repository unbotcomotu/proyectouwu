package com.example.proyectouwu.Daos;

import com.example.proyectouwu.Beans.Ban;
import com.example.proyectouwu.Beans.Usuario;

import java.io.IOException;
import java.io.InputStream;
import java.sql.*;
import java.util.ArrayList;

public class DaoUsuario extends DaoPadre {
    public String rolUsuarioPorId(int idUsuario){
        String sql="select rol from usuario where idUsuario=?";
        try(Connection conn=this.getConnection(); PreparedStatement pstmt= conn.prepareStatement(sql)){
            pstmt.setInt(1,idUsuario);
            try(ResultSet rs=pstmt.executeQuery()){
                if(rs.next()){
                    return rs.getString(1);
                }else
                    return "";
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public String nombreCompletoUsuarioPorId(int idUsuario){
        String sql="select concat(nombre,' ',apellido) as 'nombreCompleto' from usuario where idUsuario=?";
        try(Connection conn=this.getConnection(); PreparedStatement pstmt= conn.prepareStatement(sql)){
            pstmt.setInt(1,idUsuario);
            try(ResultSet rs=pstmt.executeQuery()){
                if(rs.next()){
                    return rs.getString(1);
                }else
                    return "";
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public String condicionUsuarioPorId(int idUsuario){
        String sql="select condicion from usuario where idUsuario=?";
        try(Connection conn=this.getConnection(); PreparedStatement pstmt= conn.prepareStatement(sql)){
            pstmt.setInt(1,idUsuario);
            try(ResultSet rs=pstmt.executeQuery()){
                if(rs.next()){
                    return rs.getString(1);
                }else
                    return "";
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }


    public String correoUsuarioPorId(int idUsuario){
        String sql="select correo from usuario where idUsuario=?";
        try(Connection conn=this.getConnection(); PreparedStatement pstmt= conn.prepareStatement(sql)){
            pstmt.setInt(1,idUsuario);
            try(ResultSet rs=pstmt.executeQuery()){
                if(rs.next()){
                    return rs.getString(1);
                }else
                    return "";
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public String codigoUsuarioPorId(int idUsuario){
        String sql="select codigoPUCP from usuario where idUsuario=?";
        try(Connection conn=this.getConnection(); PreparedStatement pstmt= conn.prepareStatement(sql)){
            pstmt.setInt(1,idUsuario);
            try(ResultSet rs=pstmt.executeQuery()){
                if(rs.next()){
                    return rs.getString(1);
                }else
                    return "";
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }


    public ArrayList<String>listarCorreosDelegadosGenerales(){
        ArrayList<String>listaCorreosDelegadosGenerales=new ArrayList<>();
        String sql="select correo from usuario where rol='Delegado General'";
        try(Connection conn=this.getConnection(); ResultSet rs=conn.createStatement().executeQuery(sql)){
            while(rs.next()){
                listaCorreosDelegadosGenerales.add(rs.getString(1));
            }return listaCorreosDelegadosGenerales;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public ArrayList<Usuario>listarIDyNombreDelegadosDeActividad(){
        ArrayList<Usuario>listaDelegadosDeActividad=new ArrayList<>();
        String sql="select u.idUsuario,u.nombre,u.apellido from usuario u left join ban b on u.idUsuario=b.idUsuario where rol='Alumno' and b.idUsuario is null and u.estadoRegistro='Registrado'";
        try(Connection conn=this.getConnection(); ResultSet rs=conn.createStatement().executeQuery(sql)){
            while(rs.next()){
                Usuario u=new Usuario();
                u.setIdUsuario(rs.getInt(1));
                u.setNombre(rs.getString(2));
                u.setApellido(rs.getString(3));
                listaDelegadosDeActividad.add(u);
            }return listaDelegadosDeActividad;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public ArrayList<Usuario> listarUsuarios(){
        ArrayList<Usuario> lista = new ArrayList<>();
        String sql = "select idUsuario, nombre, apellido, rol, codigoPUCP, condicion, fotoPerfil, descripcionPerfil from usuario where estadoRegistro='Registrado' AND rol!='Delegado General'";
        try(Connection conn=this.getConnection(); ResultSet rs=conn.prepareStatement(sql).executeQuery()){
            while(rs.next()){
                Usuario usuario = new Usuario();
                usuario.setIdUsuario(rs.getInt(1));
                usuario.setNombre(rs.getString(2));
                usuario.setApellido(rs.getString(3));
                usuario.setRol(rs.getString(4));
                usuario.setCodigoPUCP(rs.getString(5));
                usuario.setCondicion(rs.getString(6));
                usuario.setFotoPerfil(rs.getBlob(7));
                usuario.setDescripcionPerfil(rs.getString(8));
                lista.add(usuario);
            }
            return lista;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public ArrayList<Usuario> listarUsuarios(int pagina){
        ArrayList<Usuario> lista = new ArrayList<>();
        String sql = "select idUsuario, nombre, apellido, rol, codigoPUCP, condicion, fotoPerfil, descripcionPerfil from usuario where estadoRegistro='Registrado' AND rol!='Delegado General' limit 12 offset ?";
        try(Connection conn=this.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql)){
            pstmt.setInt(1,pagina*12);
            try(ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Usuario usuario = new Usuario();
                    usuario.setIdUsuario(rs.getInt(1));
                    usuario.setNombre(rs.getString(2));
                    usuario.setApellido(rs.getString(3));
                    usuario.setRol(rs.getString(4));
                    usuario.setCodigoPUCP(rs.getString(5));
                    usuario.setCondicion(rs.getString(6));
                    usuario.setFotoPerfil(rs.getBlob(7));
                    usuario.setDescripcionPerfil(rs.getString(8));
                    lista.add(usuario);
                }
                return lista;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public ArrayList<Usuario> listarUsuariosTotal(){
        ArrayList<Usuario> lista = new ArrayList<>();
        String sql = "select idUsuario , correo , contrasena from usuario";
        try(Connection conn=this.getConnection(); ResultSet rs=conn.prepareStatement(sql).executeQuery()){
            while(rs.next()){
                Usuario usuario = new Usuario();
                usuario.setIdUsuario(rs.getInt(1));
                usuario.setCorreo(rs.getString(2));
                usuario.setContrasena(rs.getString(3));
                lista.add(usuario);
            }
            return lista;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public ArrayList<Usuario>listarUsuarioXnombre(String nombre, int pagina){
        ArrayList<Usuario>listaUsuarios=new ArrayList<>();
        String sql = "select idUsuario, nombre, apellido, rol, codigoPUCP, condicion, fotoPerfil, descripcionPerfil from usuario where estadoRegistro='Registrado' AND rol!='Delegado General' and concat(nombre,' ',apellido) like ? limit 12 offset ?";
        try(Connection conn=this.getConnection(); PreparedStatement pstmt=conn.prepareStatement(sql)){
            pstmt.setString(1,"%"+nombre+"%");
            pstmt.setInt(2,pagina*12);
            try (ResultSet rs=pstmt.executeQuery()){
                while (rs.next()){
                    Usuario u=new Usuario();
                    u.setIdUsuario(rs.getInt(1));
                    u.setNombre(rs.getString(2));
                    u.setApellido(rs.getString(3));
                    u.setRol(rs.getString(4));
                    u.setCodigoPUCP(rs.getString(5));
                    u.setCondicion(rs.getString(6));
                    u.setFotoPerfil(rs.getBlob(7));
                    u.setDescripcionPerfil(rs.getString(8));
                    listaUsuarios.add(u);
                }return listaUsuarios;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public ArrayList<Usuario>listarUsuarioXnombre(String nombre, int pagina, String idFiltroUsuarios, String idOrdenarUsuarios){
        ArrayList<Usuario>listaUsuarios=new ArrayList<>();
        String sql="";
        switch (idFiltroUsuarios) {
            case "0":
                if (idOrdenarUsuarios.equals("1")) {
                    sql = "select idUsuario, nombre, apellido, rol, codigoPUCP, condicion, fotoPerfil, descripcionPerfil from usuario where estadoRegistro='Registrado' AND rol!='Delegado General' and concat(nombre,' ',apellido) like ? order by nombre desc limit 12 offset ?";
                } else {
                    sql = "select idUsuario, nombre, apellido, rol, codigoPUCP, condicion, fotoPerfil, descripcionPerfil from usuario where estadoRegistro='Registrado' AND rol!='Delegado General' and concat(nombre,' ',apellido) like ? order by nombre asc limit 12 offset ?";
                }
                break;
            case "1":
                if (idOrdenarUsuarios.equals("1")) {
                    sql = "select idUsuario, nombre, apellido, rol, codigoPUCP, condicion, fotoPerfil, descripcionPerfil from usuario where estadoRegistro='Registrado' AND rol!='Delegado General' and concat(nombre,' ',apellido) like ? order by codigoPUCP desc limit 12 offset ?";
                } else {
                    sql = "select idUsuario, nombre, apellido, rol, codigoPUCP, condicion, fotoPerfil, descripcionPerfil from usuario where estadoRegistro='Registrado' AND rol!='Delegado General' and concat(nombre,' ',apellido) like ? order by codigoPUCP asc limit 12 offset ?";
                }
                break;
            case "2":
                if (idOrdenarUsuarios.equals("1")) {
                    sql = "select idUsuario, nombre, apellido, rol, codigoPUCP, condicion, fotoPerfil, descripcionPerfil from usuario where estadoRegistro='Registrado' AND rol!='Delegado General' and concat(nombre,' ',apellido) like ? order by if(condicion='Estudiante',1,0) limit 12 offset ?";
                } else {
                    sql = "select idUsuario, nombre, apellido, rol, codigoPUCP, condicion, fotoPerfil, descripcionPerfil from usuario where estadoRegistro='Registrado' AND rol!='Delegado General' and concat(nombre,' ',apellido) like ? order by if(condicion='Estudiante',0,1) limit 12 offset ?";
                }
                break;
            case "3":
                if (idOrdenarUsuarios.equals("1")) {
                    sql = "select u.idUsuario, u.nombre, u.apellido, u.rol, u.codigoPUCP, u.condicion, u.fotoPerfil, u.descripcionPerfil from usuario u left join ban b on u.idUsuario=b.idUsuario where estadoRegistro='Registrado' AND rol!='Delegado General' and concat(u.nombre,' ',u.apellido) like ? order by if(b.idBan is not null,1,0) limit 12 offset ?";
                } else {
                    sql = "select u.idUsuario, u.nombre, u.apellido, u.rol, u.codigoPUCP, u.condicion, u.fotoPerfil, u.descripcionPerfil from usuario u left join ban b on u.idUsuario=b.idUsuario where estadoRegistro='Registrado' AND rol!='Delegado General' and concat(u.nombre,' ',u.apellido) like ? order by if(b.idBan is not null,0,1) limit 12 offset ?";
                }
                break;
            default:
                sql = "select idUsuario, nombre, apellido, rol, codigoPUCP, condicion, fotoPerfil, descripcionPerfil from usuario where estadoRegistro='Registrado' AND rol!='Delegado General' and concat(nombre,' ',apellido) like ? limit 12 offset ?";
                break;
        }
        try(Connection conn=this.getConnection(); PreparedStatement pstmt=conn.prepareStatement(sql)){

            if (nombre==null){
                pstmt.setString(1,"%%");
            }else{
                pstmt.setString(1,"%"+nombre+"%");
            }
            pstmt.setInt(2,pagina*12);
            try (ResultSet rs=pstmt.executeQuery()){
                while (rs.next()){
                    Usuario u=new Usuario();
                    u.setIdUsuario(rs.getInt(1));
                    u.setNombre(rs.getString(2));
                    u.setApellido(rs.getString(3));
                    u.setRol(rs.getString(4));
                    u.setCodigoPUCP(rs.getString(5));
                    u.setCondicion(rs.getString(6));
                    u.setFotoPerfil(rs.getBlob(7));
                    u.setDescripcionPerfil(rs.getString(8));
                    listaUsuarios.add(u);
                }
                return listaUsuarios;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public ArrayList<Usuario>listarUsuarioXnombre(String nombre){
        ArrayList<Usuario>listaUsuarios=new ArrayList<>();
        String sql = "select idUsuario, nombre, apellido, rol, codigoPUCP, condicion, fotoPerfil, descripcionPerfil from usuario where estadoRegistro='Registrado' AND rol!='Delegado General' and concat(nombre,' ',apellido) like ?";
        try(Connection conn=this.getConnection(); PreparedStatement pstmt=conn.prepareStatement(sql)){
            pstmt.setString(1,"%"+nombre+"%");
            try (ResultSet rs=pstmt.executeQuery()){
                while (rs.next()){
                    Usuario u=new Usuario();
                    u.setIdUsuario(rs.getInt(1));
                    u.setNombre(rs.getString(2));
                    u.setApellido(rs.getString(3));
                    u.setRol(rs.getString(4));
                    u.setCodigoPUCP(rs.getString(5));
                    u.setCondicion(rs.getString(6));
                    u.setFotoPerfil(rs.getBlob(7));
                    u.setDescripcionPerfil(rs.getString(8));
                    listaUsuarios.add(u);
                }return listaUsuarios;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public ArrayList<Usuario>listarUsuariosFiltro(String idFiltroUsuarios,String idOrdenarUsuarios, int pagina){
        ArrayList<Usuario>listaUsuarios=new ArrayList<>();
        String sql="";
        switch (idFiltroUsuarios) {
            case "0":
                if (idOrdenarUsuarios.equals("1")) {
                    sql = "select idUsuario, nombre, apellido, rol, codigoPUCP, condicion, fotoPerfil, descripcionPerfil from usuario where estadoRegistro='Registrado' AND rol!='Delegado General' order by nombre desc limit 12 offset ?";
                } else {
                    sql = "select idUsuario, nombre, apellido, rol, codigoPUCP, condicion, fotoPerfil, descripcionPerfil from usuario where estadoRegistro='Registrado' AND rol!='Delegado General' order by nombre asc limit 12 offset ?";
                }
                break;
            case "1":
                if (idOrdenarUsuarios.equals("1")) {
                    sql = "select idUsuario, nombre, apellido, rol, codigoPUCP, condicion, fotoPerfil, descripcionPerfil from usuario where estadoRegistro='Registrado' AND rol!='Delegado General' order by codigoPUCP desc limit 12 offset ?";
                } else {
                    sql = "select idUsuario, nombre, apellido, rol, codigoPUCP, condicion, fotoPerfil, descripcionPerfil from usuario where estadoRegistro='Registrado' AND rol!='Delegado General' order by codigoPUCP asc limit 12 offset ?";
                }
                break;
            case "2":
                if (idOrdenarUsuarios.equals("1")) {
                    sql = "select idUsuario, nombre, apellido, rol, codigoPUCP, condicion, fotoPerfil, descripcionPerfil from usuario where estadoRegistro='Registrado' AND rol!='Delegado General' order by if(condicion='Estudiante',1,0) limit 12 offset ?";
                } else {
                    sql = "select idUsuario, nombre, apellido, rol, codigoPUCP, condicion, fotoPerfil, descripcionPerfil from usuario where estadoRegistro='Registrado' AND rol!='Delegado General' order by if(condicion='Estudiante',0,1) limit 12 offset ?";
                }
                break;
            case "3":
                if (idOrdenarUsuarios.equals("1")) {
                    sql = "select u.idUsuario, u.nombre, u.apellido, u.rol, u.codigoPUCP, u.condicion, u.fotoPerfil, u.descripcionPerfil from usuario u left join ban b on u.idUsuario=b.idUsuario where estadoRegistro='Registrado' AND rol!='Delegado General' order by if(b.idBan is not null,1,0) limit 12 offset ?";
                } else {
                    sql = "select u.idUsuario, u.nombre, u.apellido, u.rol, u.codigoPUCP, u.condicion, u.fotoPerfil, u.descripcionPerfil from usuario u left join ban b on u.idUsuario=b.idUsuario where estadoRegistro='Registrado' AND rol!='Delegado General' order by if(b.idBan is not null,0,1) limit 12 offset ?";
                }
                break;
        }
        try(Connection conn=this.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql)){
            pstmt.setInt(1,pagina*12);
            try(ResultSet rs= pstmt.executeQuery()) {
                while (rs.next()) {
                    Usuario u = new Usuario();
                    u.setIdUsuario(rs.getInt(1));
                    u.setNombre(rs.getString(2));
                    u.setApellido(rs.getString(3));
                    u.setRol(rs.getString(4));
                    u.setCodigoPUCP(rs.getString(5));
                    u.setCondicion(rs.getString(6));
                    u.setFotoPerfil(rs.getBlob(7));
                    u.setDescripcionPerfil(rs.getString(8));
                    listaUsuarios.add(u);
                }
                System.out.println(listaUsuarios.size());
                return listaUsuarios;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public ArrayList<Usuario>listarUsuariosFiltro(int idFiltroUsuarios,int idOrdenarUsuarios){
        ArrayList<Usuario>listaUsuarios=new ArrayList<>();
        String sql="";
        if(idFiltroUsuarios==0){
            if(idOrdenarUsuarios==1){
                sql = "select idUsuario, nombre, apellido, rol, codigoPUCP, condicion, fotoPerfil, descripcionPerfil from usuario where estadoRegistro='Registrado' AND rol!='Delegado General' order by nombre desc ";
            }else{
                sql = "select idUsuario, nombre, apellido, rol, codigoPUCP, condicion, fotoPerfil, descripcionPerfil from usuario where estadoRegistro='Registrado' AND rol!='Delegado General' order by nombre asc";
            }
        }else if(idFiltroUsuarios==1){
            if(idOrdenarUsuarios==1){
                sql = "select idUsuario, nombre, apellido, rol, codigoPUCP, condicion, fotoPerfil, descripcionPerfil from usuario where estadoRegistro='Registrado' AND rol!='Delegado General' order by codigoPUCP desc ";
            }else{
                sql = "select idUsuario, nombre, apellido, rol, codigoPUCP, condicion, fotoPerfil, descripcionPerfil from usuario where estadoRegistro='Registrado' AND rol!='Delegado General' order by codigoPUCP asc ";
            }
        }else if(idFiltroUsuarios==2){
            if(idOrdenarUsuarios==1){
                sql = "select idUsuario, nombre, apellido, rol, codigoPUCP, condicion, fotoPerfil, descripcionPerfil from usuario where estadoRegistro='Registrado' AND rol!='Delegado General' order by if(condicion='Estudiante',1,0)";
            }else{
                sql = "select idUsuario, nombre, apellido, rol, codigoPUCP, condicion, fotoPerfil, descripcionPerfil from usuario where estadoRegistro='Registrado' AND rol!='Delegado General' order by if(condicion='Estudiante',0,1)";
            }
        }else if(idFiltroUsuarios==3) {
            if (idOrdenarUsuarios == 1) {
                sql = "select u.idUsuario, u.nombre, u.apellido, u.rol, u.codigoPUCP, u.condicion, u.fotoPerfil, u.descripcionPerfil from usuario u left join ban b on u.idUsuario=b.idUsuario where estadoRegistro='Registrado' AND rol!='Delegado General' order by if(b.idBan is not null,1,0)";
            } else {
                sql = "select u.idUsuario, u.nombre, u.apellido, u.rol, u.codigoPUCP, u.condicion, u.fotoPerfil, u.descripcionPerfil from usuario u left join ban b on u.idUsuario=b.idUsuario where estadoRegistro='Registrado' AND rol!='Delegado General' order by if(b.idBan is not null,0,1)";           }
        }
        try(Connection conn=this.getConnection(); ResultSet rs=conn.createStatement().executeQuery(sql);){
            while (rs.next()){
                Usuario u=new Usuario();
                u.setIdUsuario(rs.getInt(1));
                u.setNombre(rs.getString(2));
                u.setApellido(rs.getString(3));
                u.setRol(rs.getString(4));
                u.setCodigoPUCP(rs.getString(5));
                u.setCondicion(rs.getString(6));
                u.setFotoPerfil(rs.getBlob(7));
                u.setDescripcionPerfil(rs.getString(8));
                listaUsuarios.add(u);
            }
            System.out.println(listaUsuarios.size());
            return listaUsuarios;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public boolean usuarioEsDelegadoDeActividad(String idUsuario){
        String sql = "select rol from usuario where idUsuario=?";
        try(Connection conn=this.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)){
            pstmt.setString(1,idUsuario);
            try(ResultSet rs = pstmt.executeQuery()){
                if(rs.next()){
                    return rs.getString(1).equals("Delegado de Actividad");
                }else{
                    return false;
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public String obtenerDelegaturaPorId(int idUsuario){
        String sql = "select nombre from actividad where idDelegadoDeActividad=?";
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

    public ArrayList<String> obtenerInfoPorId(int idUsuario){
        ArrayList<String> listaInfo = new ArrayList<>();
        String sql = "select codigoPUCP, correo, condicion from usuario where idUsuario=?";
        try(Connection conn=this.getConnection(); PreparedStatement pstmt=conn.prepareStatement(sql)){
            pstmt.setInt(1,idUsuario);
            try(ResultSet rs = pstmt.executeQuery()){
                if(rs.next()){
                    listaInfo.add(rs.getString(1));
                    listaInfo.add(rs.getString(2));
                    listaInfo.add(rs.getString(3));
                }
                return listaInfo;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public String obtenerDescripcionPorId(int idUsuario){
        String descripcion="";
        String sql = "select descripcionPerfil from usuario where idUsuario=?";
        try(Connection conn=this.getConnection(); PreparedStatement pstmt=conn.prepareStatement(sql)){
            pstmt.setInt(1,idUsuario);
            try(ResultSet rs = pstmt.executeQuery()){
                if(rs.next()){
                    descripcion = rs.getString(1);
                }
                return descripcion;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public Usuario getUsuarioPorId(Integer Id){
        DaoUsuario  daoUsuario = new DaoUsuario();
        ArrayList<Usuario> listaUsuario = daoUsuario.listarUsuarios();
        for (Usuario usuario : listaUsuario){
            if(usuario.getIdUsuario() == Id){
                return usuario;
            }
        }
        return null;
    }

    public Usuario getUsuarioPorIdSinFiltro(int Id) throws SQLException {
        Usuario usuario = new Usuario();
        String sql = "select idUsuario, nombre, apellido, rol, codigoPUCP, condicion, fotoPerfil, fotoSeguro, descripcionPerfil from usuario WHERE idUsuario = ?";
        try(Connection conn=this.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)){
            pstmt.setInt(1,Id);
            try(ResultSet rs = pstmt.executeQuery()){
                if(rs.next()){
                    usuario.setIdUsuario(rs.getInt(1));
                    usuario.setNombre(rs.getString(2));
                    usuario.setApellido(rs.getString(3));
                    usuario.setRol(rs.getString(4));
                    usuario.setCodigoPUCP(rs.getString(5));
                    usuario.setCondicion(rs.getString(6));
                    usuario.setFotoPerfil(rs.getBlob(7));
                    usuario.setFotoSeguro(rs.getBlob(8));
                    usuario.setDescripcionPerfil(rs.getString(9));
                }
            }
            return usuario;
        }catch(SQLException e){
            throw new SQLException(e);
        }
    }


    //CRUD
    public void cambioDescripcion(String nuevaDescripcion , Integer idUsuario){
        String sql = "update usuario set descripcionPerfil = ? where idUsuario = ?";

        try(Connection conn=this.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)){

            pstmt.setString(1,nuevaDescripcion);
            pstmt.setInt(2,idUsuario);
            pstmt.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    public void registroDeAlumno(String name, String apellido, String correo, String contrasena, String codigoPUCP, String condicion){
        String sql = "insert into usuario( rol, nombre, apellido, correo, contrasena, codigoPUCP, estadoRegistro, fechaHoraRegistro,condicion,DescripcionPerfil) values (?,?,?,?,sha2(?,256),?,?,(select now()),?, 'Vamos Fibra')";
        try (Connection conn=this.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql,Statement.RETURN_GENERATED_KEYS)) {
            //pstmt.setInt(1,idUser);
            pstmt.setString(1,"Alumno"); //nuevos usuarios se registran como alumnos
            pstmt.setString(2,name);
            pstmt.setString(3, apellido);
            pstmt.setString(4,correo);
            pstmt.setString(5,contrasena);
            pstmt.setString(6,codigoPUCP);
            pstmt.setString(7,"Pendiente");//para cambiar el estado es con otro método
            //Ajustar a como debe estar en la base de datos este valor viene del jsp que solo tiene botones para esooger
            pstmt.setString(8,condicion);
            pstmt.executeUpdate();
            ResultSet rskeys=pstmt.getGeneratedKeys();
            if(rskeys.next()){
                new DaoNotificacion().crearNotificacionSolicitudDeRegistro(rskeys.getInt(1));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

    }



    public void cambiarEstadoRegistroUsuario(int idUser, String estado){
        String sql = "update usuario set estadoRegistro = ? where idUsuario = ?";

        try(Connection conn=this.getConnection(); PreparedStatement pstmt=conn.prepareStatement(sql)){
            pstmt.setString(1,estado);
            pstmt.setInt(2,idUser);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }


    }

    public String getEstadoDeResgitroPorId(int id){
        String sql = "select estadoRegistro from usuario where  idUsuario = ?";

        try(Connection conn=this.getConnection(); PreparedStatement pstmt=conn.prepareStatement(sql)){
            pstmt.setInt(1,id);
            try(ResultSet rs = pstmt.executeQuery()){
                if(rs.next()){
                    return rs.getString(1);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return "";
    }
    public float donacionPorIdUser(int idUser){
        String sql = "select sum(monto)  from donacion where idUsuario = ?";
        try(Connection conn=this.getConnection(); PreparedStatement pstmt=conn.prepareStatement(sql)){
            pstmt.setInt(1,idUser);
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
    public ArrayList<Integer> listaIdEgresados(){
        ArrayList<Integer> listIdEgresados = new ArrayList<>();

        String sql = "select idUsuario from usuario where condicion = 'Egresado'";
        try(Connection conn=this.getConnection(); ResultSet rs=conn.prepareStatement(sql).executeQuery()){
            while(rs.next()){
                listIdEgresados.add(rs.getInt(1));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return listIdEgresados;
    }
    public void cambiarFoto(int idUser, InputStream foto, boolean validacion, String tipo){
        tipo = tipo.equals("1")?"fotoPerfil":"fotoSeguro";

        String sql = "update usuario set "+tipo+" = ? where idUsuario = ?";
        try(Connection conn=this.getConnection(); PreparedStatement pstmt=conn.prepareStatement(sql)){
            if(!validacion){
                pstmt.setNull(1,Types.BLOB);
            }else{
                pstmt.setBinaryStream(1,foto,foto.available());
            }
            pstmt.setInt(2,idUser);
            pstmt.executeUpdate();
        } catch (SQLException | IOException e) {
            throw new RuntimeException(e);
        }
    }

    public int obtenerIdPorCorreo (String correo){
        int id = 0;
        String sql = "select idUsuario from usuario where correo =?";
        try(Connection conn=this.getConnection(); PreparedStatement pstmt=conn.prepareStatement(sql)){
            pstmt.setString(1,correo);
            try(ResultSet rs = pstmt.executeQuery()){
                if(rs.next()) {
                    id = rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return id;
    }


    public int obtenerIdRegistradoPorCorreo (String correo){
        int id = 0;
        String sql = "select idUsuario from usuario where correo =? and (estadoRegistro='Registrado' or estadoRegistro = 'Pendiente') ";
        try(Connection conn=this.getConnection(); PreparedStatement pstmt=conn.prepareStatement(sql)){
            pstmt.setString(1,correo);
            try(ResultSet rs = pstmt.executeQuery()){
                if(rs.next()) {
                    id = rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return id;
    }

    public boolean estaBaneadoporId(String usuarioId){
        boolean baneado = true;
        String sql = "select idUsuario from ban where idUsuario = ?";
        try(Connection conn=this.getConnection(); PreparedStatement pstmt=conn.prepareStatement(sql)){
            pstmt.setString(1,usuarioId);
            try(ResultSet rs = pstmt.executeQuery()){
                if(rs.next()) {
                    if(rs.getString(1).equals(usuarioId)){
                    return false;
                    }
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return baneado;
    }
    public void actualizarContrasena (int idCorreoValidacion, String password){
        String sql = "update usuario set contrasena = sha2(?,256) where idUsuario = (Select idUsuario from validacion where idCorreoValidacion = ?)";
        try(Connection conn=this.getConnection(); PreparedStatement pstmt=conn.prepareStatement(sql)){
            pstmt.setString(1,password);
            pstmt.setInt(2,idCorreoValidacion);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

    }

    public void aceptarRegistro(int idUsuario){
        String sql = "update usuario set estadoRegistro = ? where idUsuario = ? and rol!='Delegado General' and estadoRegistro='Pendiente'";
        try(Connection conn=this.getConnection(); PreparedStatement pstmt=conn.prepareStatement(sql)){
            pstmt.setString(1,"Registrado");
            pstmt.setInt(2,idUsuario);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void rechazarRegistro(int idUsuario){
        String sql = "update usuario set estadoRegistro = ? where idUsuario = ? and rol!='Delegado General' and estadoRegistro='Pendiente'";
        try(Connection conn=this.getConnection(); PreparedStatement pstmt=conn.prepareStatement(sql)){
            pstmt.setString(1,"No registrado");
            pstmt.setInt(2,idUsuario);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    public Integer totalEstudiantesRegistrados(){
        String sql = "select count(idUsuario) from usuario where condicion='Estudiante' and estadoRegistro='Registrado'";
        try(Connection conn=this.getConnection(); ResultSet rs=conn.createStatement().executeQuery(sql)){
            if(rs.next()) {
                return rs.getInt(1);
            }else{
                return 0;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public Integer totalEgresadosRegistrados(){
        String sql = "select count(idUsuario) from usuario where condicion='Egresado' and estadoRegistro='Registrado'";
        try(Connection conn=this.getConnection(); ResultSet rs=conn.createStatement().executeQuery(sql)){
            if(rs.next()) {
                return rs.getInt(1);
            }else{
                return 0;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public Usuario usuarioPorIdNotificacion(int idUsuario){
        String sql = "select nombre,apellido from usuario where idUsuario = ?";
        try(Connection conn=this.getConnection(); PreparedStatement pstmt=conn.prepareStatement(sql)){
            pstmt.setInt(1,idUsuario);
            try(ResultSet rs = pstmt.executeQuery()){
                if(rs.next()){
                    Usuario u=new Usuario();
                    u.setNombre(rs.getString(1));
                    u.setApellido(rs.getString(2));
                    return u;
                }else{
                    return null;
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public Usuario usuarioSesion(int idUsuario){
        String sql = "select idUsuario,rol,nombre,apellido,fotoPerfil,fotoSeguro,estadoRegistro from usuario where idUsuario = ?";
        try(Connection conn=this.getConnection(); PreparedStatement pstmt=conn.prepareStatement(sql)){
            pstmt.setInt(1,idUsuario);
            try(ResultSet rs = pstmt.executeQuery()){
                if(rs.next()){
                    Usuario u=new Usuario();
                    u.setIdUsuario(rs.getInt(1));
                    u.setRol(rs.getString(2));
                    u.setNombre(rs.getString(3));
                    u.setApellido(rs.getString(4));
                    u.setFotoPerfil(rs.getBlob(5));
                    u.setFotoSeguro(rs.getBlob(6));
                    u.setEstadoRegistro(rs.getString(7));
                    return u;
                }else{
                    return null;
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public Ban logIn(String correo, String contrasena){
        String sql = "select u.idUsuario,u.estadoRegistro,b.idBan,b.motivoBan from usuario u left join ban b on u.idUsuario=b.idUsuario where u.correo=? and u.contrasena=sha2(?,256) and u.estadoRegistro='Registrado'";
        try(Connection conn=this.getConnection(); PreparedStatement pstmt=conn.prepareStatement(sql)){
            pstmt.setString(1,correo);
            pstmt.setString(2,contrasena);
            try(ResultSet rs = pstmt.executeQuery()){
                if(rs.next()){
                    Ban b=new Ban();
                    b.getUsuario().setIdUsuario(rs.getInt(1));
                    b.getUsuario().setEstadoRegistro(rs.getString(2));
                    b.setIdBan(rs.getInt(3));
                    b.setMotivoBan(rs.getString(4));
                    return b;
                }else{
                    return null;
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public Blob getFotoPerfilPorIDUsuario(int idUsuario){
        String sql = "select fotoPerfil from usuario where idUsuario=?";
        try(Connection conn=this.getConnection(); PreparedStatement pstmt=conn.prepareStatement(sql)){
            pstmt.setInt(1,idUsuario);
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

    public boolean existeUsuario(String idUsuario){
        String sql="select * from usuario where idUsuario=?";
        try(Connection conn=this.getConnection(); PreparedStatement pstmt= conn.prepareStatement(sql)){
            pstmt.setString(1,idUsuario);
            try(ResultSet rs=pstmt.executeQuery()){
                return rs.next();
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }


    public boolean esDelegado(String idUsuario){
        String sql="select idUsuario from usuario where idUsuario=? and rol!='Alumno'";
        try(Connection conn=this.getConnection(); PreparedStatement pstmt= conn.prepareStatement(sql)){
            pstmt.setString(1,idUsuario);
            try(ResultSet rs=pstmt.executeQuery()){
                return rs.next();
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public boolean esAlumnoRegistradoNoBaneado(String idUsuario){
        String sql="select u.idUsuario from usuario u left join ban b on u.idUsuario = b.idUsuario where u.idUsuario=? and b.idBan is null and u.rol='Alumno' and u.estadoRegistro='Registrado'";
        try(Connection conn=this.getConnection(); PreparedStatement pstmt= conn.prepareStatement(sql)){
            pstmt.setString(1,idUsuario);
            try(ResultSet rs=pstmt.executeQuery()){
                return rs.next();
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public boolean esBaneable(String idUsuario){
        String sql="select u.idUsuario from usuario u left join ban b on u.idUsuario = b.idUsuario where u.idUsuario=? and b.idBan is null and u.rol!='Delegado General' and u.estadoRegistro='Registrado'";
        try(Connection conn=this.getConnection(); PreparedStatement pstmt= conn.prepareStatement(sql)){
            pstmt.setString(1,idUsuario);
            try(ResultSet rs=pstmt.executeQuery()){
                return rs.next();
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public boolean esEgresado(int idUsuario){
        String sql="select idUsuario from usuario where condicion='Egresado' and idUsuario=?";
        try(Connection conn=this.getConnection(); PreparedStatement pstmt= conn.prepareStatement(sql)){
            pstmt.setInt(1,idUsuario);
            try(ResultSet rs=pstmt.executeQuery()){
                return rs.next();
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
