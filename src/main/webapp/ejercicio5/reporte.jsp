<%--
  Created by IntelliJ IDEA.
  User: Gerardo
  Date: 27/4/2025
  Time: 22:21
  To change this template use File | Settings | File Templates.
--%>

<%@ page import="com.ejercicio5.model.ServicioDAO" %>
<%@ page import="com.ejercicio5.classes.Cliente" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    List<Cliente> clientesServicios = ServicioDAO.obtenerServiciosConClienteYAutomovil();
    request.setAttribute("clientesServicios", clientesServicios);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Servicios</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100">

<div class="container mx-auto mt-10 p-5">
    <h1 class="text-2xl font-bold mb-5">Servicios con Clientes y Automóviles</h1>

    <!-- Check if there are any clients and services -->
    <c:if test="${not empty clientesServicios}">
        <table class="min-w-full bg-white border border-gray-300 shadow-lg rounded-lg">
            <thead class="bg-gray-200">
            <tr>
                <th class="py-2 px-4 text-left border-b">Servicio ID</th>
                <th class="py-2 px-4 text-left border-b">Tipo Servicio</th>
                <th class="py-2 px-4 text-left border-b">Precio</th>
                <th class="py-2 px-4 text-left border-b">Cliente</th>
                <th class="py-2 px-4 text-left border-b">Automóvil</th>
            </tr>
            </thead>
            <tbody>
            <!-- Loop through clientesServicios and display each -->
            <c:forEach var="cliente" items="${clientesServicios}">
                <tr class="border-b hover:bg-gray-50">
                    <td class="py-2 px-4">${cliente.id}</td>
                    <td class="py-2 px-4">${cliente.servicio.tipo}</td>
                    <td class="py-2 px-4">$${cliente.servicio.precio}</td>
                    <td class="py-2 px-4">${cliente.nombres} ${cliente.apellidos}</td>
                    <td class="py-2 px-4">${cliente.automotor.marca} ${cliente.automotor.modelo} (${cliente.automotor.year})</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </c:if>

    <!-- If no data is available -->
    <c:if test="${empty clientesServicios}">
        <p class="text-center text-gray-600">No hay servicios disponibles.</p>
    </c:if>

</div>
<div class="mt-8 md:mt-10 text-center">
    <a href="index.jsp" class="text-blue-500 hover:text-blue-600 font-medium transition-colors">Volver al Inicio</a>
</div>
</body>
</html>
