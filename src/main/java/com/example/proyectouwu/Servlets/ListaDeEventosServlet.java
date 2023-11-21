package com.example.proyectouwu.Servlets;

import com.example.proyectouwu.Beans.Evento;
import com.example.proyectouwu.Beans.Usuario;
import com.example.proyectouwu.Daos.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Time;
import java.util.ArrayList;
import java.util.HashSet;

@WebServlet(name = "ListaDeEventosServlet", value = "/ListaDeEventosServlet")
@MultipartConfig(maxFileSize = 10000000)
public class ListaDeEventosServlet extends HttpServlet {


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        DaoUsuario dUsuario=new DaoUsuario();
        DaoEvento dEvento=new DaoEvento();
        DaoActividad dActividad=new DaoActividad();
        Usuario usuario=(Usuario) request.getSession().getAttribute("usuario");
        String pag = request.getParameter("p") == null ? "1" : request.getParameter("p");
        int pagina = Integer.parseInt(pag);
        if(usuario==null){
            response.sendRedirect("InicioSesionServlet");
        }else {
            String idActividadAux=request.getParameter("idActividad");
            if(dActividad.existeActividad(idActividadAux)){
                int idActividad=Integer.parseInt(idActividadAux);
                request.setAttribute("idActividad",idActividad);
                request.setAttribute("vistaActual","listaDeActividades");
                request.setAttribute("correosDelegadosGenerales",dUsuario.listarCorreosDelegadosGenerales());
                request.setAttribute("nombreActividad",dActividad.nombreActividadPorID(idActividad));
                request.setAttribute("delegadoDeEstaActividadID",dActividad.idDelegadoDeActividadPorActividad(idActividad));
                request.setAttribute("listaLugares",new DaoLugarEvento().listarLugares());
                request.setAttribute("cantidadEventosFinalizados",dActividad.cantidadEventosFinalizadosPorActividad(idActividad));
                request.setAttribute("cantidadEventosOcultos",dActividad.cantidadEventosOcultosPorActividad(idActividad));
                request.setAttribute("cantidadEventosApoyando",dActividad.cantidadEventosApoyandoPorActividad(idActividad,usuario.getIdUsuario()));
                request.setAttribute("listaLugaresCantidad",dActividad.lugaresConMayorCantidadDeEventos_cantidad_idLugarEvento(idActividad));
                request.setAttribute("cantidadEventosHoy",dActividad.cantidadEventosEnNdiasPorActividad(idActividad,0));
                request.setAttribute("cantidadEventosManana",dActividad.cantidadEventosEnNdiasPorActividad(idActividad,1));
                request.setAttribute("cantidadEventos2DiasMas", dActividad.cantidadEventosEn2DiasAMasPorActividad(idActividad));
                if(usuario.getRol().equals("Delegado General")){
                    request.setAttribute("listaNotificacionesCampanita",new DaoNotificacionDelegadoGeneral().listarNotificacionesDelegadoGeneral());
                }
                String action = request.getParameter("action") == null ? "default" : request.getParameter("action");
                switch (action){
                    case "buscarEvento":
                        String textoBuscar = request.getParameter("nombreEvento");
                        request.setAttribute("cantidadEventosTotal", dEvento.buscarEventoPorNombre(textoBuscar,idActividad).size());
                        request.setAttribute("listaEventos",dEvento.buscarEventoPorNombre(textoBuscar,idActividad));
                        if(!textoBuscar.isEmpty()){
                            request.setAttribute("busqueda",textoBuscar);
                        }
                        request.getRequestDispatcher("listaDeEventos.jsp").forward(request,response);
                        break;
                    case "default":
                        request.setAttribute("listaEventos",dEvento.listarEventos(idActividad,pagina-1));
                        request.setAttribute("cantidadEventosTotal", dEvento.listarEventos(idActividad).size());
                        request.getRequestDispatcher("listaDeEventos.jsp").forward(request,response);
                        break;
                    case "filtrarEventos":
                        ArrayList<String> parametrosEstado = new ArrayList<>();
                        ArrayList<Integer> parametrosLugar = new ArrayList<>();
                        ArrayList<String> parametrosFecha = new ArrayList<>();

                        if(request.getParameter("eventoFinalizado") != null){
                            parametrosEstado.add("Finalizado");
                            request.setAttribute("eventoFinalizado",1);
                        }
                        if(!usuario.getRol().equals("Delegado General")){
                            if(request.getParameter("eventoApoyando") != null){
                                parametrosEstado.add("Apoyando");
                                request.setAttribute("eventoApoyando",1);
                            }
                        }
                        if(dActividad.idDelegadoDeActividadPorActividad(idActividad) == usuario.getIdUsuario() || usuario.getRol().equals("Delegado General")){
                            if(request.getParameter("eventoOculto") != null){
                                parametrosEstado.add("Oculto");
                                request.setAttribute("eventoOculto",1);
                            }
                        }
                        String cantidad = request.getParameter("cantidadLugares");
                        if(cantidad != null) {
                            int cantidadLugares = Integer.parseInt(request.getParameter("cantidadLugares"));
                            for (int j = 0; j < cantidadLugares; j++) {
                                String lugarAux=request.getParameter("lugar" + j);
                                if(lugarAux!=null){
                                    Integer lugar=Integer.parseInt(lugarAux);
                                    parametrosLugar.add(lugar);
                                    request.setAttribute("lugar" + j,lugar);
                                }
                            }
                        }
                        if(request.getParameter("eventosHoy") != null){
                            parametrosFecha.add("Hoy");
                            request.setAttribute("eventosHoy",1);
                        }
                        if(request.getParameter("eventosManana") != null){
                            parametrosFecha.add("Manana");
                            request.setAttribute("eventosManana",1);
                        }
                        if(request.getParameter("eventosMasDias") != null){
                            parametrosFecha.add("MasDias");
                            request.setAttribute("eventosMasDias",1);
                        }
                        request.setAttribute("listaEventos",dEvento.filtrarEventos(parametrosEstado,parametrosLugar,parametrosFecha,request.getParameter("horaInicio"),request.getParameter("horaFin"),idActividad,usuario.getIdUsuario()));
                        request.setAttribute("horaInicio",request.getParameter("horaInicio"));
                        request.setAttribute("horaFin",request.getParameter("horaFin"));
                        request.getRequestDispatcher("listaDeEventos.jsp").forward(request,response);
                        break;
                    case "filtroOrdenarEvento":
                        request.setAttribute("idOrdenarEventos",Integer.parseInt(request.getParameter("idOrdenarEventos")));
                        request.setAttribute("idSentidoEventos",Integer.parseInt(request.getParameter("idSentidoEventos")));
                        request.setAttribute("listaEventos",dEvento.ordenarEvento(request.getParameter("idOrdenarEventos"),request.getParameter("idSentidoEventos"),idActividad));
                        request.getRequestDispatcher("listaDeEventos.jsp").forward(request,response);
                        break;
                }
            }else {
                response.sendRedirect("PaginaNoExisteServlet");
            }
            request.getSession().setAttribute("usuario",dUsuario.usuarioSesion(usuario.getIdUsuario()));
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        String action = request.getParameter("action") == null ? "default" : request.getParameter("action");
        String pag = request.getParameter("p") == null ? "1" : request.getParameter("p");
        int pagina = Integer.parseInt(pag);
        // Daos:
        DaoUsuario dUsuario=new DaoUsuario();
        DaoLugarEvento dLugarEvento = new DaoLugarEvento();
        DaoEvento dEvento = new DaoEvento();
        DaoNotificacionDelegadoGeneral dN=new DaoNotificacionDelegadoGeneral();
        Usuario usuario = (Usuario) request.getSession().getAttribute("usuario");
        if(usuario==null){
            response.sendRedirect("InicioSesionServlet");
        }else {
            int idActividad = Integer.parseInt(request.getParameter("idActividad"));
            // Parámetros principales:
            int idEvento;
            // Parámetros auxiliares
            Part part = null;
            InputStream input = null;
            InputStream inputAlt = null;
            boolean validarLongitud;
            String rutaImagenPredeterminada = "/css/fibraVShormigon.png";

            switch (action) {

                case "addConfirm":
                    // Parámetros:
                    String addLugar = request.getParameter("addLugar");
                    String addTitulo = request.getParameter("addTitulo");
                    String addHoraStr = request.getParameter("addHora");
                    String addDescripcionEventoActivo = request.getParameter("addDescripcionEventoActivo");
                    String addFraseMotivacional = request.getParameter("addFraseMotivacional");
                    String addEventoOcultoStr = request.getParameter("addEventoOculto");
                    String addFechaStrAux = request.getParameter("addFecha");
                    Boolean addEventoOculto = false;
                    if (!(addEventoOcultoStr == null)) {
                        addEventoOculto = true;
                    }
                    Date addFecha = Date.valueOf(addFechaStrAux);
                    Time addHora = Time.valueOf(addHoraStr + ":00");
                    // Verificar lugar:
                    int addLugarId = dLugarEvento.idLugarPorNombre(addLugar);
                    // En caso no exista el lugar, se crea uno nuevo
                    if (addLugarId == 0) {
                        addLugarId = dLugarEvento.crearLugar(addLugar); // Id del nuevo lugar
                    }
                    // Foto Miniatura
                    part = request.getPart("addfotoMiniatura");

                    // Obtenemos el flujo de bytes
                    if(part != null){
                        input = part.getInputStream();
                    }else{
                        input = getServletContext().getResourceAsStream(rutaImagenPredeterminada);
                    }

                    validarLongitud = input.available()>10;

                    if(!validarLongitud){
                        input = getServletContext().getResourceAsStream(rutaImagenPredeterminada);
                    }
                    try {
                        dEvento.crearEvento(idActividad, addLugarId, addTitulo, addFecha, addHora, addDescripcionEventoActivo, addFraseMotivacional, input, addEventoOculto,getServletContext());
                    } catch (SQLException e) {
                        throw new RuntimeException(e);
                    }
                    input.close();
                    response.sendRedirect("ListaDeEventosServlet?idActividad="+idActividad);
                    break;
                case "updateConfirm":

                    // Parámetros
                    idEvento = Integer.parseInt(request.getParameter("idEvento"));
                    String estadoEvento = request.getParameter("estadoEvento");

                    String updateLugar = request.getParameter("updateLugar");
                    String updateTitulo = request.getParameter("updateTitulo");
                    String updateFechaStr = request.getParameter("updateFecha");
                    String updateHoraStr = request.getParameter("updateHora");
                    String updateDescripcionEventoActivo = request.getParameter("updateDescripcionEventoActivo");
                    String updateFraseMotivacional = request.getParameter("updateFraseMotivacional");
                    String updateResumen = request.getParameter("updateResumen");
                    String updateResultado = request.getParameter("updateResultado");
                    String updateEventoOcultoStr1 = request.getParameter("updateEventoOculto");
                    String updateEventoOcultoStr2 = request.getParameter("updateEventoOcultoAlt");

                    if(estadoEvento.equals("true")){

                        Boolean updateEventoOcultoAlt = false;
                        if(!(updateEventoOcultoStr2 == null)){
                            updateEventoOcultoAlt = true;
                        }
                        dEvento.editarEvento(idEvento,updateTitulo,updateResumen,updateResultado,updateEventoOcultoAlt);
                    }else {

                        Boolean updateEventoOculto = false;
                        if (!(updateEventoOcultoStr1 == null)) {
                            updateEventoOculto = true;
                        }
                        // Verificar lugar:

                        int updateLugarId = dLugarEvento.idLugarPorNombre(updateLugar);
                        // En caso no exista el lugar, se crea uno nuevo
                        if (updateLugarId == 0) {
                            updateLugarId = dLugarEvento.crearLugar(updateLugar); // Id del nuevo lugar
                        }

                        Date updateFecha = Date.valueOf(updateFechaStr);
                        Time updateHora = Time.valueOf(updateHoraStr + ":00");
                        // Foto Miniatura
                        part = request.getPart("updateFotoMiniatura");

                        // Obtenemos el flujo de bytes
                        if (part != null) {
                            input = part.getInputStream();
                        }

                        validarLongitud = input.available() > 10;

                        try {
                            dEvento.editarEvento(idEvento, updateLugarId, updateTitulo, updateFecha, updateHora, updateDescripcionEventoActivo, updateFraseMotivacional, input, updateEventoOculto, validarLongitud);
                        } catch (SQLException e) {
                            throw new RuntimeException(e);
                        }
                        input.close();
                    }
                    response.sendRedirect("ListaDeEventosServlet?idActividad="+idActividad);
                    break;
                case "finConfirm":
                    String finEventoNombre = request.getParameter("finEventoNombre");
                    String finResumen = request.getParameter("finResumen");
                    String resultado = request.getParameter("resultado");

                    int finEventoId = dEvento.idEventoPorNombre(finEventoNombre);

                    dEvento.finalizarEvento(finEventoId,finResumen,resultado);
                    response.sendRedirect("ListaDeEventosServlet?idActividad="+idActividad);
                    break;
            }
            request.getSession().setAttribute("usuario",dUsuario.usuarioSesion(usuario.getIdUsuario()));
        }
    }
}