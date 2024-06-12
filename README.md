# User Management Script

Este es un script de Bash para la gestión de usuarios en un sistema Linux. Permite agregar, eliminar y modificar usuarios, así como mostrar un panel de ayuda con las opciones disponibles.

## Uso

Para ejecutar el script, debes tener permisos de superusuario(root). Aquí hay una guía rápida sobre cómo usar el script.

### Opciones

- **a)** Agregar un usuario.
- **d)** Eliminar un usuario.
- **m)** Modificar un usuario.
- **h)** Mostrar el panel de ayuda.

### Ejecución

1. **Descarga el script:**

   Clona este repositorio o descarga el script directamente.

2. **Dar permisos de ejecución al script:**

   ```bash
   chmod +x user_management.sh
3. **Ejecuta el script:**
   
   ```bash
   sudo ./user_management.sh

## Panel de Ayuda
El panel de ayuda se puede invocar con la opción h). Proporciona detalles sobre cómo usar las diferentes funcionalidades del script.
   
   ```bash
   [+] Welcome to Help Menu, here you can find main options for user management tool:

   [+] Add more users enter a)
  
   [+] Delete users enter d)
  
   [+] Modify user parameters enter m)
   ```

### Agregar Usuario
El script permite agregar usuarios con configuraciones predeterminadas o personalizadas.

1. **Configuraciones predeterminadas:**
   Se crea el usuario con una ruta predeterminada de **/home/username** y shell **/bin/bash**.

2. **Configuraciones personalizadas:**
   Se permite ingresar **UID** y la ruta del **directorio home**.

   ```bash
   Do you want to use default settings for the user? Please enter yes or no:
   Enter username:

## Eliminar Usuario
Permite eliminar un usuario existente del sistema. Asegúrate de usar esta opción con precaución, ya que el usuario será eliminado permanentement

   ```bash
   Enter username:
   ```

## Modificar Usuario
Permite modificar varios parámetros de un usuario existente. Los parámetros que se pueden cambiar son:

- login: Nombre de inicio de sesión del usuario.
- uid: Identificador de usuario.
- gid: Identificador de grupo.
- comment: Comentario asociado al usuario.
- homepath: Ruta del directorio home del usuario.

### Ejemplos de Uso
#### Agregar un usuario con configuraciones predeterminadas

```bash
Do you want to use default settings for the user? Please enter yes or no: yes
Enter username: newuser
```

#### Eliminar un usuario:
```bash
Enter username: olduser
```

#### Modificar el UID de un usuario:
```bash
Enter the user: existinguser

Please enter parameter for change: uid

Enter new uid for the user: 1001
```

### Advertencias
1. Este script debe ser ejecutado con permisos de superusuario.
2. Asegúrate de ingresar correctamente los parámetros para evitar errores.
3. Al eliminar usuarios, se eliminarán permanentemente del sistema junto con sus archivos de configuración en el directorio home.

### Contribución
Las contribuciones son bienvenidas. Por favor, crea un fork de este repositorio, realiza tus cambios y envía un pull request.
