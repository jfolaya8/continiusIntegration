# Continius integration

Según AWS podemos decir que la integración continua es una práctica de desarrollo de software mediante la cual los desarrolladores combinan los cambios en el código en un repositorio central de forma periódica, tras lo cual se ejecutan versiones y pruebas automáticas. La integración continua se refiere en su mayoría a la fase de creación o integración del proceso de publicación de software y conlleva un componente de automatización (p. ej., CI o servicio de versiones) y un componente cultural (p. ej., aprender a integrar con frecuencia). Los objetivos clave de la integración continua consisten en encontrar y arreglar errores con mayor rapidez, mejorar la calidad del software y reducir el tiempo que se tarda en validar y publicar nuevas actualizaciones de software.

![image](https://user-images.githubusercontent.com/57411464/119910941-ea40bc80-bf1d-11eb-89c2-66633b5fecab.png)
Fuente: AWS

# Taller práctico semana 3
1. Se debe realizar la construcción de dos contenedores los cuales deben estar comunicados entre sí.

## Solución
1. Se debe realizar la instalación de Docker en la máquina con el fin del desarrollo de la actividad.
2. Una vez se tiene instalado Docker, procedemos a crear un archivo llamado Dockerfile el cual nos servirá de base para crear nuestra imagen, dentro de este archivo colocamos los siguientes valores:
    ```dockerfile
    FROM ubuntu:latest
    RUN apt-get update && apt-get -y install bash net-tools iputils-ping
    EXPOSE 80
    EXPOSE 8000
    ```
      | Directiva | Descripción |
    | --- | --- |
    | FROM | Indica la imagen base sobre la que se basa esta imagen |
    | RUN | Ejecuta el comando indicado durante el proceso de creación de imagen |
    | EXPOSE | Indicamos que este contenedor se comunica por el puerto 80/tcp |
3. Mediante consola procedemos a construir nuestra imagen basada en el archivo Dockerfile que se construyo anteriormente, con el siguiente comando:
    ```dockerfile
    docker build -t continius-integration .
    ```
    El parámetro `-t` nos permite etiquetar la imagen con un nombre y una versión si se desea y el `.` indica que la construcción de la imagen se realiza en el directorio actual. Una vez finalizado se obtendrá un resultado como el siguiente:
    ![image](https://user-images.githubusercontent.com/57411464/119913155-cb90f480-bf22-11eb-8fd4-27fc2ac06ce4.png)
4. Una vez tenemos nuestra imagen, podemos visualizarla mediante el siguiente comando `docker image ls`.
5. El siguiente paso es ejecutar nuestra imagen previamente construida, esto mediante el siguiente comando:
    ```dockerfile
    docker run --rm -it  -p 8000:80/tcp continius-integration:latest
    ```
    El parámetro `-rm` nos permite eliminar la instancia una vez se finalice su ejecución, `-p` indicamos el puerto por el que la máquina principal se va a comunicar con la imagen Docker `PMaquinaPrincipal:PImagenDocker` y seguido el nombre de nuestra imagen Docker.
    Una vez ejecutado nos va a dejar en la consola de nuestra imagen Docker para realizar la acción que requerimos.
    ![image](https://user-images.githubusercontent.com/57411464/119915307-d601bd00-bf27-11eb-99b5-86389d447498.png)
6. Hasta este punto ya tendríamos nuestra primera imagen Docker ejecutándose, ahora lo que vamos a realizar es ejecutar en otra consola nuevamente nuestra imagen, pero ejecutándose por el puerto `8001`, ya que el `8000` se encuentra en uso por nuestra otra imagen.
    ```dockerfile
    docker run --rm -it  -p 8001:80/tcp continius-integration:latest
    ```
    ![image](https://user-images.githubusercontent.com/57411464/119915642-8ff92900-bf28-11eb-8a41-3f80d8935c61.png)
7. Ahora vamos a verificar que nuestras imágenes docker se puedan comunicar entre sí, esto realizando un ping, para lo cual antes necesitamos saber cuál es la ip de nuestras imágenes docker ejecutando `ifconfig`.
    ![image](https://user-images.githubusercontent.com/57411464/119916006-4d841c00-bf29-11eb-96f2-79f2a3194e7c.png)
8. Una vez tenemos nuestras ip's, realizamos ping mediante el siguiente comando:
    ```dockerfile
    ping ip
    ```
    ![image](https://user-images.githubusercontent.com/57411464/119916206-b4a1d080-bf29-11eb-8754-a3d397922e0c.png)
    En la imagen podemos observar como el envío y recepción de los paquetes es exitoso, esto es gracias a que al momento de crear nuestra imagen expusimos un puerto por el cual se puede comunicar fuera de la imagen Docker.
    
# Conclusión semana 3
Es interesante ver como mediante imágenes Docker podemos realizar la creación de máquinas virtuales que tiene un muy bajo consumo de recursos, comparándolo contra una máquina virtual de Virtual Box o VM, adicional también es importante mencionar que podemos realizar la construcción de nuestras imágenes instalando lo que se requiera como paquetes, librerías etc, e incluso una aplicación propia que queremos ver en ejecución, considero que el hacer uso de imágenes permite agilizar los procesos de integración y despliegue. Durante esta actividad me ha permitido comprender la importancia que tiene implementar imagenes Docker dentro de la integración continua.



