package ejercicio3;
import ejercicio3.Contacto;

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
// maneja solicitudes post para agregar o buscar contactos
protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    String accion = request.getParameter("accion");
    String mensaje = null;

    try {
        if ("agregar".equals(accion)) {
            agregarContacto(request);
            mensaje = "Contacto agregado con éxito";
            // NO enviamos la lista de contactos aquí
        } else if ("buscar".equals(accion)) {
            buscarContacto(request);
            // NO enviamos la lista completa aquí, solo los resultados
        } else if ("ver".equals(accion)) {
            // Solo cuando sea "ver" enviamos la lista completa
            request.setAttribute("mostrarLista", true);
            request.setAttribute("contactos", contactos);
            mensaje = "Mostrando todos los contactos";
        }

        // Enviamos el mensaje de confirmación si existe
        if (mensaje != null) {
            request.setAttribute("mensaje", mensaje);
        }

    } catch (IllegalArgumentException e) {
        request.setAttribute("error", "Error de validación: " + e.getMessage());
    } catch (Exception e) {
        request.setAttribute("error", "Ocurrió un error inesperado: " + e.getMessage());
    }

    // Guardamos la acción actual para mantenerla seleccionada
    request.setAttribute("accionActual", accion);

    RequestDispatcher dispatcher = request.getRequestDispatcher("Ejercicio3.jsp");
    dispatcher.forward(request, response);
}    // agrega un contacto validando los datos
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

        // valida que el nombre no contenga números y tenga un límite máximo (por ejemplo, 50 caracteres)
        if (!nombre.matches("[a-zA-ZáéíóúÁÉÍÓÚüÜñÑ\\s]+")) {
            throw new IllegalArgumentException("El nombre no debe contener números u otros caracteres especiales.");
        }

        if (nombre.length() > 50) {
            throw new IllegalArgumentException("El nombre no puede exceder los 50 caracteres.");
        }

        // valida que el teléfono sea numérico y tenga exactamente 8 dígitos
        if (!telefono.matches("\\d{8}")) {
            throw new IllegalArgumentException("El número de teléfono debe contener exactamente 8 dígitos.");
        }

        // valida formato de correo electrónico
        if (!correo.matches("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$")) {
            throw new IllegalArgumentException("El formato del correo electrónico no es válido.");
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
