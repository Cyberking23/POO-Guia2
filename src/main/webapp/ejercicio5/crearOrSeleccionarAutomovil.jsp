<%--
  Autor: Gerardo Saz
  Fecha: 27/4/2025
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="com.ejercicio5.model.ClienteDAO" %>
<%@ page import="com.ejercicio5.classes.Cliente" %>
<%
    // Verificar si el parámetro clienteId existe en la solicitud
    String clienteIdParam = request.getParameter("clienteId");
    if (clienteIdParam == null || clienteIdParam.isEmpty()) {
        response.sendRedirect("./");
        return;
    }

    try {
        int clienteId = Integer.parseInt(clienteIdParam);
        Cliente cliente = ClienteDAO.obtenerClientePorId(clienteId);

        if (cliente == null) {
            response.sendRedirect("./");
            return;
        }

        // Check if client has an automovil
        if (cliente.getAutomotor() == null) {
            // Redirect to create auto page if no automovil exists
            response.sendRedirect("crear-auto.jsp?clienteId=" + clienteId);
        } else {
            System.out.println(cliente.getAutomotor().getId());
            // Redirect directly to service selection if automovil exists
            response.sendRedirect("seleccionarServicio.jsp?clienteId=" + clienteId +
                    "&automovilId=" + cliente.getAutomotor().getId());
        }
    } catch (NumberFormatException e) {
        response.sendRedirect("./");
    }
%>