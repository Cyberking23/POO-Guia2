package com.ejercicio3;

import com.ejercicio3.Contacto;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/AgendaServlet")
public class AgendaServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private List<Contacto> contactos;

    @Override
    public void init() {
        contactos = new ArrayList<>();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // obtener la acción enviada desde el formulario
        String accion = request.getParameter("accion");
        String mensaje = null;
        String destino = "Ejercicio3.jsp"; // valor por defecto de la página a redirigir

        try {
            if ("agregar".equals(accion)) {
                // si la acción es agregar, agregar un nuevo contacto
                agregarContacto(request);
                mensaje = "Contacto agregado con éxito";
            } else if ("buscar".equals(accion)) {
                // si la acción es buscar, buscar contactos por nombre
                buscarContacto(request);
                destino = "ResultadosBusqueda.jsp"; // mostrar resultados en otra página
            } else if ("ver".equals(accion)) {
                // si la acción es ver, mostrar la lista completa de contactos
                request.setAttribute("mostrarLista", true);
                request.setAttribute("contactos", contactos);
                destino = "ListaContactos.jsp"; // mostrar lista en otra página
            }

            if (mensaje != null) {
                // si hay mensaje, enviarlo a la vista
                request.setAttribute("mensaje", mensaje);
            }

        } catch (IllegalArgumentException e) {
            // manejar errores de validación
            request.setAttribute("error", "Error de validación: " + e.getMessage());
        } catch (Exception e) {
            // manejar otros errores inesperados
            request.setAttribute("error", "Ocurrió un error inesperado: " + e.getMessage());
        }

        // reenviar la solicitud a la página de destino
        request.setAttribute("accionActual", accion);
        RequestDispatcher dispatcher = request.getRequestDispatcher(destino);
        dispatcher.forward(request, response);
    }

    private void agregarContacto(HttpServletRequest request) {
        // obtener parámetros del formulario
        String nombre = request.getParameter("nombre");
        String telefono = request.getParameter("telefono");
        String correo = request.getParameter("correo");

        // validar que los campos no estén vacíos
        if (nombre == null || nombre.trim().isEmpty() ||
                telefono == null || telefono.trim().isEmpty() ||
                correo == null || correo.trim().isEmpty()) {
            throw new IllegalArgumentException("Todos los campos deben estar completos.");
        }

        // validar que el nombre solo contenga letras y espacios
        if (!nombre.matches("[a-zA-ZáéíóúÁÉÍÓÚüÜñÑ\\s]+")) {
            throw new IllegalArgumentException("El nombre no debe contener números u otros caracteres especiales.");
        }

        // validar longitud máxima del nombre
        if (nombre.length() > 50) {
            throw new IllegalArgumentException("El nombre no puede exceder los 50 caracteres.");
        }

        // validar el formato del teléfono
        if (!telefono.matches("\\d{4}-\\d{4}")) {
            throw new IllegalArgumentException("El número de teléfono debe estar en el formato 0000-0000 (4 dígitos, guion, 4 dígitos).");
        }

        // validar el formato del correo electrónico
        if (!correo.matches("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$")) {
            throw new IllegalArgumentException("El formato del correo electrónico no es válido.");
        }

        // agregar el nuevo contacto a la lista
        contactos.add(new Contacto(nombre.trim(), telefono.trim(), correo.trim()));
    }

    private void buscarContacto(HttpServletRequest request) {
        // obtener el nombre a buscar
        String nombreBuscar = request.getParameter("nombreBuscar");
        List<Contacto> resultados = new ArrayList<>();

        // validar que se haya ingresado un nombre para buscar
        if (nombreBuscar == null || nombreBuscar.trim().isEmpty()) {
            throw new IllegalArgumentException("Debe ingresar un nombre para buscar.");
        }

        // buscar contactos que coincidan con el nombre (ignorando mayúsculas/minúsculas)
        for (Contacto c : contactos) {
            if (c.getNombre().equalsIgnoreCase(nombreBuscar.trim())) {
                resultados.add(c);
            }
        }

        // guardar los resultados encontrados en el request
        request.setAttribute("resultados", resultados);
    }
}
