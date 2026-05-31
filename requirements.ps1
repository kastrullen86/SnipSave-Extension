# requirements.ps1
# Dynamically queries GitHub API for the latest versioned Ahk2Exe zip release

$compilerDir = ".\compiler"
if (-not (Test-Path -Path $compilerDir)) {
    New-Item -ItemType Directory -Force -Path $compilerDir | Out-Null
}

$zipPath = Join-Path $compilerDir "Ahk2Exe.zip"
$repo = "AutoHotkey/Ahk2Exe"
$apiUrl = "https://api.github.com/repos/$repo/releases/latest"

Write-Host "===================================================" -ForegroundColor Cyan
Write-Host " Installing SnipSave Native Compilation Dependencies" -ForegroundColor Cyan
Write-Host "===================================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "[1/3] Querying GitHub API to resolve latest release asset..." -ForegroundColor Yellow

try {
    # Ensure modern TLS negotiation
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    
    # Query repository assets
    $headers = @{ "User-Agent" = "PowerShell-HCI-Workflow" }
    $releaseJson = Invoke-RestMethod -Uri $apiUrl -Headers $headers -UseBasicParsing
    
    # Filter assets matching the versioned compiler zip format
    $targetAsset = $releaseJson.assets | Where-Object { $_.name -like "Ahk2Exe*.zip" } | Select-Object -First 1
    
    if (-not $targetAsset) {
        throw "Could not locate a matching 'Ahk2Exe*.zip' archive in the latest release payload."
    }

    $downloadUrl = $targetAsset.browser_download_url
    Write-Host "Resolved latest asset: $($targetAsset.name)" -ForegroundColor Green
    Write-Host "Downloading from: $downloadUrl" -ForegroundColor Yellow

    # Download resolved binary stream
    Invoke-WebRequest -Uri $downloadUrl -OutFile $zipPath -Headers $headers -UseBasicParsing
    Write-Host "[SUCCESS] Archive downloaded cleanly." -ForegroundColor Green
}
catch {
    Write-Error "Failed to resolve or download compiler asset: $_"
    Exit
}

Write-Host "[2/3] Extracting compiler binaries..." -ForegroundColor Yellow
try {
    # Unpack compiler package
    Expand-Archive -Path $zipPath -DestinationPath $compilerDir -Force
    Remove-Item -Path $zipPath -Force
    Write-Host "[SUCCESS] Extraction complete. Compiler located at: $compilerDir\Ahk2Exe.exe" -ForegroundColor Green
}
catch {
    Write-Error "Failed to extract archive: $_"
    Exit
}

Write-Host "[3/3] Validating local workspace interpreter..." -ForegroundColor Yellow
$ahkInterpreter = "C:\Program Files\AutoHotkey\v2\AutoHotkey64.exe"
if (Test-Path -Path $ahkInterpreter) {
    Write-Host "[SUCCESS] AutoHotkey v2 Interpreter found: $ahkInterpreter" -ForegroundColor Green
} else {
    Write-Warning "Could not detect AutoHotkey v2 at standard path: $ahkInterpreter"
    Write-Warning "Ensure AutoHotkey v2 is installed on this workstation."
}

Write-Host ""
Write-Host "All workspace dependencies resolved." -ForegroundColor Green
Write-Host "You can now proceed with development or compilation tasks." -ForegroundColor Green