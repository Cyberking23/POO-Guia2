<%--
  Created by IntelliJ IDEA.
  User: Gerardo
  Date: 27/4/2025
  Time: 18:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="com.ejercicio5.classes.Cliente" %>
<%@ page import="com.ejercicio5.model.ClienteDAO" %>
<%@ page import="com.ejercicio5.model.AutomovilDAO" %>
<%@ page import="com.ejercicio5.classes.Automotor" %>
<%@ page import="com.ejercicio5.classes.Servicio" %>
<%@ page import="com.ejercicio5.model.ServicioDAO" %>

<%
String errorMessage = null; // Variable para almacenar el mensaje de error

// Obtener los parámetros de la solicitud
int clienteId = Integer.parseInt(request.getParameter("clienteId"));
int automovilId = Integer.parseInt(request.getParameter("automovilId"));

// Obtener los datos del cliente
Cliente cliente = ClienteDAO.obtenerClientePorId(clienteId);
Automotor automovil = AutomovilDAO.obtenerAutomovilPorId(automovilId);

// Verificar si el cliente es VIP
boolean esVip = cliente.isVip();

// Obtener el tipo de servicio seleccionado
String tipoServicio = request.getParameter("tipoServicio");

// Asignar precio según el tipo de servicio
  double precioBase;

  if ("Motocicleta".equals(tipoServicio)) {
    precioBase = 2.75;
  } else if ("Sedan".equals(tipoServicio)) {
    precioBase = 3.50;
  } else if ("Camioneta".equals(tipoServicio)) {
    precioBase = 4.00;
  } else if ("Microbús".equals(tipoServicio)) {
    precioBase = 5.00;
  } else if ("Autobús".equals(tipoServicio)) {
    precioBase = 7.00;
  } else {
    precioBase = 0.0; // Caso por defecto si no coincide con ninguno
  }

  Servicio servicio = new Servicio(clienteId, tipoServicio, precioBase);
  cliente.setServicio(servicio);

  double precioFinal = cliente.totalPago();


  DecimalFormat df = new DecimalFormat("#.##"); // Formatear precio final
  System.out.println(request.getParameter("accion"));

  if (request.getMethod().equalsIgnoreCase("POST") && request.getParameter("accion") != null) {
    // Guardar el servicio en la base de datos
    System.out.println("PRUEBA POST");
    System.out.println(request.getParameter("accion"));
    servicio.setPrecio(precioFinal);
    int rowsAffected = ServicioDAO.guardarServicio(servicio);
    // Si el servicio se guardó correctamente
    if (rowsAffected > 0) {
      // Redirigir al inicio o a una página de éxito
      response.sendRedirect("finalizar.jsp");
    } else {
      errorMessage = "Hubo un error al guardar el servicio. Por favor, inténtelo nuevamente.";
    }
  }

%>


<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Confirmar Servicio</title>
  <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 font-sans">

<div class="flex items-center justify-center min-h-screen">
  <div class="w-full max-w-lg bg-white p-8 rounded-lg shadow-xl">

    <div class="text-center mb-6">
      <h1 class="text-3xl font-semibold text-gray-800">Confirmar Servicio</h1>
      <p class="text-lg text-gray-600">Cliente ID: <span class="font-bold text-indigo-600">${param.clienteId}</span></p>
      <p class="text-lg text-gray-600">Automóvil ID: <span class="font-bold text-indigo-600">${param.automovilId}</span></p>
    </div>

    <% if (errorMessage != null) { %>
      <div class="mb-4 p-4 bg-red-100 text-red-700 border border-red-400 rounded">
        <p><strong>Error:</strong> <%= errorMessage %></p>
      </div>
    <% } %>

    <!-- Información del cliente -->
    <div class="mb-4">
      <h2 class="text-xl font-semibold text-gray-800">Cliente</h2>
      <p><strong>Nombre:</strong> <%= cliente.getNombres() %> <%= cliente.getApellidos() %></p>
      <p><strong>VIP:</strong> <%= esVip ? "Sí" : "No" %></p>
    </div>

    <!-- Información del automóvil -->
    <div class="mb-4">
      <h2 class="text-xl font-semibold text-gray-800">Automóvil</h2>
      <p><strong>Marca:</strong> <%= automovil.getMarca() %></p>
      <p><strong>Modelo:</strong> <%= automovil.getModelo() %></p>
      <p><strong>Año:</strong> <%= automovil.getYear() %></p>
    </div>

    <!-- Información del servicio -->
    <div class="mb-4">
      <h2 class="text-xl font-semibold text-gray-800">Servicio Seleccionado</h2>
      <p><strong>Tipo de Servicio:</strong> <%= tipoServicio %></p>
      <p><strong>Precio Final:</strong> $<%= df.format(precioFinal) %></p>
    </div>

    <!-- Confirmar pago -->
    <form method="post">
      <input type="hidden" name="clienteId" value="<%= clienteId %>">
      <input type="hidden" name="automovilId" value="<%= automovilId %>">
      <input type="hidden" name="tipoServicio" value="<%= tipoServicio %>">
      <input type="hidden" name="precioFinal" value="<%= precioFinal %>">
      <input type="hidden" name="accion" value="confirmar">

      <button type="submit" class="w-full bg-green-500 text-white py-3 rounded-lg hover:bg-green-600 transition duration-200 mt-6">Confirmar Pago</button>
    </form>

    <!-- Volver -->
    <div class="mt-4 text-center">
      <a href="seleccionarServicio.jsp?clienteId=<%= clienteId %>&automovilId=<%= automovilId %>" class="text-blue-500 hover:text-blue-600">Volver a seleccionar el servicio</a>
    </div>

  </div>
</div>

</body>
</html>
