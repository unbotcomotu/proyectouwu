package com.example.proyectouwu.Beans;

import com.example.proyectouwu.Daos.*;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.DayOfWeek;

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
    public static String  ip = "34.136.47.112";
    public static String nombreProyecto="SemanaDeIngenieria" ;
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
            String destinatario = new DaoValidacion().getValidacionXId(id).getCorreo() ;
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(destinatario));
            Validacion  validacion = new DaoValidacion().getValidacionXId(id);
            String tipoValidacion = new DaoValidacion().tipoValidacionPorID(id);
            String link= null;

            switch(tipoValidacion){
                case"enviarLinkACorreo":
                    link = ip+":8080/"+ nombreProyecto +"/RegistroServlet?idCorreoValidacion=" + validacion.getIdCorreoValidacion() + "&codigoValidacion256=" + validacion.getCodigoValidacion256();
                    message.setSubject("Verificación de correo electrónico durante registro - Siempre Fibra");
                    message.setText("¡Continua con tu registro! Haz clic en el siguiente link y completa tus datos: \n" +  link +"\n\nRecuerde que el uso de este link es único por solicitud de registro\n\nSiempre Fibra\nMesa Directiva 2023");
                    Transport.send(message);
                    System.out.println("Correo enviado con éxito.");
                    break;
                case "recuperarContrasena":
                    link = ip+":8080/"+ nombreProyecto +"/RecuperarContrasenaSegundoCasoServlet?idCorreoValidacion=" + validacion.getIdCorreoValidacion() + "&codigoValidacion256=" + validacion.getCodigoValidacion256();
                    message.setSubject("Solicitud de recuperación de contraseña - Siempre Fibra ");
                    message.setText("¡Continúa con el proceso de recuperación de contraseña! Haz clic en el siguiente link e ingrese su nueva contraseña:\n"+ link +"\n\nSiempre Fibra\nMesa Directiva 2023");
                    Transport.send(message);
                    System.out.println("Correo enviado con éxito.");
                    break;
                case "NecesitaUnKit":
                    String fecha = obtenerFechaManana() ;
                    message.setSubject("Te ganaste el kit teleco - Siempre Fibra");
                    message.setText("¡Felicidades! Demostraste ser un real seguidor de la fibra con tu constante apoyo. Por tal motivo, queremos recompensarte con un kit teleco. \n" +
                            "Podrás recoger tu kit en la bati (primer piso del V) el día : "+ fecha + " a las 3pm.\n\nEn caso no sea posible su asistencia tal día, responda el correo indicando sus fechas tentativas.\n\nSiempre Fibra\nMesa Directiva 2023");
                    Transport.send(message);
                    System.out.println("Correo enviado con éxito.");
                    break;
            }
        } catch (MessagingException e) {
            throw new RuntimeException(e);
        }

    }
    public void enviarCorreoAceptado(String correoDestinatario ){
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
            String destinatario = correoDestinatario ;
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(destinatario));
            String link = ip+":8080/"+nombreProyecto + "/InicioSesionServlet";
            message.setSubject("Proceso de registro completado - Siempre Fibra");
            message.setText("¡Bienvenido a la plataforma web de la Fibra!\nAquí podrás observar los resultados y la gestión de todos los eventos durante la realización de las actividades.\n\nEsperamos su participación activa durante Semana de Ingeniería." +
                    " Dale clic aquí para continuar: \n" +  link +"\n\nSiempre Fibra\nMesa Directiva 2023");
            Transport.send(message);
            System.out.println("Correo enviado con éxito.");

        } catch (MessagingException e) {
            throw new RuntimeException(e);
        }

    }
    public void enviarCorreoRechazado(String correo , String motivo ){
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
            String destinatario = correo ;
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(destinatario));
            String link = ip+":8080/" +nombreProyecto +"/InicioSesionServlet";
            message.setSubject("Solicitud de registro rechazada - Siempre Fibra");
            message.setText("Lamentamos informate que no podemos aceptar tu registro a la página web de la fibra por el siguiente motivo: " +  motivo +"\n\nRecuerde que puede realizar el proceso de registro nuevamente.\nEsperamos su comprensión.\n\nSiempre Fibra\nMesa Directiva 2023");
            Transport.send(message);
            System.out.println("Correo enviado con éxito.");

        } catch (MessagingException e) {
            throw new RuntimeException(e);
        }
    }


    public static String obtenerFechaManana() {
        // Obtener la fecha actual
        LocalDate fechaActual = LocalDate.now();

        // Verificar si hoy es sábado
        DayOfWeek diaDeLaSemana = fechaActual.getDayOfWeek();
        boolean esSabado = diaDeLaSemana == DayOfWeek.SATURDAY;

        // Calcular la fecha de mañana o pasado mañana según sea necesario
        LocalDate fechaManana;
        if (esSabado) {
            // Si hoy es sábado, la fecha de mañana es pasado mañana
            fechaManana = fechaActual.plusDays(2);
        } else {
            // Si no es sábado, la fecha de mañana es mañana
            fechaManana = fechaActual.plusDays(1);
        }

        // Formatear la fecha como una cadena (puedes ajustar el formato según tus necesidades)
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
        String fechaMananaFormateada = fechaManana.format(formatter);

        // Devolver la fecha formateada
        return fechaMananaFormateada;
    }

    public void enviarCorreoEvento(int idAlumnoPorEvento,String tipoDeApoyo){
        AlumnoPorEvento alumnoPorEvento = new DaoAlumnoPorEvento().getAlumnoPorEventoXId(idAlumnoPorEvento);
        Evento evento = alumnoPorEvento.getEvento();
        DaoActividad daoActividad = new DaoActividad();
        DaoLugarEvento daoLugarEvento = new DaoLugarEvento();
        String nombreActividad = daoActividad.nombreActividadPorID(daoActividad.obtenerIdActividadPorIdEvento(evento.getIdEvento()));
        String lugarEvento = daoLugarEvento.lugarPorID(evento.getLugarEvento().getIdLugarEvento());
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
            String destinatario = new DaoUsuario().correoUsuarioPorId((Integer) alumnoPorEvento.getAlumno().getIdUsuario());
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(destinatario));

            switch(tipoDeApoyo){
                case"Barra":
                    message.setSubject("Solicitud de apoyo revisada en el evento de "+evento.getTitulo()+" - Siempre Fibra");
                    message.setText("Se aceptó su participación en el evento de " + evento.getTitulo()+" de la actividad " + nombreActividad +" en el siguiente lugar: " + lugarEvento + ", el día " + evento.getFecha() +" a las " + evento.getHora() +".\n\nUsted fue elegido para participar en la barra.\n\nRecuerde seguir las indicaciones del delegado de actividad correspondiente.\nNos vemos en la cancha.\n\nSiempre Fibra\nMesa Directiva 2023");
                    Transport.send(message);
                    System.out.println("Correo enviado con éxito.");
                    break;
                case "Jugador":
                    message.setSubject("Aceptación de participación en Semana de Ingeniería - Siempre Fibra");
                    message.setText("Se aceptó su participación en el evento de " + evento.getTitulo()+" de la actividad " + nombreActividad +" en el siguiente lugar: " + lugarEvento + ", el día " + evento.getFecha() +" a las " + evento.getHora() +".\n\nUsted fue elegido para participar como jugador.\n\nRecuerde seguir las indicaciones del delegado de actividad correspondiente.\nNos vemos en la cancha.\n\nSiempre Fibra\nMesa Directiva 2023");
                    Transport.send(message);
                    System.out.println("Correo enviado con éxito.");
                    break;
            }
        } catch (MessagingException e) {
            throw new RuntimeException(e);
        }

    }

}
