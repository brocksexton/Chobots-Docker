#!/bin/bash
set -e

ACTION=${1:-check}

case "$ACTION" in
    "check")
        echo "Checking code formatting..."
        mvn spotless:check
        echo "✅ Code formatting check passed!"
        ;;
    "apply")
        echo "Applying code formatting..."
        mvn spotless:apply
        echo "✅ Code formatting applied successfully!"
        ;;
    "fix")
        echo "Checking and fixing code formatting..."
        mvn spotless:apply
        echo "✅ Code formatting fixed!"
        ;;
    *)
        echo "Usage: $0 [check|apply|fix]"
        echo "  check - Check formatting without making changes (default)"
        echo "  apply - Apply formatting to all files"
        echo "  fix   - Apply formatting (alias for apply)"
        exit 1
        ;;
esac 