# Script para compilar el watchface solamente

Write-Host "Compilando MinMIP_WF..." -ForegroundColor Green

monkeyc -t -g -f monkey.jungle -o bin\MinMIP_WF.iq -e -y "C:\DevKeys\developer_key"

if ($LASTEXITCODE -eq 0) {
    Write-Host "Compilacion exitosa! Archivo: bin\MinMIP_WF.iq" -ForegroundColor Green
} else {
    Write-Host "Error en la compilacion!" -ForegroundColor Red
}
