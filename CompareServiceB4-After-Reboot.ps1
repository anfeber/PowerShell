<#
Utilizando PowerShell, comparar el estado de los servicios de dos momentos distintos antes de reiniciar un Servidor y despues del Re-Inicio:
#>

# 1- Export - Esta linea, realiza una lista de los servicios que están en modo "Running" y exporta la salida a un fichero txt
(Get-Service | where{$_.Status -eq "Running"} | Select-Object name).name |out-file C:\Temp\Estado-ServiciosB4.txt

# Re-Inicio de Servidores

# 2- Export - Esta linea, realiza una lista de los servicios que están en modo "Running" y exporta la salida a un fichero txt
(Get-Service | where{$_.Status -eq "Running"} | Select-Object name).name | out-file C:\Temp\Estado-ServiciosAfter.txt

# 3- Comparar - Esta linea compara el contenido del fichero Estado-ServiciosB4.xml con la lista de los servicios que están en modo "Running" After.
$SvcDif = (Compare-Object -ReferenceObject (Get-Content C:\Temp\Estado-ServiciosB4.txt) -DifferenceObject (Get-Content C:\Temp\Estado-ServiciosAfter.txt))

#StartService
foreach($Service in $SvcDif.InputObject){
  Get-Service -name $Service | Start-Service
}
