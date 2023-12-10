package com.example.proyectouwu.Daos;

import com.example.proyectouwu.Beans.MensajeChat;
import com.example.proyectouwu.Beans.Usuario;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DaoMensajeChat extends DaoPadre {
    public MensajeChat obtenerUltimoMensajeChat(int idEvento){
        String sql="select u.idUsuario,u.nombre,u.apellido,u.fotoPerfil,m.idMensajeChat,m.idEvento,m.mensaje,date(m.fechaHora),time(m.fechaHora) from mensajechat m inner join usuario u on m.idUsuario=u.idUsuario where m.idEvento=? order by m.fechaHora desc limit 1";
        try(PreparedStatement pstmt= getConnection().prepareStatement(sql)){
            pstmt.setInt(1,idEvento);
            try(ResultSet rs=pstmt.executeQuery()){
                if(rs.next()){
                    MensajeChat m=new MensajeChat();
                    m.getUsuario().setIdUsuario(rs.getInt(1));
                    m.getUsuario().setNombre(rs.getString(2));
                    m.getUsuario().setApellido(rs.getString(3));
                    m.getUsuario().setFotoPerfil(rs.getBlob(4));
                    m.setIdMensajeChat(rs.getInt(5));
                    m.getEvento().setIdEvento(rs.getInt(6));
                    m.setMensaje(rs.getString(7));
                    m.setFecha(rs.getDate(8));
                    m.setHora(rs.getTime(9));
                    return m;
                }else {
                    return null;
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
