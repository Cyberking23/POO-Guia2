<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- Declaración de la página JSP con tipo de contenido HTML y lenguaje Java -->
<!DOCTYPE html>
<html>
<head>
  <title>Resultado del Calculo de Vacaciones</title>
  <!-- Título de la página que se muestra en la pestaña del navegador -->
  <link rel="stylesheet" type="text/css" href="css/resultado.css">
  <!-- Enlace al archivo CSS externo para dar estilo a la página -->
</head>
<body>

<h2>Resultado de Cálculo de Vacaciones</h2>
<!-- Título de la sección principal que describe lo que se está mostrando -->

<%
  // Se obtienen los parámetros enviados desde el formulario de la página anterior
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
    // Se convierte el salario de String a double
    double salario = Double.parseDouble(salarioStr);
    // Se convierte la fecha de ingreso de String a LocalDate
    java.time.LocalDate fechaIngreso = java.time.LocalDate.parse(fechaIngresoStr);
    // Se obtiene la fecha actual
    java.time.LocalDate fechaActual = java.time.LocalDate.now();
    // Se calcula el período entre la fecha de ingreso y la fecha actual
    java.time.Period periodo = java.time.Period.between(fechaIngreso, fechaActual);
    // Se extrae el número de años de ese período
    int anios = periodo.getYears();

    // Se define la variable para los días de vacaciones
    int diasVacaciones;
    // Se determina la cantidad de días de vacaciones según los años de antigüedad
    if (anios >= 1 && anios < 3) {
      diasVacaciones = 10;  // Entre 1 y 3 años: 10 días de vacaciones
    } else if (anios >= 3 && anios <= 5) {
      diasVacaciones = 15;  // Entre 3 y 5 años: 15 días de vacaciones
    } else if (anios > 5) {
      diasVacaciones = 21;  // Más de 5 años: 21 días de vacaciones
    } else {
      diasVacaciones = 0;  // Menos de 1 año: 0 días de vacaciones
    }
%>
<!-- Si todo es correcto, se muestra la tabla con los resultados -->
<table>
  <tr><th>Campo</th><th>Valor</th></tr>
  <!-- Se muestra el nombre de la persona -->
  <tr><td>Nombre</td><td><%= nombre %></td></tr>
  <!-- Se muestra el salario -->
  <tr><td>Salario</td><td>$<%= salario %></td></tr>
  <!-- Se muestra la fecha de ingreso -->
  <tr><td>Fecha de Ingreso</td><td><%= fechaIngreso %></td></tr>
  <!-- Se muestra la cantidad de días de vacaciones calculados -->
  <tr><td>Días de Vacaciones</td><td><%= diasVacaciones %></td></tr>
</table>
<!-- Enlace para volver a la página anterior -->
<a href="index.jsp">Volver</a>
<%
  // Si ocurre un error en el procesamiento, se captura y se muestra un mensaje de error
} catch (Exception e) {
%>
<!-- Mensaje de error si hay un problema al procesar los datos -->
<p> error al procesar los datos. Asegúrate de ingresarlos correctamente.</p>
<a href="index.jsp">Volver</a> <!-- Enlace para volver a la página anterior -->
<%
    }
  }
%>

</body>
</html>
