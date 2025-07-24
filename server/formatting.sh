#!/bin/bash

# Usage: ./formatting.sh [check|apply|fix]

set -e

ACTION=${1:-apply}

case $ACTION in
    "check")
        echo "🔍 Checking code formatting..."
        docker-compose -f formatting/docker-compose.format.yml run --build --rm format check
        ;;
    "apply"|"fix")
        echo "✨ Applying code formatting..."
        docker-compose -f formatting/docker-compose.format.yml run --build --rm format apply
        ;;
    *)
        echo "Usage: $0 [check|apply|fix]"
        echo "  check - Check formatting without making changes"
        echo "  apply - Apply formatting to all files"
        echo "  fix   - Apply formatting (alias for apply)"
        echo ""
        echo "Examples:"
        echo "  $0 check    # Check if code is properly formatted"
        echo "  $0 apply    # Format all Java files"
        echo "  $0 fix      # Same as apply"
        exit 1
        ;;
esac 