param(
  [string]$OutputRoot = (Join-Path $PSScriptRoot '..\output')
)

$ErrorActionPreference = 'Stop'
$wdFormatDocumentDefault = 16
$wdExportFormatPDF = 17

function Set-OfficeDocumentProperty {
  param(
    [Parameter(Mandatory)]$Properties,
    [Parameter(Mandatory)][string]$Name,
    [Parameter(Mandatory)][string]$Value
  )

  $property = $null
  try {
    $property = $Properties.GetType().InvokeMember(
      'Item',
      [System.Reflection.BindingFlags]::GetProperty,
      $null,
      $Properties,
      @($Name)
    )
    $property.Value = $Value
  }
  finally {
    if ($property -ne $null) {
      try { [Runtime.InteropServices.Marshal]::ReleaseComObject($property) | Out-Null } catch {}
    }
  }
}

$outputRootResolved = [System.IO.Path]::GetFullPath($OutputRoot)
$docxDir = Join-Path $outputRootResolved 'docx'
$pdfDir = Join-Path $outputRootResolved 'pdf'
New-Item -ItemType Directory -Force -Path $docxDir, $pdfDir | Out-Null

$baseName = 'Enrie_John_Edem_Infrastructure_Systems_Engineer_Resume'
$docxPath = Join-Path $docxDir ($baseName + '.docx')
$pdfPath = Join-Path $pdfDir ($baseName + '.pdf')
$sourcePath = [System.IO.Path]::GetFullPath((Join-Path $PSScriptRoot 'resume_source.html'))
$workingSource = Join-Path $env:TEMP 'enrie-resume-source.html'
$workingSourceLock = Join-Path $env:TEMP '~$rie-resume-source.html'
Remove-Item -LiteralPath $docxPath, $pdfPath -Force -ErrorAction SilentlyContinue
Remove-Item -LiteralPath $workingSource, $workingSourceLock -Force -ErrorAction SilentlyContinue
Copy-Item -LiteralPath $sourcePath -Destination $workingSource -Force

$word = $null
$doc = $null
$properties = $null

try {
  Write-Output 'Starting Word...'
  $word = New-Object -ComObject Word.Application
  $word.Visible = $false
  $word.DisplayAlerts = 0

  Write-Output 'Opening resume source...'
  $doc = $word.Documents.Open($workingSource)
  $doc.PageSetup.PaperSize = 7
  $doc.PageSetup.TopMargin = $word.InchesToPoints(0.45)
  $doc.PageSetup.BottomMargin = $word.InchesToPoints(0.45)
  $doc.PageSetup.LeftMargin = $word.InchesToPoints(0.58)
  $doc.PageSetup.RightMargin = $word.InchesToPoints(0.58)
  Write-Output 'Saving resume documents...'
  $doc.SaveAs2($docxPath, $wdFormatDocumentDefault)
  $properties = $doc.BuiltInDocumentProperties
  Set-OfficeDocumentProperty -Properties $properties -Name 'Title' -Value 'Enrie John Edem Resume | Infrastructure & Platform Engineer'
  Set-OfficeDocumentProperty -Properties $properties -Name 'Subject' -Value 'Linux infrastructure, Proxmox VE virtualization, infrastructure as code, automation, and platform engineering'
  Set-OfficeDocumentProperty -Properties $properties -Name 'Author' -Value 'Enrie John Edem'
  Set-OfficeDocumentProperty -Properties $properties -Name 'Last Author' -Value 'Enrie John Edem'
  Set-OfficeDocumentProperty -Properties $properties -Name 'Keywords' -Value 'Linux, Proxmox VE, LXC, KVM, Docker, virtualization, infrastructure as code, Ansible, Terraform, automation, platform engineering, CI/CD, Gitea, MySQL'
  $doc.Save()
  $doc.ExportAsFixedFormat($pdfPath, $wdExportFormatPDF)

  Write-Output "DOCX=$docxPath"
  Write-Output "PDF=$pdfPath"
}
finally {
  Write-Output 'Closing Word...'
  if ($properties -ne $null) {
    try { [Runtime.InteropServices.Marshal]::ReleaseComObject($properties) | Out-Null } catch {}
  }
  if ($doc -ne $null) {
    try { $doc.Close($false) } catch {}
    try { [Runtime.InteropServices.Marshal]::ReleaseComObject($doc) | Out-Null } catch {}
  }
  if ($word -ne $null) {
    try { $word.Quit() } catch {}
    try { [Runtime.InteropServices.Marshal]::ReleaseComObject($word) | Out-Null } catch {}
  }
  Remove-Item -LiteralPath $workingSource, $workingSourceLock -Force -ErrorAction SilentlyContinue
}

$projectRoot = [System.IO.Path]::GetFullPath((Join-Path $PSScriptRoot '..'))
Copy-Item -LiteralPath $docxPath -Destination (Join-Path $projectRoot ($baseName + '.docx')) -Force
Copy-Item -LiteralPath $pdfPath -Destination (Join-Path $projectRoot ($baseName + '.pdf')) -Force
Copy-Item -LiteralPath $pdfPath -Destination (Join-Path $projectRoot 'Enrie_John_Edem_Resume.pdf') -Force
Write-Output 'Updated the portfolio download copies.'
