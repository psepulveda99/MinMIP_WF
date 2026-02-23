# Script para compilar el watchface solamente (.iq para instalar en reloj)

Write-Host "Compilando paquete .iq (instalable en reloj)..." -ForegroundColor Green

monkeyc -g -d fenix7spro -f monkey.jungle -o bin\MinMIP_WF.iq -e -y "C:\DevKeys\developer_key"

if ($LASTEXITCODE -eq 0) {
    Write-Host "Compilacion exitosa! Archivo: bin\MinMIP_WF.iq" -ForegroundColor Green
} else {
    Write-Host "Error en la compilacion!" -ForegroundColor Red
}