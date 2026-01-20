# Git Log Export Script for Release Notes Generator (PowerShell)
# Usage: .\export-git-log.ps1 [-PreviousVersion "v1.2.6"] [-OutputFile "git-log.txt"]

param(
    [string]$PreviousVersion = "HEAD~50",  # Default: last 50 commits
    [string]$OutputFile = "git-log-for-release-notes.txt"
)

Write-Host "================================================" -ForegroundColor Cyan
Write-Host "Git Log Export for Release Notes Generator" -ForegroundColor Cyan
Write-Host "================================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Previous Version: $PreviousVersion" -ForegroundColor Yellow
Write-Host "Output File: $OutputFile" -ForegroundColor Yellow
Write-Host ""

# Check if we're in a git repository
try {
    git rev-parse --git-dir 2>&1 | Out-Null
    if ($LASTEXITCODE -ne 0) {
        throw "Not a git repository"
    }
} catch {
    Write-Host "ERROR: Not a git repository!" -ForegroundColor Red
    exit 1
}

# Get repository info
$repoUrl = git config --get remote.origin.url
$currentBranch = git rev-parse --abbrev-ref HEAD
$currentHead = git rev-parse HEAD
$commitCount = git rev-list --count "$PreviousVersion..HEAD"

Write-Host "Exporting Git logs..." -ForegroundColor Green
Write-Host ""

# Create the log file with optimized format for the Release Notes Agent
$logContent = @"
# Git Log Export for Release Notes Generator
# Generated: $(Get-Date -Format "yyyy-MM-dd HH:mm:ss")
# Repository: $repoUrl
# Current Branch: $currentBranch
# Previous Version: $PreviousVersion
# Current HEAD: $currentHead
# Total Commits: $commitCount

================================================
COMMIT HISTORY (Optimized for Agent Parsing)
================================================

"@

# Add commit history in the format the agent expects: "hash - message (author, date)"
$commitLog = git log "$PreviousVersion..HEAD" --pretty=format:"%h - %s (%an, %ad)" --date=short
$logContent += $commitLog
$logContent += @"


================================================
DETAILED COMMIT INFORMATION
================================================

"@

# Add full commit messages for better context
$fullLog = git log "$PreviousVersion..HEAD" --pretty=format:"Commit: %H%nAuthor: %an <%ae>%nDate: %ad%nSubject: %s%n%nBody:%n%b%n------------------------------------%n" --date=iso
$logContent += $fullLog
$logContent += @"


================================================
FILE CHANGES STATISTICS
================================================

"@

# Add statistics
$stats = git diff --stat "$PreviousVersion..HEAD"
$logContent += $stats
$logContent += @"


================================================
CONTRIBUTORS
================================================

"@

# Add contributors
$contributors = git shortlog -sn "$PreviousVersion..HEAD"
$logContent += $contributors
$logContent += @"


================================================
CHANGED FILES LIST
================================================

"@

# Add changed files
$changedFiles = git diff --name-only "$PreviousVersion..HEAD" | Sort-Object
$logContent += ($changedFiles -join "`n")

# Write to file
$logContent | Out-File -FilePath $OutputFile -Encoding UTF8

Write-Host "✓ Git log exported to: $OutputFile" -ForegroundColor Green
Write-Host ""
Write-Host "File size: $((Get-Item $OutputFile).Length) bytes" -ForegroundColor Cyan
Write-Host "Total commits: $commitCount" -ForegroundColor Cyan
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Yellow
Write-Host "1. Open CGS Assist Platform"
Write-Host "2. Navigate to: Use Cases -> CGS Internal -> Release Notes Generator"
Write-Host "3. Upload '$OutputFile'"
Write-Host "4. Enter the version number (e.g., 1.3.0)"
Write-Host "5. Select desired format"
Write-Host "6. Optionally upload implementation docs for more details"
Write-Host "7. Click 'Execute'"
Write-Host ""
Write-Host "Done! 🚀" -ForegroundColor Green

