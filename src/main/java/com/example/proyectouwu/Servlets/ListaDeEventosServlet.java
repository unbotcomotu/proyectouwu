package com.example.proyectouwu.Servlets;

import com.example.proyectouwu.Beans.Evento;
import com.example.proyectouwu.Beans.Usuario;
import com.example.proyectouwu.Daos.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import javax.imageio.ImageIO;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Date;
import java.sql.SQLException;
import java.sql.Time;
import java.util.ArrayList;

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
        int pagina;
        Integer paginaSessionint = (Integer) request.getSession().getAttribute("p");
        String paginaSession;
        if (paginaSessionint != null) {
            paginaSession = paginaSessionint.toString();

        } else {

            paginaSession = "1";
        }

        String paginaPrevia = request.getParameter("p"); // te odio Julio
        if(request.getParameter("p")!=null){
            if (paginaPrevia != null && paginaPrevia.matches("\\d+")) {
                // Si es un número, asigna ese valor a la variable 'pagina'
                pagina = Integer.parseInt(paginaPrevia);
            } else {
                // Si no es un número, asigna el valor predeterminado '1' a 'pagina'
                pagina = 1;
            }

            //pagina = Integer.parseInt(request.getParameter("p"));
        }else if(request.getSession().getAttribute("p") != null){

            if (paginaSession != null && paginaSession.matches("\\d+")) {
                // Si es un número, asigna ese valor a la variable 'pagina'
                pagina = (int) request.getSession().getAttribute("p");
            } else {
                // Si no es un número, asigna el valor predeterminado '1' a 'pagina'
                pagina = 1;
            }

        }else{
            pagina = 1;
        }
        request.getSession().setAttribute("pagActual",pagina);
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
                request.getSession().setAttribute("listaLugaresCantidad",dActividad.lugaresConMayorCantidadDeEventos_cantidad_idLugarEvento(idActividad));
                request.setAttribute("cantidadEventosHoy",dActividad.cantidadEventosEnNdiasPorActividad(idActividad,0));
                request.setAttribute("cantidadEventosManana",dActividad.cantidadEventosEnNdiasPorActividad(idActividad,1));
                request.setAttribute("cantidadEventos2DiasMas", dActividad.cantidadEventosEn2DiasAMasPorActividad(idActividad));
                if(usuario.getRol().equals("Delegado General")){
                    request.setAttribute("listaNotificacionesCampanita",new DaoNotificacion().listarNotificacionesDelegadoGeneral());
                }else if(usuario.getRol().equals("Delegado de Actividad")){
                    request.setAttribute("listaNotificacionesDelegadoDeActividad",new DaoNotificacion().listarNotificacionesDelegadoDeActividad(usuario.getIdUsuario()));
                }
                String action;
                if(request.getParameter("action") != null){
                    action=request.getParameter("action");
                }else if(request.getSession().getAttribute("action") != null){
                    action= (String) request.getSession().getAttribute("action");
                }else{
                    action = "default";
                }
                request.getSession().setAttribute("action",action);

                switch (action){
                    case "superFiltro":
                        //Parámetros de búsqueda
                        String textoBuscar1;
                        if(request.getParameter("nombreEvento")!=null){
                            textoBuscar1=request.getParameter("nombreEvento");
                        }else if(request.getSession().getAttribute("nombreEvento")!=null){
                            textoBuscar1= (String) request.getSession().getAttribute("nombreEvento");
                        }else{
                            textoBuscar1="";
                        }

                        request.getSession().setAttribute("nombreEvento",textoBuscar1);

                        //Parámetros de filtro
                        ArrayList<String> parametrosEstado1 = new ArrayList<>();
                        ArrayList<Integer> parametrosLugar1 = new ArrayList<>();
                        ArrayList<String> parametrosFecha1 = new ArrayList<>();

                        if(request.getParameter("eventoFinalizado") != null){
                            parametrosEstado1.add("Finalizado");
                            request.getSession().setAttribute("eventoFinalizado",1);
                        }else if(request.getSession().getAttribute("eventoFinalizado") != null && request.getParameter("vieneDelJspDeListaDeEventos")==null){
                            parametrosEstado1.add("Finalizado");
                            request.getSession().setAttribute("eventoFinalizado",1);
                        }else{
                            request.getSession().removeAttribute("eventoFinalizado");
                        }

                        if(!usuario.getRol().equals("Delegado General")){
                            if(request.getParameter("eventoApoyando") != null){
                                parametrosEstado1.add("Apoyando");
                                request.getSession().setAttribute("eventoApoyando",1);
                            }else if(request.getSession().getAttribute("eventoApoyando") != null && request.getParameter("vieneDelJspDeListaDeEventos")==null){
                                parametrosEstado1.add("Apoyando");
                                request.getSession().setAttribute("eventoApoyando",1);
                            }else{
                                request.getSession().removeAttribute("eventoApoyando");
                            }
                        }
                        if(dActividad.idDelegadoDeActividadPorActividad(idActividad) == usuario.getIdUsuario() || usuario.getRol().equals("Delegado General")){
                            if(request.getParameter("eventoOculto") != null){
                                parametrosEstado1.add("Oculto");
                                request.getSession().setAttribute("eventoOculto",1);
                            }else if(request.getSession().getAttribute("eventoOculto") != null && request.getParameter("vieneDelJspDeListaDeEventos")==null){
                                parametrosEstado1.add("Oculto");
                                request.getSession().setAttribute("eventoOculto",1);
                            }else{
                                request.getSession().removeAttribute("eventoOculto");
                            }
                        }
                        String cantidad1 = request.getParameter("cantidadLugares");
                        if(cantidad1 != null) {
                            int cantidadLugares1 = Integer.parseInt(request.getParameter("cantidadLugares"));
                            for (int j = 0; j < cantidadLugares1; j++) {
                                String lugarAux1;

                                if(request.getParameter("lugar" + j)!=null){
                                    lugarAux1=request.getParameter("lugar" + j);
                                    Integer lugar1=Integer.parseInt(lugarAux1);
                                    parametrosLugar1.add(lugar1);
                                    request.getSession().setAttribute("lugar" + j,lugar1);
                                }else if(request.getSession().getAttribute("lugar"+j)!=null && request.getParameter("vieneDelJspDeListaDeEventos")==null){
                                    lugarAux1= (String) request.getSession().getAttribute("lugar" + j);
                                    Integer lugar1=Integer.parseInt(lugarAux1);
                                    parametrosLugar1.add(lugar1);
                                    request.getSession().setAttribute("lugar" + j,lugar1);
                                }else{
                                    request.getSession().removeAttribute("lugar"+j);
                                }
                            }
                        }

                        if(request.getParameter("eventosHoy") != null){
                            parametrosFecha1.add("Hoy");
                            request.getSession().setAttribute("eventosHoy",1);
                        }else if(request.getSession().getAttribute("eventosHoy") != null && request.getParameter("vieneDelJspDeListaDeEventos")==null){
                            parametrosFecha1.add("Hoy");
                            request.getSession().setAttribute("eventosHoy",1);
                        }else{
                            request.getSession().removeAttribute("eventosHoy");
                        }

                        if(request.getParameter("eventosManana") != null){
                            parametrosFecha1.add("Manana");
                            request.getSession().setAttribute("eventosManana",1);
                        }else if(request.getSession().getAttribute("eventosManana") != null && request.getParameter("vieneDelJspDeListaDeEventos")==null){
                            parametrosFecha1.add("Manana");
                            request.getSession().setAttribute("eventosManana",1);
                        }else{
                            request.getSession().removeAttribute("eventosManana");
                        }

                        if(request.getParameter("eventosMasDias") != null){
                            parametrosFecha1.add("MasDias");
                            request.getSession().setAttribute("eventosMasDias",1);
                        }else if(request.getSession().getAttribute("eventosMasDias") != null && request.getParameter("vieneDelJspDeListaDeEventos")==null){
                            parametrosFecha1.add("MasDias");
                            request.getSession().setAttribute("eventosMasDias",1);
                        }else{
                            request.getSession().removeAttribute("eventosMasDias");
                        }

                        String horaInicio;
                        if(request.getParameter("horaInicio")!=null){
                            horaInicio=request.getParameter("horaInicio");
                        }else if(request.getSession().getAttribute("horaInicio")!=null){
                            horaInicio= (String) request.getSession().getAttribute("horaInicio");
                        }else{
                            horaInicio="";
                        }

                        String horaFin;
                        if(request.getParameter("horaFin")!=null){
                            horaFin=request.getParameter("horaFin");
                        }else if(request.getSession().getAttribute("horaFin")!=null){
                            horaFin= (String) request.getSession().getAttribute("horaFin");
                        }else{
                            horaFin="";
                        }

                        request.getSession().setAttribute("horaInicio",horaInicio);
                        request.getSession().setAttribute("horaFin",horaFin);

                        //Parámetros de ordenamiento
                        String orden;
                        if(request.getParameter("idOrdenarEventos")!=null){

                            if(request.getParameter("idOrdenarEventos").equals("1") || request.getParameter("idOrdenarEventos").equals("0")){
                                orden=request.getParameter("idOrdenarEventos");

                            }else{
                                orden="0";
                            }

                        }else if(request.getSession().getAttribute("idOrdenarEventos")!=null){
                            orden= (String)request.getSession().getAttribute("idOrdenarEventos");


                        }else{
                            orden="0";
                        }

                        String sentido;
                        if(request.getParameter("idSentidoEventos")!=null){
                            if(request.getParameter("idSentidoEventos").equals("1") || request.getParameter("idSentidoEventos").equals("0")){
                                sentido=request.getParameter("idSentidoEventos");

                            }else{
                                sentido="0";

                            }

                        }else if(request.getSession().getAttribute("idSentidoEventos")!=null){

                            sentido= (String)request.getSession().getAttribute("idSentidoEventos");


                        }else{
                            sentido="0";
                        }
//ayuda, aqui hice cosas
                        request.getSession().setAttribute("idOrdenarEventos",orden);
                        request.getSession().setAttribute("idSentidoEventos",sentido);

                        //Lista de Eventos de búsqueda sin paginación
                        ArrayList<Evento> listaBusqueda1 = dEvento.buscarEventoPorNombre(textoBuscar1,idActividad);

                        //Lista de Eventos de filtros sin paginación
                        ArrayList<Evento> listaFiltro1 = dEvento.filtrarEventos(parametrosEstado1,parametrosLugar1,parametrosFecha1,horaInicio,horaFin,idActividad,usuario.getIdUsuario());

                        //Se intersecan los resultados de ambas listas (aun sin ordenamiento)
                        ArrayList<Evento> listaEventosSinOrdenar1 = dEvento.juntarListas(listaBusqueda1,listaFiltro1);

                        //Lista de Eventos ordenada
                        ArrayList<Evento> listaEventosOrdenada1 = dEvento.ordenarListaEventos(listaEventosSinOrdenar1,orden,sentido,pagina-1,idActividad);

                        request.setAttribute("cantidadEventosTotal", listaEventosSinOrdenar1.size());
                        request.setAttribute("listaEventos",listaEventosOrdenada1);

                        request.getRequestDispatcher("listaDeEventos.jsp").forward(request,response);
                        break;
                    case "default":
                        //Lista de Eventos con paginación
                        request.setAttribute("listaEventos",dEvento.listarEventos(idActividad,pagina-1));
                        request.setAttribute("cantidadEventosTotal", dEvento.listarEventos(idActividad).size());

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
        DaoActividad daoActividad = new DaoActividad();
        DaoLugarEvento dLugarEvento = new DaoLugarEvento();
        DaoEvento dEvento = new DaoEvento();
        DaoNotificacion dN=new DaoNotificacion();
        Usuario usuario = (Usuario) request.getSession().getAttribute("usuario");
        if(usuario==null){
            response.sendRedirect("InicioSesionServlet");
        }else {

            String idActividadStr = request.getParameter("idActividad");
            if (idActividadStr.matches("\\d+") && daoActividad.existeActividad(idActividadStr)){

                int idActividad = Integer.parseInt(request.getParameter("idActividad"));
                // Parámetros principales:
                int idEvento;
                // Parámetros auxiliares
                Part part = null;
                InputStream input = null;
                InputStream inputAlt = null;
                String nombreImagen = "";
                boolean validarLongitud=true;
                Imagen io=new Imagen();
                String rutaImagenPredeterminada = "/css/fibraVShormigon.png";
                switch (action) {

                    case "addConfirm":
                        // Parámetros:
                        boolean validacionCrear=true;
                        String addLugar = request.getParameter("addLugar");
                        String addTitulo = request.getParameter("addTitulo");
                        String addHoraStr = request.getParameter("addHora");
                        String addDescripcionEventoActivo = request.getParameter("addDescripcionEventoActivo");
                        if(addDescripcionEventoActivo.length()>1000){
                            request.getSession().setAttribute("descripcionLarga","1");
                            validacionCrear=false;
                        }
                        String addFraseMotivacional = request.getParameter("addFraseMotivacional");
                        if(addFraseMotivacional.length()>45){
                            request.getSession().setAttribute("fraseLarga","1");
                            validacionCrear=false;
                        }
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
                            nombreImagen=part.getSubmittedFileName();
                            if(!io.isImageFile(nombreImagen)){
                                request.getSession().setAttribute("extensionInvalida","1");
                                validacionCrear=false;
                            }else if(!io.betweenScales(ImageIO.read(part.getInputStream()),1.2,1.8)) {
                                request.getSession().setAttribute("escalaInvalida", "1");
                                validacionCrear = false;
                            }
                        }else{
                            input = getServletContext().getResourceAsStream(rutaImagenPredeterminada);
                        }

                        validarLongitud = input.available()>10;

                        if(!validarLongitud){
                            input = getServletContext().getResourceAsStream(rutaImagenPredeterminada);
                        }
                        if(validacionCrear){
                            try {
                                dEvento.crearEvento(idActividad, addLugarId, addTitulo, addFecha, addHora, addDescripcionEventoActivo, addFraseMotivacional, input, addEventoOculto,getServletContext());
                            } catch (SQLException e) {
                                throw new RuntimeException(e);
                            }
                        }
                        input.close();
                        response.sendRedirect("ListaDeEventosServlet?idActividad="+idActividad);
                        break;
                    case "updateConfirm":
                        boolean validacionEditar=true;
                        // Parámetros

                        String idEventoStr = request.getParameter("idEvento");

                        if (idEventoStr.matches("\\d+") && dEvento.existeEvento(idEventoStr)){
                            idEvento = Integer.parseInt(request.getParameter("idEvento"));
                            String estadoEvento = request.getParameter("estadoEvento");

                            String updateLugar = request.getParameter("updateLugar");
                            String updateTitulo = request.getParameter("updateTitulo");
                            String updateFechaStr = request.getParameter("updateFecha");
                            String updateHoraStr = request.getParameter("updateHora");
                            String updateDescripcionEventoActivo = request.getParameter("updateDescripcionEventoActivo");
                            if(updateDescripcionEventoActivo!=null && updateDescripcionEventoActivo.length()>1000){
                                request.getSession().setAttribute("descripcionLarga","1");
                                validacionEditar=false;
                            }
                            String updateFraseMotivacional = request.getParameter("updateFraseMotivacional");
                            if(updateFraseMotivacional!=null && updateFraseMotivacional.length()>45){
                                request.getSession().setAttribute("fraseLarga","1");
                                validacionEditar=false;
                            }
                            String updateResumen = request.getParameter("updateResumen");
                            if(updateResumen!=null && updateResumen.length()>1000){
                                request.getSession().setAttribute("resumenLargo","1");
                                validacionEditar=false;
                            }
                            String updateResultado = request.getParameter("updateResultado");
                            String updateEventoOcultoStr1 = request.getParameter("updateEventoOculto");
                            String updateEventoOcultoStr2 = request.getParameter("updateEventoOcultoAlt");

                            if(estadoEvento.equals("true")){

                                Boolean updateEventoOcultoAlt = false;
                                if(!(updateEventoOcultoStr2 == null)){
                                    updateEventoOcultoAlt = true;
                                }
                                if(validacionEditar){
                                    dEvento.editarEvento(idEvento,updateTitulo,updateResumen,updateResultado,updateEventoOcultoAlt);
                                }else {
                                    request.getSession().setAttribute("eventoElegido",idEvento);
                                }
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
                                    nombreImagen=part.getSubmittedFileName();
                                    if(input.available()<10){
                                        validarLongitud=false;
                                    }else if(!io.isImageFile(nombreImagen)){
                                        request.getSession().setAttribute("extensionInvalida","1");
                                        validacionEditar=false;
                                    }else if(!io.betweenScales(ImageIO.read(part.getInputStream()),1.2,1.8)) {
                                        request.getSession().setAttribute("escalaInvalida", "1");
                                        validacionEditar = false;
                                    }
                                }
                                if(validacionEditar){
                                    try {
                                        dEvento.editarEvento(idEvento, updateLugarId, updateTitulo, updateFecha, updateHora, updateDescripcionEventoActivo, updateFraseMotivacional, input, updateEventoOculto, validarLongitud);
                                    } catch (SQLException e) {
                                        throw new RuntimeException(e);
                                    }
                                }else {
                                    request.getSession().setAttribute("eventoElegido",idEvento);
                                }
                                input.close();
                            }
                            response.sendRedirect("ListaDeEventosServlet?idActividad="+idActividad);
                        }else{
                            response.sendRedirect("ListaDeEventosServlet?idActividad="+idActividad);
                        }
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

            }else{
                response.sendRedirect("ListaDeActividadesServlet");
            }

            request.getSession().setAttribute("usuario",dUsuario.usuarioSesion(usuario.getIdUsuario()));
        }
    }
}