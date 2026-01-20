#!/bin/bash
# Git Log Export Script for Release Notes Generator
# Usage: ./export-git-log.sh [previous_version_tag] [output_file]

# Default values
PREVIOUS_VERSION="${1:-HEAD~50}"  # Default: last 50 commits
OUTPUT_FILE="${2:-git-log-for-release-notes.txt}"

echo "================================================"
echo "Git Log Export for Release Notes Generator"
echo "================================================"
echo ""
echo "Previous Version: $PREVIOUS_VERSION"
echo "Output File: $OUTPUT_FILE"
echo ""

# Check if we're in a git repository
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    echo "ERROR: Not a git repository!"
    exit 1
fi

# Get repository info
REPO_URL=$(git config --get remote.origin.url)
CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
CURRENT_HEAD=$(git rev-parse HEAD)
COMMIT_COUNT=$(git rev-list --count "$PREVIOUS_VERSION..HEAD")

echo "Exporting Git logs..."
echo ""

# Create the log file with optimized format for the Release Notes Agent
{
    echo "# Git Log Export for Release Notes Generator"
    echo "# Generated: $(date '+%Y-%m-%d %H:%M:%S')"
    echo "# Repository: $REPO_URL"
    echo "# Current Branch: $CURRENT_BRANCH"
    echo "# Previous Version: $PREVIOUS_VERSION"
    echo "# Current HEAD: $CURRENT_HEAD"
    echo "# Total Commits: $COMMIT_COUNT"
    echo ""
    echo "================================================"
    echo "COMMIT HISTORY (Optimized for Agent Parsing)"
    echo "================================================"
    echo ""

    # Commit history in the format the agent expects: "hash - message (author, date)"
    git log "$PREVIOUS_VERSION..HEAD" \
        --pretty=format:"%h - %s (%an, %ad)" \
        --date=short

    echo ""
    echo ""
    echo "================================================"
    echo "DETAILED COMMIT INFORMATION"
    echo "================================================"
    echo ""

    # Full commit messages for better context
    git log "$PREVIOUS_VERSION..HEAD" \
        --pretty=format:"Commit: %H%nAuthor: %an <%ae>%nDate: %ad%nSubject: %s%n%nBody:%n%b%n------------------------------------%n" \
        --date=iso

    echo ""
    echo "================================================"
    echo "FILE CHANGES STATISTICS"
    echo "================================================"
    echo ""

    # Statistics
    git diff --stat "$PREVIOUS_VERSION..HEAD"

    echo ""
    echo ""
    echo "================================================"
    echo "CONTRIBUTORS"
    echo "================================================"
    echo ""

    # Contributors with commit counts
    git shortlog -sn "$PREVIOUS_VERSION..HEAD"

    echo ""
    echo ""
    echo "================================================"
    echo "CHANGED FILES LIST"
    echo "================================================"
    echo ""

    # List of all changed files
    git diff --name-only "$PREVIOUS_VERSION..HEAD" | sort

} > "$OUTPUT_FILE"

echo "✓ Git log exported to: $OUTPUT_FILE"
echo ""
echo "File size: $(wc -c < "$OUTPUT_FILE") bytes"
echo "Total commits: $COMMIT_COUNT"
echo ""
echo "Next steps:"
echo "1. Open CGS Assist Platform"
echo "2. Navigate to: Use Cases -> CGS Internal -> Release Notes Generator"
echo "3. Upload '$OUTPUT_FILE'"
echo "4. Enter the version number (e.g., 1.3.0)"
echo "5. Select desired format"
echo "6. Optionally upload implementation docs for more details"
echo "7. Click 'Execute'"
echo ""
echo "Done! 🚀"

