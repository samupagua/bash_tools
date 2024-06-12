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

## Agregar Usuario
El script permite agregar usuarios con configuraciones predeterminadas o personalizadas.

1. **Configuraciones predeterminadas:**
   Se crea el usuario con una ruta predeterminada de **/home/username** y shell **/bin/bash**.

2. **Configuraciones personalizadas:**
   Se permite ingresar **UID** y la ruta del **directorio home**.

```bash
Do you want to use default settings for the user? Please enter yes or no:
Enter username: 



