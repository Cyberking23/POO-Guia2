<!-- Autor del ejercicio 4 - Joaquin Fuentes
Fecha: Abril 2025 -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="ejercicio4.model.Vehiculo" %>
<%@ page import="ejercicio4.util.Estadisticas" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Resultados de Ventas</title>
  <style type="text/css">
    body {
      font-family: 'Poppins', Arial, sans-serif;
      background: #f9f9f9;
      margin: 0;
      padding: 20px;
    }

    table {
      width: 100%;
      border-collapse: collapse;
      margin-bottom: 30px;
      background: white;
      border-radius: 10px;
      overflow: hidden;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    }

    th, td {
      padding: 15px 20px;
      text-align: left;
      border-bottom: 1px solid #eee;
    }

    th {
      background: linear-gradient(135deg, #4CAF50, #45a049);
      color: white;
      text-transform: uppercase;
      letter-spacing: 0.05em;
    }

    tr:hover {
      background-color: #f1f1f1;
    }

    .stats {
      margin-top: 40px;
      background: #ffffff;
      padding: 20px;
      border-radius: 10px;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    }

    .stats h2 {
      margin-top: 0;
      color: #333;
      font-size: 24px;
      font-weight: 700;
      border-bottom: 2px solid #4CAF50;
      padding-bottom: 10px;
      margin-bottom: 20px;
    }

    .error {
      color: #d8000c;
      background-color: #ffe6e6;
      padding: 10px;
      border: 1px solid #ff4d4d;
      border-radius: 6px;
      margin-bottom: 20px;
    }
  </style>
</head>
<body>

<h1>Resultados de Ventas de Vehículos</h1>

<%
  // Obtener parámetros del formulario con validación de nulos
  String nombre = request.getParameter("nombre") != null ? request.getParameter("nombre") : "";
  String sexo = request.getParameter("sexo") != null ? request.getParameter("sexo") : "";
  String marca = request.getParameter("marca") != null ? request.getParameter("marca") : "";
  String anioStr = request.getParameter("anio") != null ? request.getParameter("anio") : "";
  String precioStr = request.getParameter("precio") != null ? request.getParameter("precio") : "";

  // Validaciones de campos vacíos
  if (nombre.trim().isEmpty() || sexo.trim().isEmpty() || marca.trim().isEmpty() ||
          anioStr.trim().isEmpty() || precioStr.trim().isEmpty()) {
    request.setAttribute("error", "Todos los campos son obligatorios");
%>
<jsp:forward page="VehiculoForm.jsp"/>
<%
  }

  try {
    // Convertir con validación de nulos
    int anio = !anioStr.isEmpty() ? Integer.parseInt(anioStr) : 0;
    double precio = !precioStr.isEmpty() ? Double.parseDouble(precioStr) : 0.0;

    if (anio < 2000 || anio > 2025) {
      request.setAttribute("error", "El año debe estar entre 2000 y 2025");
%>
<jsp:forward page="VehiculoForm.jsp"/>
<%
  }

  if (precio <= 0) {
    request.setAttribute("error", "El precio debe ser mayor a 0");
%>
<jsp:forward page="VehiculoForm.jsp"/>
<%
  }

  // Crear el nuevo vehículo
  Vehiculo nuevoVehiculo = new Vehiculo(nombre, sexo, marca, anio, precio);

  // Obtener o crear la lista en la sesión con tipo seguro
  HttpSession userSession = request.getSession();
  @SuppressWarnings("unchecked")
  List<Vehiculo> vehiculos = (List<Vehiculo>) userSession.getAttribute("vehiculos");

  if (vehiculos == null) {
    vehiculos = new ArrayList<>();
    userSession.setAttribute("vehiculos", vehiculos);
  }

  // Agregar el nuevo vehículo
  //vehiculos.add(nuevoVehiculo);
%>

<!-- Mostrar tabla de vehículos -->
<h2>Vehículos Registrados</h2>
<table>
  <tr>
    <th>Nombre</th>
    <th>Sexo</th>
    <th>Marca</th>
    <th>Año</th>
    <th>Precio</th>
  </tr>
  <c:forEach items="${sessionScope.vehiculos}" var="vehiculo">
    <tr>
      <td><c:out value="${vehiculo.nombreCliente}"/></td>
      <td><c:out value="${vehiculo.sexoCliente}"/></td>
      <td><c:out value="${vehiculo.marca}"/></td>
      <td><c:out value="${vehiculo.año}"/></td>
      <td><c:out value="${vehiculo.precio}"/></td>
    </tr>
  </c:forEach>
</table>

<!-- Mostrar estadísticas -->
<div class="stats">
  <h2>Estadísticas de Ventas</h2>

  <h3>Por Marca</h3>
  <table>
    <tr>
      <th>Marca</th>
      <th>Cantidad</th>
      <th>Total Vendido</th>
    </tr>
    <tr>
      <td>Nissan</td>
      <td><%= (int)Estadisticas.calcularTotalPorMarca(vehiculos, "Nissan")[0] %></td>
      <td>$<%= String.format("%,.2f", Estadisticas.calcularTotalPorMarca(vehiculos, "Nissan")[1]) %></td>
    </tr>
    <tr>
      <td>Toyota</td>
      <td><%= (int)Estadisticas.calcularTotalPorMarca(vehiculos, "Toyota")[0] %></td>
      <td>$<%= String.format("%,.2f", Estadisticas.calcularTotalPorMarca(vehiculos, "Toyota")[1]) %></td>
    </tr>
    <tr>
      <td>Kia</td>
      <td><%= (int)Estadisticas.calcularTotalPorMarca(vehiculos, "Kia")[0] %></td>
      <td>$<%= String.format("%,.2f", Estadisticas.calcularTotalPorMarca(vehiculos, "Kia")[1]) %></td>
    </tr>
  </table>

  <h3>Por Rango de Años</h3>
  <table>
    <tr>
      <th>Rango</th>
      <th>Cantidad</th>
    </tr>
    <tr>
      <td>2000-2015</td>
      <td><%= Estadisticas.calcularPorRangoAños(vehiculos, 2000, 2015) %></td>
    </tr>
    <tr>
      <td>2016-2025</td>
      <td><%= Estadisticas.calcularPorRangoAños(vehiculos, 2016, 2025) %></td>
    </tr>
  </table>
</div>

<%
} catch (NumberFormatException e) {
  request.setAttribute("error", "Año y precio deben ser números válidos");
%>
<jsp:forward page="VehiculoForm.jsp"/>
<%
  }
%>

<p style="text-align: center; margin-top: 30px;">
  <a href="VehiculoForm.jsp" style="
        display: inline-block;
        padding: 12px 24px;
        background: linear-gradient(135deg, #4CAF50, #45a049);
        color: white;
        text-decoration: none;
        border-radius: 8px;
        font-weight: 600;
        transition: background 0.3s;
    ">
    Regresar al formulario
  </a>
</p>

</body>
</html>