<%@ page contentType="text/html;charset=UTF-8" language="java" import="com.ejercicio2.Persona, java.time.LocalDate" %>
<!DOCTYPE html>
<html>
<head>
  <title>Resultado del Cálculo de Vacaciones</title>
  <link rel="stylesheet" type="text/css" href="css/Resultado2.css">
</head>
<body>

<h2>Resultado de Cálculo de Vacaciones</h2>

<%
  // Obtener los parámetros enviados desde el formulario.
  String nombre = request.getParameter("nombre");
  String salarioStr = request.getParameter("salario");
  String fechaIngresoStr = request.getParameter("fechaIngreso");

  // Validación de que los campos no estén vacíos.
  if (!Persona.validarCampos(nombre, salarioStr, fechaIngresoStr)) {
%>
<p>Todos los campos son obligatorios.</p>
<a href="index.jsp">Volver</a>
<%
} else {
  try {
    // Convertir el salario a double.
    double salario = Double.parseDouble(salarioStr);
    LocalDate fechaIngreso = LocalDate.parse(fechaIngresoStr);

    // Crear el objeto Persona con los datos ingresados.
    Persona persona = new Persona(nombre, salario, fechaIngreso);

    // Validar el nombre, salario y fecha de ingreso
    if (!persona.validarNombre()) {
%>
<p>El nombre ingresado no es válido. Asegúrese de ingresar solo letras y espacios.</p>
<a href="index.jsp">Volver</a>
<%
} else if (!persona.validarSalario()) {
%>
<p>El salario debe ser un número positivo mayor a cero.</p>
<a href="index.jsp">Volver</a>
<%
} else if (!persona.validarFechaIngreso()) {
%>
<p>La fecha de ingreso no puede ser posterior a la fecha actual.</p>
<a href="index.jsp">Volver</a>
<%
} else {
  // Si todas las validaciones son correctas, calcular las vacaciones.
  int diasVacaciones = persona.calcularVacaciones();
%>

<table>
  <tr><th>Campo</th><th>Valor</th></tr>
  <tr><td>Nombre</td><td><%= persona.getNombre() %></td></tr>
  <tr><td>Salario</td><td>$<%= persona.getSalario() %></td></tr>
  <tr><td>Fecha de Ingreso</td><td><%= persona.getFechaIngreso() %></td></tr>
  <tr><td>Días de Vacaciones</td><td><%= diasVacaciones %></td></tr>
</table>
<a href="index.jsp">Volver</a>

<%
  }
} catch (Exception e) {
%>
<p>Error al procesar los datos. Asegúrate de ingresarlos correctamente.</p>
<a href="index.jsp">Volver</a>
<%
    }
  }
%>

</body>
</html>
