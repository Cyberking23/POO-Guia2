<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
  <title>Resultado del Calculo de Vacaciones</title>
  <link rel="stylesheet" type="text/css" href="../css/ejercicio2/resultado.css.css">
</head>
<body>

<h2>Resultado de Cálculo de Vacaciones</h2>

<%
  String nombre = request.getParameter("nombre");
  String salarioStr = request.getParameter("salario");
  String fechaIngresoStr = request.getParameter("fechaIngreso");

  // Se verifica si alguno de los parámetros es nulo o está vacío
  if (nombre == null || salarioStr == null || fechaIngresoStr == null ||
          nombre.trim().isEmpty() || salarioStr.trim().isEmpty() || fechaIngresoStr.trim().isEmpty()) {
%>
<!-- Si algún campo está vacío o no se ha recibido, se muestra un mensaje de advertencia -->
<p>Todos los campos son obligatorios.</p>
<a href="index.jsp">Volver</a> <!-- Enlace para volver a la página anterior -->
<%
} else {
  // Si los parámetros son válidos, se intenta procesar los datos
  try {
    double salario = Double.parseDouble(salarioStr);
    java.time.LocalDate fechaIngreso = java.time.LocalDate.parse(fechaIngresoStr);
    java.time.LocalDate fechaActual = java.time.LocalDate.now();
    java.time.Period periodo = java.time.Period.between(fechaIngreso, fechaActual);
    int anios = periodo.getYears();

    int diasVacaciones;
    if (anios >= 1 && anios < 3) {
      diasVacaciones = 10;
    } else if (anios >= 3 && anios <= 5) {
      diasVacaciones = 15;
    } else if (anios > 5) {
      diasVacaciones = 21;
    } else {
      diasVacaciones = 0;
    }
%>
<!-- Si todo es correcto, se muestra la tabla con los resultados -->
<table>
  <tr><th>Campo</th><th>Valor</th></tr>
  <tr><td>Nombre</td><td><%= nombre %></td></tr>
  <tr><td>Salario</td><td>$<%= salario %></td></tr>
  <tr><td>Fecha de Ingreso</td><td><%= fechaIngreso %></td></tr>
  <tr><td>Días de Vacaciones</td><td><%= diasVacaciones %></td></tr>
</table>
<a href="index.jsp">Volver</a>
<%
} catch (Exception e) {
%>
<!-- Mensaje de error si hay un problema al procesar los datos -->
<p> error al procesar los datos. Asegúrate de ingresarlos correctamente.</p>
<a href="index.jsp">Volver</a>
<%
    }
  }
%>

</body>
</html>
