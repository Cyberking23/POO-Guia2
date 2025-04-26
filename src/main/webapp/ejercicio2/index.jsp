<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Vacaciones</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>
<h2>Formulario de Datos Personales</h2>
<form action="resultado.jsp" method="post">
    Nombre y Apellido: <input type="text" name="nombre"><br><br>
    Salario: <input type="number" name="salario" step="0.01"><br><br>
    Fecha de Ingreso: <input type="date" name="fechaIngreso"><br><br>
    <input type="submit" value="Calcular Vacaciones">
</form>
</body>
</html>
