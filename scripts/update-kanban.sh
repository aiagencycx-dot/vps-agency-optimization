#!/bin/bash
# VPS Agency Optimization Kanban Update Script

PROJECT="vps-agency-optimization"
TASK=$1
STATUS=$2
AGENT=$3
NOTES=$4

cd /root/jira-agency
node scripts/update-kanban.js "$PROJECT" "$TASK" "$STATUS" "$AGENT" "$NOTES"

echo "✅ VPS Agency Kanban updated: $TASK → $STATUS by $AGENT"
echo "📊 View board: /root/jira-agency/agency_projects/jira-agency-dashboard/kanban/vps-agency-optimization-kanban.html"