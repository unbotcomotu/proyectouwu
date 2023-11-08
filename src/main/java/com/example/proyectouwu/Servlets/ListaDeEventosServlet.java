package com.example.proyectouwu.Servlets;

import com.example.proyectouwu.Beans.Evento;
import com.example.proyectouwu.Daos.DaoActividad;
import com.example.proyectouwu.Daos.DaoEvento;
import com.example.proyectouwu.Daos.DaoLugarEvento;
import com.example.proyectouwu.Daos.DaoUsuario;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.Time;
import java.util.ArrayList;
import java.util.HashSet;

@WebServlet(name = "ListaDeEventosServlet", value = "/ListaDeEventosServlet")
public class ListaDeEventosServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        DaoUsuario dUsuario=new DaoUsuario();
        DaoEvento dEvento=new DaoEvento();
        DaoActividad dActividad=new DaoActividad();
        int idUsuario=Integer.parseInt(request.getParameter("idUsuario"));
        int idActividad=Integer.parseInt(request.getParameter("idActividad"));
        String rolUsuario=dUsuario.rolUsuarioPorId(idUsuario);
        request.setAttribute("idUsuario",idUsuario);
        request.setAttribute("idActividad",idActividad);
        request.setAttribute("rolUsuario",rolUsuario);
        request.setAttribute("nombreCompletoUsuario",dUsuario.nombreCompletoUsuarioPorId(idUsuario));
        request.setAttribute("vistaActual","listaDeActividades");
        request.setAttribute("correosDelegadosGenerales",dUsuario.listarCorreosDelegadosGenerales());
        request.setAttribute("listaEventos",dEvento.listarEventos(idActividad));
        request.setAttribute("nombreActividad",dActividad.nombreActividadPorID(idActividad));
        request.setAttribute("delegadoDeEstaActividadID",dActividad.idDelegadoDeActividadPorActividad(idActividad));
        request.setAttribute("listaLugares",new DaoLugarEvento().listarLugares());
        request.setAttribute("cantidadEventosFinalizados",dActividad.cantidadEventosFinalizadosPorActividad(idActividad));
        request.setAttribute("cantidadEventosOcultos",dActividad.cantidadEventosOcultosPorActividad(idActividad));
        request.setAttribute("cantidadEventosApoyando",dActividad.cantidadEventosApoyandoPorActividad(idActividad,idUsuario));
        request.setAttribute("listaLugaresCantidad",dActividad.lugaresConMayorCantidadDeEventos_cantidad_idLugarEvento(idActividad));
        request.setAttribute("cantidadEventosHoy",dActividad.cantidadEventosEnNdiasPorActividad(idActividad,0));
        request.setAttribute("cantidadEventosManana",dActividad.cantidadEventosEnNdiasPorActividad(idActividad,1));
        request.setAttribute("cantidadEventos2DiasMas", dActividad.cantidadEventosEn2DiasAMasPorActividad(idActividad));
        String action = request.getParameter("action") == null ? "default" : request.getParameter("action");
        switch (action){
            case "default":
                String fechaNoNumerica=request.getParameter("fechaNoNumerica");
                if(fechaNoNumerica!=null){
                    request.setAttribute("fechaNoNumerica",fechaNoNumerica);
                }
                String horaInvalida= request.getParameter("horaInvalida");
                if(horaInvalida!=null){
                    request.setAttribute("horaInvalida",horaInvalida);
                }
                String idEventoElegidoAux=request.getParameter("idEventoElegido");
                if(idEventoElegidoAux!=null){
                    request.setAttribute("idEventoElegidoAux",Integer.parseInt(idEventoElegidoAux));
                }
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
                if(!rolUsuario.equals("Delegado General")){
                    if(request.getParameter("eventoApoyando") != null){
                        parametrosEstado.add("Apoyando");
                        request.setAttribute("eventoApoyando",1);
                    }
                }
                if(dActividad.idDelegadoDeActividadPorActividad(idActividad) == idUsuario || rolUsuario.equals("Delegado General")){
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
                request.setAttribute("listaEventos",dEvento.filtrarEventos(parametrosEstado,parametrosLugar,parametrosFecha,request.getParameter("horaInicio"),request.getParameter("horaFin"),idActividad,idUsuario));
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
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        String action = request.getParameter("action") == null ? "default" : request.getParameter("action");

        // Daos:
        DaoLugarEvento dLugarEvento = new DaoLugarEvento();
        DaoEvento dEvento = new DaoEvento();

        // Parámetros principales:
        int addActividadID;
        int idEvento;

        switch (action) {
            case "buscarEvento":
                DaoUsuario dUsuario = new DaoUsuario();
                DaoActividad dActividad=new DaoActividad();
                String textoBuscar = request.getParameter("nombreEvento");
                int idUsuario=Integer.parseInt(request.getParameter("idUsuario"));
                int idActividad = Integer.parseInt(request.getParameter("idActividad"));
                String rolUsuario=dUsuario.rolUsuarioPorId(idUsuario);
                request.setAttribute("idUsuario",idUsuario);
                request.setAttribute("idActividad",idActividad);
                request.setAttribute("rolUsuario",rolUsuario);
                request.setAttribute("nombreCompletoUsuario",dUsuario.nombreCompletoUsuarioPorId(idUsuario));
                request.setAttribute("vistaActual","listaDeActividades");
                request.setAttribute("correosDelegadosGenerales",dUsuario.listarCorreosDelegadosGenerales());
                request.setAttribute("listaEventos",dEvento.listarEventos(idActividad));
                request.setAttribute("nombreActividad",dActividad.nombreActividadPorID(idActividad));
                request.setAttribute("delegadoDeEstaActividadID",dActividad.idDelegadoDeActividadPorActividad(idActividad));
                request.setAttribute("listaLugares",new DaoLugarEvento().listarLugares());
                request.setAttribute("cantidadEventosFinalizados",dActividad.cantidadEventosFinalizadosPorActividad(idActividad));
                request.setAttribute("cantidadEventosOcultos",dActividad.cantidadEventosOcultosPorActividad(idActividad));
                request.setAttribute("cantidadEventosApoyando",dActividad.cantidadEventosApoyandoPorActividad(idActividad,idUsuario));
                request.setAttribute("listaLugaresCantidad",dActividad.lugaresConMayorCantidadDeEventos_cantidad_idLugarEvento(idActividad));
                request.setAttribute("cantidadEventosHoy",dActividad.cantidadEventosEnNdiasPorActividad(idActividad,0));
                request.setAttribute("cantidadEventosManana",dActividad.cantidadEventosEnNdiasPorActividad(idActividad,1));
                request.setAttribute("cantidadEventos2DiasMas", dActividad.cantidadEventosEn2DiasAMasPorActividad(idActividad));
                request.setAttribute("listaEventos",dEvento.buscarEventoPorNombre(textoBuscar,idActividad));
                if(!textoBuscar.isEmpty()){
                    request.setAttribute("busqueda",textoBuscar);
                }
                request.getRequestDispatcher("listaDeEventos.jsp").forward(request,response);
                break;
            case "addConfirm":
                // Parámetros:
                idUsuario = Integer.parseInt(request.getParameter("idUsuario"));
                addActividadID = Integer.parseInt(request.getParameter("addActividadID"));
                String addLugar = request.getParameter("addLugar");
                String addTitulo = request.getParameter("addTitulo");
                String addHoraStr = request.getParameter("addHora");
                String addDescripcionEventoActivo = request.getParameter("addDescripcionEventoActivo");
                String addFraseMotivacional = request.getParameter("addFraseMotivacional");
                String addEventoOcultoStr = request.getParameter("addEventoOculto");
                String addFechaStrAux = request.getParameter("addFecha");
                try{
                    Integer addFechaStr=Integer.parseInt(addFechaStrAux);
                    // Conversión al tipo de variables de la tabla:
                    Boolean addEventoOculto = false;
                    if(!(addEventoOcultoStr == null)){
                        addEventoOculto = true;
                    }
                    String addHoraAux[]=addHoraStr.split(":");
                    try{
                        if(addHoraAux.length!=2){
                            Integer horaAux = Integer.parseInt(addHoraAux[0]);
                            System.out.println(addHoraStr);
                            Integer minutoAux = Integer.parseInt(addHoraAux[1]);
                            System.out.println(addHoraStr);
                            if (horaAux >= 0 && horaAux < 24 && minutoAux >= 0 && minutoAux < 60) {
                                Date addFecha = Date.valueOf("2023-10-" + addFechaStrAux);
                                Time addHora = Time.valueOf(addHoraStr + ":00");

                                // Verificar lugar:
                                int addLugarId = dLugarEvento.idLugarPorNombre(addLugar);
                                // En caso no exista el lugar, se crea uno nuevo
                                if (addLugarId == 0) {
                                    addLugarId = dLugarEvento.crearLugar(addLugar); // Id del nuevo lugar
                                }

                                // Crear evento:
                                dEvento.crearEvento(addActividadID, addLugarId, addTitulo, addFecha, addHora, addDescripcionEventoActivo, addFraseMotivacional, "uwu", addEventoOculto);
                                response.sendRedirect(request.getContextPath() + "/ListaDeEventosServlet?idUsuario=" + idUsuario + "&idActividad=" + addActividadID);
                            } else {
                                response.sendRedirect(request.getContextPath() + "/ListaDeEventosServlet?idUsuario=" + idUsuario + "&idActividad=" + addActividadID + "&horaInvalida=1");
                            }
                        }else{
                            response.sendRedirect(request.getContextPath() + "/ListaDeEventosServlet?idUsuario=" + idUsuario + "&idActividad=" + addActividadID + "&horaInvalida=1");
                        }

                    }catch (NumberFormatException i) {
                        response.sendRedirect(request.getContextPath() + "/ListaDeEventosServlet?idUsuario=" + idUsuario + "&idActividad=" + addActividadID + "&horaInvalida=1");
                    }

                }catch (NumberFormatException e){
                    response.sendRedirect(request.getContextPath()+"/ListaDeEventosServlet?idUsuario="+idUsuario+"&idActividad="+addActividadID+"&fechaNoNumerica=1");
                }
                break;
            case "updateConfirm":

                // Parámetros
                idEvento = Integer.parseInt(request.getParameter("idEvento"));
                String estadoEvento = request.getParameter("estadoEvento");
                idUsuario = Integer.parseInt(request.getParameter("idUsuario"));
                addActividadID = Integer.parseInt(request.getParameter("addActividadID"));

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
                try{
                    Integer updateFechaStrAux=Integer.parseInt(updateFechaStr);
                    String updateHoraStrAux[]=updateHoraStr.split(":");
                    try{
                        if(updateHoraStrAux.length!=2){
                            Integer horaAux=Integer.parseInt(updateHoraStrAux[0]);
                            Integer minutoAux=Integer.parseInt(updateHoraStrAux[1]);
                            if(horaAux>=0 && horaAux<24 && minutoAux>=0 && minutoAux<60) {
                                // Conversión de variables según el estado del evento:
                                if(estadoEvento.equals("true")){

                                    Boolean updateEventoOcultoAlt = false;
                                    if(!(updateEventoOcultoStr2 == null)){
                                        updateEventoOcultoAlt = true;
                                    }

                                    dEvento.editarEvento(idEvento,updateTitulo,updateResumen,updateResultado,updateEventoOcultoAlt);
                                }else{

                                    Boolean updateEventoOculto = false;
                                    if(!(updateEventoOcultoStr1 == null)){
                                        updateEventoOculto = true;
                                    }

                                    // Verificar lugar:
                                    int updateLugarId = dLugarEvento.idLugarPorNombre(updateLugar);
                                    // En caso no exista el lugar, se crea uno nuevo
                                    if(updateLugarId==0){
                                        updateLugarId = dLugarEvento.crearLugar(updateLugar); // Id del nuevo lugar
                                    }

                                    Date updateFecha = Date.valueOf("2023-10-"+updateFechaStr);
                                    Time updateHora = Time.valueOf(updateHoraStr+":00");

                                    dEvento.editarEvento(idEvento,updateLugarId,updateTitulo,updateFecha,updateHora,updateDescripcionEventoActivo,updateFraseMotivacional,"owo",updateEventoOculto);
                                }

                                // Envío a la vista de lista de eventos:
                                response.sendRedirect(request.getContextPath()+"/ListaDeEventosServlet?idUsuario="+idUsuario+"&idActividad="+addActividadID);

                                //mañana sigo uu
                                //response.sendRedirect(request.getContextPath()+ "/ListaDeEventosServlet");
                            }else {
                                response.sendRedirect(request.getContextPath()+"/ListaDeEventosServlet?idUsuario="+idUsuario+"&idActividad="+addActividadID+"&horaInvalida=1"+"&idEventoElegido="+idEvento);
                            }
                        }else{
                            response.sendRedirect(request.getContextPath()+"/ListaDeEventosServlet?idUsuario="+idUsuario+"&idActividad="+addActividadID+"&fechaNoNumerica=1"+"&idEventoElegido="+idEvento);
                        }
                    }catch (NumberFormatException i){
                        response.sendRedirect(request.getContextPath()+"/ListaDeEventosServlet?idUsuario="+idUsuario+"&idActividad="+addActividadID+"&fechaNoNumerica=1"+"&idEventoElegido="+idEvento);
                    }


                }catch (NumberFormatException e){
                    response.sendRedirect(request.getContextPath()+"/ListaDeEventosServlet?idUsuario="+idUsuario+"&idActividad="+addActividadID+"&fechaNoNumerica=1"+"&idEventoElegido="+idEvento);
                }
                break;
            case "finConfirm":
                idUsuario = Integer.parseInt(request.getParameter("idUsuario"));
                addActividadID = Integer.parseInt(request.getParameter("addActividadID"));
                String finEventoNombre = request.getParameter("finEventoNombre");
                String finResumen = request.getParameter("finResumen");
                String resultado = request.getParameter("resultado");

                int finEventoId = dEvento.idEventoPorNombre(finEventoNombre);

                dEvento.finalizarEvento(finEventoId,finResumen,resultado);
                response.sendRedirect(request.getContextPath()+"/ListaDeEventosServlet?idUsuario="+idUsuario+"&idActividad="+addActividadID);
                break;
        }
    }
}