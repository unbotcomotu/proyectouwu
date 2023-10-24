package com.example.proyectouwu.Daos;

import com.example.proyectouwu.Beans.Evento;
import com.example.proyectouwu.Beans.Usuario;

import java.sql.*;
import java.util.ArrayList;
import java.util.logging.StreamHandler;

public class DaoUsuario {
    private Connection conn;
    {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn= DriverManager.getConnection("jdbc:mysql://localhost:3306/proyecto","root","root");
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
}
