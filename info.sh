Bash
#!/bin/bash

# Información general del sistema
echo "**Información general del sistema:**"
echo "Distribucion: $(lsb_release -d)"
echo "Version del kernel: $(uname -r)"
echo "Nombre de la máquina: $(hostname)"
echo "Fecha y hora: $(date)"
echo "Tiempo de actividad: $(uptime | awk '{print $3}')"

# Información de la CPU
echo "**Información de la CPU:**"
echo "Fabricante: $(cat /proc/cpuinfo | grep "vendor_id" | awk '{print $3}')"
echo "Modelo: $(cat /proc/cpuinfo | grep "model name" | awk '{print $4}')"
echo "Numero de nucleos: $(cat /proc/cpuinfo | grep "cpu cores" | awk '{print $4}')"
echo "Frecuencia de reloj: $(cat /proc/cpuinfo | grep "cpu MHz" | awk '{print $4}') MHz"
echo "Cache: $(cat /proc/cpuinfo | grep "cache size" | awk '{print $4}') KB"
echo "Arquitectura: $(uname -m)"

# Información de la memoria
echo "**Información de la memoria:**"
echo "Tipo: $(dmidecode -t 17 | grep "Memory Type" | awk '{print $3}')"
echo "Cantidad total: $(free -m | awk '{print $2}') MB"
echo "Memoria libre: $(free -m | awk '{print $4}') MB"
echo "Memoria usada: $(free -m | awk '{print $3}') MB"

# Información de almacenamiento
echo "**Información de almacenamiento:**"
for disco in $(lsblk -d | awk '{print $1}'); do
  echo "  Disco: $disco"
  echo "    Sistema de archivos: $(df -h $disco | awk '{print $1}')"
  echo "    Espacio disponible: $(df -h $disco | awk '{print $4}')"
done

# Información de la red
echo "**Información de la red:**"
for interfaz in $(ip a | grep -v "lo" | awk '{print $2}'); do
  echo "  Interfaz: $interfaz"
  echo "    Direccion IP: $(ip a show $interfaz | grep "inet" | awk '{print $2}')"
  echo "    Mascara de red: $(ip a show $interfaz | grep "inet" | awk '{print $3}')"
  echo "    Puerta de enlace: $(ip route show default | awk '{print $3}')"
done

# Información de los dispositivos USB
echo "**Información de los dispositivos USB:**"
lsusb | grep -v "Bus 001 Device 001" | awk '{print $6" "$7" "$8}'

echo "**Fin del script**"
