# DGA

<h4> Contenedor de servidor apache Tomcat 10.0.23 y Axis2 1.8.2</h4>

<h2>Crear imagen</h2>

En la ruta que contiene el Dockerfile ejecutar:

```
docker build -t <tag imagen> .
docker run -it --name <nombre contenedor> -p <puerto-host>:8080 <IMAGE ID>
```
<h2>Iniciar servidor</h2>

Entrar al contenedor con bash y ejecutar:

```
root@<container-id>:/opt/tomcat/bin# ./startup.sh

```

<h2>WSDL2Java</h2>

Entrar al contenedor con bash:

```
docker exec -it <container id> bash
```
Ir a la carpeta /opt/axis2/bin

```
cd /opt/axis2/bin
```

Y ejecutar:

```
root@<container-id>:/opt/axis2/bin# ./wsdl2java.sh -uri $wsdl -o <ruta-destino>
```
