param(
  [string]$OutputRoot = (Join-Path $PSScriptRoot '..\output')
)

$ErrorActionPreference = 'Stop'
$wdFormatDocumentDefault = 16
$wdExportFormatPDF = 17

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
  $doc.BuiltInDocumentProperties.Item('Title').Value = 'Enrie John Edem - Infrastructure & Systems Engineer Resume'
  $doc.BuiltInDocumentProperties.Item('Subject').Value = 'Linux infrastructure, Proxmox virtualization, automation, and systems engineering'
  $doc.BuiltInDocumentProperties.Item('Author').Value = 'Enrie John Edem'
  $doc.BuiltInDocumentProperties.Item('Keywords').Value = 'Linux, Proxmox, virtualization, infrastructure, automation, systems engineering, MySQL, Gitea'
  Write-Output 'Saving resume documents...'
  $doc.SaveAs2($docxPath, $wdFormatDocumentDefault)
  $doc.ExportAsFixedFormat($pdfPath, $wdExportFormatPDF)

  Write-Output "DOCX=$docxPath"
  Write-Output "PDF=$pdfPath"
}
finally {
  Write-Output 'Closing Word...'
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
