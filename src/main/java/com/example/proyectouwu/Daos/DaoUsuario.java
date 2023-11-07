package com.example.proyectouwu.Daos;

import com.example.proyectouwu.Beans.Evento;
import com.example.proyectouwu.Beans.Usuario;

import java.sql.*;
import java.util.ArrayList;
import java.util.Random;
import java.util.logging.StreamHandler;

public class DaoUsuario extends DaoPadre {
    private Connection conn;
    {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn= DriverManager.getConnection("jdbc:mysql://localhost:3306/proyecto",super.getUser(),super.getPassword());
        } catch (ClassNotFoundException | SQLException e) {
            throw new RuntimeException(e);
        }
    }
    public String rolUsuarioPorId(int idUsuario){
        String sql="select rol from usuario where idUsuario=?";
        try(PreparedStatement pstmt= conn.prepareStatement(sql)){
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
        try(PreparedStatement pstmt= conn.prepareStatement(sql)){
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
        try(PreparedStatement pstmt= conn.prepareStatement(sql)){
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
        try(PreparedStatement pstmt= conn.prepareStatement(sql)){
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
        try(PreparedStatement pstmt= conn.prepareStatement(sql)){
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
        try(ResultSet rs=conn.createStatement().executeQuery(sql)){
            while(rs.next()){
                listaCorreosDelegadosGenerales.add(rs.getString(1));
            }return listaCorreosDelegadosGenerales;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public ArrayList<Usuario>listarIDyNombreDelegadosDeActividad(){
        ArrayList<Usuario>listaDelegadosDeActividad=new ArrayList<>();
        String sql="select idUsuario,nombre,apellido from usuario where rol='Delegado de Actividad'";
        try(ResultSet rs=conn.createStatement().executeQuery(sql)){
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
        try(ResultSet rs = conn.prepareStatement(sql).executeQuery()){
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

    public ArrayList<Usuario> listarUsuariosTotal(){
        ArrayList<Usuario> lista = new ArrayList<>();
        String sql = "select idUsuario , correo , contrasena from usuario";
        try(ResultSet rs = conn.prepareStatement(sql).executeQuery()){
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

    public boolean usuarioEsDelegadoDeActividad(int idUsuario){
        String sql = "select rol from usuario where idUsuario=?";
        try(PreparedStatement pstmt = conn.prepareStatement(sql)){
            pstmt.setInt(1,idUsuario);
            try(ResultSet rs = pstmt.executeQuery()){
                if(rs.next()){
                    if(rs.getString(1).equals("Delegado de Actividad")){
                        return true;
                    }else{
                        return false;
                    }
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

        try(PreparedStatement pstmt=conn.prepareStatement(sql)){
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
        try(PreparedStatement pstmt=conn.prepareStatement(sql)){
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
        try(PreparedStatement pstmt=conn.prepareStatement(sql)){
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

    public Usuario getUsuarioPorId(int Id){
        DaoUsuario  daoUsuario = new DaoUsuario();
        ArrayList<Usuario> listaUsuario = daoUsuario.listarUsuarios();
        for (Usuario usuario : listaUsuario){
            if(usuario.getIdUsuario() == Id){
                return usuario;
            }
        }
        return null;
    }

    //CRUD
    public void cambioDescripcion(String nuevaDescripcion , Integer idUsuario){
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
        String sql = "update usuario set descripcionPerfil = ? where idusuario = ?";

        try(PreparedStatement pstmt = conn.prepareStatement(sql)){

            pstmt.setString(1,nuevaDescripcion);
            pstmt.setInt(2,idUsuario);
            pstmt.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    public void registroDeAlumno(String name, String apellido, String correo, String contrasena, String codigoPUCP, String condicion){
        String sql = "insert into usuario( rol, nombre, apellido, correo, contrasena, codigoPUCP, estadoRegistro, fechaHoraRegistro,condicion) values (?, ?,?, ?,?, ?,?,(select now()),?)";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
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
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

    }



    public void cambiarEstadoRegistroUsuario(int idUser, String estado){
        String sql = "update usuario set estadoRegistro = ? where idUsuario = ?";

        try(PreparedStatement pstmt=conn.prepareStatement(sql)){
            pstmt.setString(1,estado);
            pstmt.setInt(2,idUser);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }


    }

    public String getEstadoDeResgitroPorId(int id){
        String sql = "select estadoRegistro from usuario where  idUsuario = ?";

        try(PreparedStatement pstmt=conn.prepareStatement(sql)){
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
        try(PreparedStatement pstmt=conn.prepareStatement(sql)){
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
        try(ResultSet rs = conn.prepareStatement(sql).executeQuery()){
            while(rs.next()){
                listIdEgresados.add(rs.getInt(1));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return listIdEgresados;
    }
    public void cambiarFoto(int idUser, Blob foto){
        String sql = "update usuario set fotoSeguro = ? where idUsuario = ?";
        try(PreparedStatement pstmt=conn.prepareStatement(sql)){
            pstmt.setBlob(1,foto);
            pstmt.setInt(2,idUser);

            pstmt.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

    }


    public int obtenerIdPorCorreo (String correo){
        int id = 0;
        String sql = "select idusuario from usuario where correo =?";
        try(PreparedStatement pstmt=conn.prepareStatement(sql)){
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

    public boolean estaBaneadoporId(int usuarioId){
        boolean baneado = true;
        String sql = "SELECT idUsuario FROM proyecto.ban where idUsuario = ?";
        try(PreparedStatement pstmt=conn.prepareStatement(sql)){
            pstmt.setInt(1,usuarioId);
            try(ResultSet rs = pstmt.executeQuery()){
                if(rs.next()) {
                    if(rs.getInt(1) == usuarioId ){
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
        String sql = "update usuario set contrasena = ? where idUsuario = (Select idUsuario from validacion where idCorreoValidacion = ?)";
        try(PreparedStatement pstmt=conn.prepareStatement(sql)){
            pstmt.setString(1,password);
            pstmt.setInt(2,idCorreoValidacion);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

    }
}
