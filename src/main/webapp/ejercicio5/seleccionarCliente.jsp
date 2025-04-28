<%--
  Autor: Gerardo Saz
  Fecha: 27/4/2025
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.List" %>
<%@ page import="com.ejercicio5.model.ClienteDAO" %>
<%@ page import="com.ejercicio5.classes.Cliente" %>


<%
    List<Cliente> clientes = ClienteDAO.obtenerTodos();
    request.setAttribute("clientes", clientes);
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Seleccionar Cliente</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 min-h-screen flex items-center justify-center font-sans p-4">

<div class="w-full max-w-6xl bg-white rounded-xl shadow-lg p-6 md:p-8">

    <h1 class="text-3xl font-bold text-center text-gray-800 mb-8 md:mb-10">Selecciona un Cliente</h1>

    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4 md:gap-5">
        <c:forEach var="cliente" items="${clientes}">
            <a href="crearOrSeleccionarAutomovil.jsp?clienteId=${cliente.id}"
               class="flex items-center justify-center p-4 md:p-5 bg-blue-500 hover:bg-blue-600 transition-colors text-white rounded-xl shadow-sm hover:shadow-md">
                <div class="flex items-center space-x-2 truncate">
                    <span class="truncate">${cliente.nombres} ${cliente.apellidos}</span>
                    <c:if test="${cliente.vip}">
                        <span class="flex-shrink-0">⭐</span>
                    </c:if>
                </div>
            </a>
        </c:forEach>
    </div>

    <div class="mt-8 md:mt-10 text-center">
        <a href="index.jsp" class="text-blue-500 hover:text-blue-600 font-medium transition-colors">Volver al Inicio</a>
    </div>

</div>

</body>
</html>