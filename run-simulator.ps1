# Script para compilar y ejecutar el watchface en el simulador

$SdkBin = "C:\Users\Pablo Sepulveda\AppData\Roaming\Garmin\ConnectIQ\Sdks\connectiq-sdk-win-8.4.1-2026-02-03-e9f77eeaa\bin"
$SimulatorExe = Join-Path $SdkBin "simulator.exe"

Write-Host "Compilando MinMIP_WF para simulador (.prg)..." -ForegroundColor Green

monkeyc -d fenix7spro -f monkey.jungle -o bin\MinMIP_WF.prg -y "C:\DevKeys\developer_key"
if ($LASTEXITCODE -ne 0) {
    Write-Host "Error en la compilacion!" -ForegroundColor Red
    exit $LASTEXITCODE
}

Write-Host "Compilacion exitosa!" -ForegroundColor Green

# Abre simulador solo si no esta corriendo.
if (-not (Get-Process -Name simulator -ErrorAction SilentlyContinue)) {
    Write-Host "Abriendo simulador..." -ForegroundColor Green
    Start-Process -FilePath $SimulatorExe | Out-Null
    Start-Sleep -Seconds 2
}

Write-Host "Cargando app en simulador..." -ForegroundColor Green
& (Join-Path $SdkBin "monkeydo.bat") "bin\MinMIP_WF.prg" "fenix7spro"

if ($LASTEXITCODE -eq 0) {
    Write-Host "App cargada correctamente en el simulador." -ForegroundColor Green
} else {
    Write-Host "No se pudo cargar la app en el simulador." -ForegroundColor Red
}