$ErrorActionPreference = "Stop"

$RepositoryRoot = Split-Path -Parent $PSScriptRoot

$PackageProject = Join-Path `
    $RepositoryRoot `
    "DeveloperWorkspace.Templates\DeveloperWorkspace.Templates.csproj"

$TestRoot = Join-Path $env:TEMP "DeveloperWorkspace.TemplateTest"

Write-Host "Developer Workspace template test"
Write-Host "Repository: $RepositoryRoot"

if (Test-Path $TestRoot) {
    Remove-Item $TestRoot -Recurse -Force
}

New-Item -ItemType Directory -Path $TestRoot | Out-Null

Write-Host ""
Write-Host "Packing template..."

dotnet pack $PackageProject

if ($LASTEXITCODE -ne 0) {
    throw "dotnet pack failed."
}

[xml]$ProjectXml = Get-Content $PackageProject
$PackageVersion = $ProjectXml.Project.PropertyGroup.PackageVersion |
    Where-Object { $_ } |
    Select-Object -First 1

if (-not $PackageVersion) {
    throw "Could not determine PackageVersion."
}

$PackagePath = Join-Path `
    $RepositoryRoot `
    "DeveloperWorkspace.Templates\bin\Release\DeveloperWorkspace.Templates.$PackageVersion.nupkg"

if (-not (Test-Path $PackagePath)) {
    throw "Expected package was not created: $PackagePath"
}

Write-Host ""
Write-Host "Package created successfully:"
Write-Host $PackagePath

Write-Host ""
Write-Host "Inspecting package contents..."

$PackageEntries = @(tar -tf $PackagePath)

if ($LASTEXITCODE -ne 0) {
    throw "Could not inspect package contents."
}

$RequiredEntries = @(
    "README.md",
    "content/Developer.Workspace/.template.config/template.json",
    "content/Developer.Workspace/Developer.Workspace.csproj",
    "content/Developer.Workspace/AI Prompts/Analysis/example-analysis.md",
    "content/Developer.Workspace/AI Prompts/Chores/example-chore.md",
    "content/Developer.Workspace/AI Prompts/Features/example-feature.md",
    "content/Developer.Workspace/AI Prompts/Fixes/example-fix.md",
    "content/Developer.Workspace/Architecture/Decisions/example-decision.md",
    "content/Developer.Workspace/Checkpoints/example-checkpoint.md",
    "content/Developer.Workspace/Ideas/example-idea.md",
    "content/Developer.Workspace/Investigations/example-investigation.md",
    "content/Developer.Workspace/Notes/example-note.md",
    "content/Developer.Workspace/Plans/example-plan.md"
)

foreach ($Entry in $RequiredEntries) {
    if ($PackageEntries -notcontains $Entry) {
        throw "Required package entry is missing: $Entry"
    }
}

$ForbiddenEntries = $PackageEntries | Where-Object {
    $_ -match '(^|/)(bin|obj)/'
}

if ($ForbiddenEntries) {
    throw "Package contains bin/obj files: $($ForbiddenEntries -join ', ')"
}

Write-Host "Package contents are valid."


Write-Host ""
Write-Host "Validating packaged README..."

$RepositoryReadme = Join-Path $RepositoryRoot "README.md"
$ExtractPath = Join-Path $TestRoot "PackageContents"

if (Test-Path $ExtractPath) {
    Remove-Item $ExtractPath -Recurse -Force
}

New-Item -ItemType Directory -Path $ExtractPath | Out-Null

Push-Location $ExtractPath

try {
    tar -xf $PackagePath "README.md"

    if ($LASTEXITCODE -ne 0) {
        throw "Could not extract README.md from package."
    }
}
finally {
    Pop-Location
}

$ExtractedReadme = Join-Path $ExtractPath "README.md"

if (-not (Test-Path $ExtractedReadme)) {
    throw "Extracted package README.md was not found."
}

$RepositoryReadmeHash = (Get-FileHash $RepositoryReadme -Algorithm SHA256).Hash
$PackageReadmeHash = (Get-FileHash $ExtractedReadme -Algorithm SHA256).Hash

if ($RepositoryReadmeHash -ne $PackageReadmeHash) {
    throw "Packaged README.md does not exactly match repository README.md."
}

Write-Host "Packaged README exactly matches repository README."


Write-Host ""
Write-Host "Installing package..."

# Remove an existing installation if present.
dotnet new uninstall DeveloperWorkspace.Templates 2>$null | Out-Null

dotnet new install $PackagePath

if ($LASTEXITCODE -ne 0) {
    throw "Template package installation failed."
}

Write-Host "Template package installed."

$WorkspaceName = "TemplateTest.Workspace"
$WorkspacePath = Join-Path $TestRoot $WorkspaceName

Write-Host ""
Write-Host "Generating workspace..."

dotnet new developer-workspace `
    -n $WorkspaceName `
    -o $WorkspacePath

if ($LASTEXITCODE -ne 0) {
    throw "Workspace generation failed."
}

$GeneratedProject = Join-Path `
    $WorkspacePath `
    "$WorkspaceName.csproj"

if (-not (Test-Path $GeneratedProject)) {
    throw "Generated project was not found: $GeneratedProject"
}

Write-Host "Workspace generated successfully:"
Write-Host $GeneratedProject

Write-Host ""
Write-Host "Validating generated project..."

$GeneratedProjectContent = Get-Content $GeneratedProject -Raw

if ($GeneratedProjectContent -match '\.template\.config') {
    throw "Generated project contains a .template.config reference."
}

$GeneratedTemplateConfig = Join-Path `
    $WorkspacePath `
    ".template.config"

if (Test-Path $GeneratedTemplateConfig) {
    throw "Generated workspace contains .template.config."
}

$ExpectedDirectories = @(
    "AI Prompts",
    "Architecture",
    "Checkpoints",
    "Ideas",
    "Investigations",
    "Notes",
    "Plans"
)

foreach ($Directory in $ExpectedDirectories) {
    $Path = Join-Path $WorkspacePath $Directory

    if (-not (Test-Path $Path -PathType Container)) {
        throw "Expected workspace directory is missing: $Directory"
    }
}

Write-Host "Generated project structure is valid."

Write-Host ""
Write-Host "Building generated workspace..."

dotnet build $GeneratedProject

if ($LASTEXITCODE -ne 0) {
    throw "Generated workspace build failed."
}

Write-Host "Generated workspace builds successfully."

Write-Host ""
Write-Host "Cleaning temporary test workspace..."

if (Test-Path $TestRoot) {
    Remove-Item $TestRoot -Recurse -Force
}

Write-Host ""
Write-Host "========================================"
Write-Host "Developer Workspace template test PASSED"
Write-Host "========================================"











