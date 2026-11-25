param([string]$Mappe = "modules/network")

$steg = [ordered]@{
  "fmt" = { terraform fmt -check -recursive }
  "init"     = { terraform init -backend=false -input=false > $null }
  "validate" = { terraform validate }
  "tflint"   = { tflint --init > $null; tflint }
  "checkov"  = { checkov -d . }
  "test"     = { terraform test }
}

Push-Location $Mappe
try {
  foreach ($navn in $steg.Keys) {
    Write-Host "`n== $navn ==" -ForegroundColor Cyan
    & $steg[$navn]
    if ($LASTEXITCODE -ne 0) {
      Write-Host "`nStoppet paa $navn" -ForegroundColor Red
      exit 1
    }
  }
  Write-Host "`nAlle sjekkene er gronne" -ForegroundColor Green
}
finally {
  Pop-Location
}