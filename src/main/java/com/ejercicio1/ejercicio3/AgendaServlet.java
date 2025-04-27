package com.ejercicio1.ejercicio3;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

// servlet que maneja la agenda de contactos
@WebServlet("/AgendaServlet")
public class AgendaServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private List<Contacto> contactos;

    // inicializa la lista de contactos
    @Override
    public void init() {
        contactos = new ArrayList<>();
    }

    // maneja solicitudes post para agregar o buscar contactos
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String accion = request.getParameter("accion");

        try {
            if ("agregar".equals(accion)) {
                agregarContacto(request);
            } else if ("buscar".equals(accion)) {
                buscarContacto(request);
            }
            request.setAttribute("contactos", contactos);
        } catch (IllegalArgumentException e) {
            request.setAttribute("error", "Error de validación: " + e.getMessage());
        } catch (Exception e) {
            request.setAttribute("error", "Ocurrió un error inesperado: " + e.getMessage());
        }

        RequestDispatcher dispatcher = request.getRequestDispatcher("Ejercicio3.jsp");
        dispatcher.forward(request, response);
    }

    // agrega un contacto validando los datos
    private void agregarContacto(HttpServletRequest request) {
        String nombre = request.getParameter("nombre");
        String telefono = request.getParameter("telefono");
        String correo = request.getParameter("correo");

        // valida campos vacíos
        if (nombre == null || nombre.trim().isEmpty() ||
                telefono == null || telefono.trim().isEmpty() ||
                correo == null || correo.trim().isEmpty()) {
            throw new IllegalArgumentException("Todos los campos deben estar completos.");
        }

        // valida que el teléfono sea numérico
        if (!telefono.matches("\\d+")) {
            throw new IllegalArgumentException("El número de teléfono debe contener solo números.");
        }

        contactos.add(new Contacto(nombre.trim(), telefono.trim(), correo.trim()));
    }

    // busca contactos por nombre
    private void buscarContacto(HttpServletRequest request) {
        String nombreBuscar = request.getParameter("nombreBuscar");
        List<Contacto> resultados = new ArrayList<>();

        if (nombreBuscar == null || nombreBuscar.trim().isEmpty()) {
            throw new IllegalArgumentException("Debe ingresar un nombre para buscar.");
        }

        for (Contacto c : contactos) {
            if (c.getNombre().equalsIgnoreCase(nombreBuscar.trim())) {
                resultados.add(c);
            }
        }

        request.setAttribute("resultados", resultados);
    }
}
