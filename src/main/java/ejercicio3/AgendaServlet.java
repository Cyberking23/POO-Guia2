package ejercicio3;

import ejercicio3.Contacto;

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
        String accion = request.getParameter("accion");
        String mensaje = null;
        String destino = "Ejercicio3.jsp"; // Valor por defecto

        try {
            if ("agregar".equals(accion)) {
                agregarContacto(request);
                mensaje = "Contacto agregado con éxito";
            } else if ("buscar".equals(accion)) {
                buscarContacto(request);
                destino = "ResultadosBusqueda.jsp"; // Mostrar resultados en otra página
            } else if ("ver".equals(accion)) {
                request.setAttribute("mostrarLista", true);
                request.setAttribute("contactos", contactos);
                destino = "ListaContactos.jsp"; // Mostrar lista en otra página
            }

            if (mensaje != null) {
                request.setAttribute("mensaje", mensaje);
            }

        } catch (IllegalArgumentException e) {
            request.setAttribute("error", "Error de validación: " + e.getMessage());
        } catch (Exception e) {
            request.setAttribute("error", "Ocurrió un error inesperado: " + e.getMessage());
        }

        request.setAttribute("accionActual", accion);
        RequestDispatcher dispatcher = request.getRequestDispatcher(destino);
        dispatcher.forward(request, response);
    }

    private void agregarContacto(HttpServletRequest request) {
        String nombre = request.getParameter("nombre");
        String telefono = request.getParameter("telefono");
        String correo = request.getParameter("correo");

        if (nombre == null || nombre.trim().isEmpty() ||
                telefono == null || telefono.trim().isEmpty() ||
                correo == null || correo.trim().isEmpty()) {
            throw new IllegalArgumentException("Todos los campos deben estar completos.");
        }

        if (!nombre.matches("[a-zA-ZáéíóúÁÉÍÓÚüÜñÑ\\s]+")) {
            throw new IllegalArgumentException("El nombre no debe contener números u otros caracteres especiales.");
        }

        if (nombre.length() > 50) {
            throw new IllegalArgumentException("El nombre no puede exceder los 50 caracteres.");
        }

        if (!telefono.matches("\\d{4}-\\d{4}")) {
            throw new IllegalArgumentException("El número de teléfono debe estar en el formato 0000-0000 (4 dígitos, guion, 4 dígitos).");
        }

        if (!correo.matches("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$")) {
            throw new IllegalArgumentException("El formato del correo electrónico no es válido.");
        }

        contactos.add(new Contacto(nombre.trim(), telefono.trim(), correo.trim()));
    }

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
