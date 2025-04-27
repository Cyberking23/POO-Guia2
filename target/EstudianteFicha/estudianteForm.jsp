<!-- Autor: Victor Guevara
Fecha: Abril 2025 -->
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap">
    <link rel="stylesheet" type="text/css" href="css/form.css">
    <title>Formulario Estudiante</title>
</head>
<body>
<div class="container">
    <!-- Se evitan acentuaciones porque no las tolera-->
    <h2>Ficha del Estudiante</h2>
    <form method="post" action="procesarEstudiante">
        <label for="carnet">Carnet:</label>
        <input type="text" name="carnet" id="carnet" required placeholder="Ejemplo: GC2426">

        <label for="nombres">Nombres:</label>
        <input type="text" name="nombres" id="nombres" required>

        <label for="apellidos">Apellidos:</label>
        <input type="text" name="apellidos" id="apellidos" required>

        <label for="direccion">Direccion:</label>
        <input type="text" name="direccion" id="direccion" required>

        <label for="telefono">Telefono:</label>
        <input type="text" name="telefono" id="telefono" required placeholder="0000-0000">

        <label for="email">Email:</label>
        <input type="text" name="email" id="email" required placeholder="example@udb.edu.sv">

        <label for="fechaNacimiento">Fecha de Nacimiento:</label>
        <input type="text" name="fechaNacimiento" id="fechaNacimiento" required placeholder="DD/MM/YYYY">

        <button type="submit" class="button">Enviar</button>
    </form>
</div>
</body>
</html>