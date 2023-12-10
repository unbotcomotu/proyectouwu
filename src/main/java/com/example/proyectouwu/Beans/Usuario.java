package com.example.proyectouwu.Beans;

import com.example.proyectouwu.Daos.DaoNotificacion;
import com.example.proyectouwu.Daos.DaoValidacion;

import java.sql.Blob;
import java.sql.Date;
import java.sql.Time;
import java.util.Properties;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
public class Usuario {
    //ATRIBUTOS
    private Integer idUsuario;
    private String rol;
    private String nombre;
    private String apellido;
    private String correo;
    private String contrasena;
    private String codigoPUCP;
    private String estadoRegistro = "Pendiente";
    private Date fechaRegistro;
    private Time horaRegistro;
    private String condicion;
    private Blob fotoPerfil;
    private Blob fotoSeguro;
    private String descripcionPerfil;
    private boolean recibioKit;

    //GETTERS AND SETTERS

    public Integer getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(Integer idUsuario) {
        this.idUsuario = idUsuario;
    }

    public String getRol() {
        return rol;
    }

    public void setRol(String rol) {
        this.rol = rol;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getApellido() {
        return apellido;
    }

    public void setApellido(String apellido) {
        this.apellido = apellido;
    }

    public String getCorreo() {
        return correo;
    }

    public void setCorreo(String correo) {
        this.correo = correo;
    }

    public String getContrasena() {
        return contrasena;
    }

    public void setContrasena(String contrasena) {
        this.contrasena = contrasena;
    }

    public String getCodigoPUCP() {
        return codigoPUCP;
    }

    public void setCodigoPUCP(String codigoPUCP) {
        this.codigoPUCP = codigoPUCP;
    }

    public String getEstadoRegistro() {
        return estadoRegistro;
    }

    public void setEstadoRegistro(String estadoRegistro) {
        this.estadoRegistro = estadoRegistro;
    }

    public Date getFechaRegistro() {
        return fechaRegistro;
    }

    public void setFechaRegistro(Date fechaRegistro) {
        this.fechaRegistro = fechaRegistro;
    }

    public Time getHoraRegistro() {
        return horaRegistro;
    }

    public void setHoraRegistro(Time horaRegistro) {
        this.horaRegistro = horaRegistro;
    }

    public String getCondicion() {
        return condicion;
    }

    public void setCondicion(String condicion) {
        this.condicion = condicion;
    }

    public Blob getFotoPerfil() {
        return fotoPerfil;
    }

    public void setFotoPerfil(Blob fotoPerfil) {
        this.fotoPerfil = fotoPerfil;
    }

    public Blob getFotoSeguro() {
        return fotoSeguro;
    }

    public void setFotoSeguro(Blob fotoSeguro) {
        this.fotoSeguro = fotoSeguro;
    }

    public String getDescripcionPerfil() {
        return descripcionPerfil;
    }

    public void setDescripcionPerfil(String descripcionPerfil) {
        this.descripcionPerfil = descripcionPerfil;
    }

    public boolean isRecibioKit() {
        return recibioKit;
    }

    public void setRecibioKit(boolean recibioKit) {
        this.recibioKit = recibioKit;
    }

    //Metodo extra
    public void enviarCorreo(String idValidacion){
        int id = Integer.parseInt(idValidacion);
        Properties p = new Properties();
        p.put("mail.smtp.host", "smtp.gmail.com" );
        p.put("mail.smtp.port", "587");
        p.put("mail.smtp.auth", "true");
        p.put("mail.smtp.starttls.enable", "true");
        Session session = Session.getInstance(p, new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication("hineill.cespedes@pucp.edu.pe", "senode1234xiguala1234x");
            }
        });

        try {
            Message message = new MimeMessage(session);

            message.setFrom(new InternetAddress("hineill.cespedes@pucp.edu.pe"));

            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse("a20213849@pucp.edu.pe"));
            String tipoValidacion = new DaoValidacion().tipoValidacionPorID(id);
            switch(tipoValidacion){
                case"enviarLinkACorreo":
                    message.setSubject("Asunto del correo : ola ");

                    message.setText("Hola, q quieres? ");

                    Transport.send(message);

                    System.out.println("Correo enviado con éxito.");
                    break;
                case "recuperarContrasena":
                    message.setSubject("Asunto del correo : ola ");

                    message.setText("Hola, q quieres? ");

                    Transport.send(message);

                    System.out.println("Correo enviado con éxito.");
                    break;
            }


        } catch (MessagingException e) {
            throw new RuntimeException(e);
        }





    }
}
