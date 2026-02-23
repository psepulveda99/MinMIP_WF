# Script para compilar y ejecutar el watchface en el simulador

Write-Host "Compilando MinMIP_WF..." -ForegroundColor Green

monkeyc -t -g -d fenix7spro -f monkey.jungle -o bin\MinMIP_WF.iq -e -y "C:\DevKeys\developer_key"

if ($LASTEXITCODE -eq 0) {
    Write-Host "Compilacion exitosa! Abriendo simulador..." -ForegroundColor Green
    & "C:\Users\Pablo Sepulveda\AppData\Roaming\Garmin\ConnectIQ\Sdks\connectiq-sdk-win-8.4.1-2026-02-03-e9f77eeaa\bin\simulator.exe"
} else {
    Write-Host "Error en la compilacion!" -ForegroundColor Red
}
