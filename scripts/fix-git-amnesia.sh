#!/bin/bash
# Fix Git Amnesia - Persistent Git Configuration Solution
# Story: Agents forget Git configuration between sessions, wasting time on setup

echo "🔧 Fixing Git Amnesia Issue"
echo "============================"

# 1. Set global Git configuration
git config --global user.email "pm@jira-agency.ai"
git config --global user.name "Jira Agency PM"

# 2. Ensure SSH key is loaded
if [ -f ~/.ssh/github_aiagencycx ]; then
    echo "✅ Found GitHub SSH key"
    # Add to SSH agent if not already
    ssh-add ~/.ssh/github_aiagencycx 2>/dev/null || echo "SSH agent not running, but key exists"
else
    echo "⚠️  GitHub SSH key not found at ~/.ssh/github_aiagencycx"
fi

# 3. Create a persistent Git setup script for agents
SETUP_SCRIPT="/root/jira-agency/scripts/git-setup.sh"
cat > "$SETUP_SCRIPT" << 'EOF'
#!/bin/bash
# Persistent Git Setup for Jira Agency Agents
# This script runs automatically or can be called by agents

echo "🚀 Jira Agency Git Setup"
echo "========================"

# Global Git config
git config --global user.email "pm@jira-agency.ai"
git config --global user.name "Jira Agency PM"
git config --global push.default simple

# Project-specific reminders
echo ""
echo "📋 Git Workflow Reminders:"
echo "1. Always check remote: git remote -v"
echo "2. Use SSH: git@github.com:aiagencycx-dot/REPO.git"
echo "3. If HTTPS fails, switch to SSH:"
echo "   git remote set-url origin git@github.com:aiagencycx-dot/REPO.git"
echo "4. First commit in new repo needs:"
echo "   git config user.email 'pm@jira-agency.ai'"
echo "   git config user.name 'Jira Agency PM'"

# Test connection
echo ""
echo "🔗 Testing GitHub SSH connection..."
ssh -T git@github.com 2>&1 | head -5

echo ""
echo "✅ Git setup complete. Ready for commits."
EOF

chmod +x "$SETUP_SCRIPT"

# 4. Create agent memory file about Git setup
MEMORY_FILE="/root/jira-agency/memory/git-setup.md"
mkdir -p /root/jira-agency/memory
cat > "$MEMORY_FILE" << 'EOF'
# Git Configuration Memory
## Permanent Solution for Agent Amnesia

### Problem
Agents forget Git configuration between sessions, wasting time re-discovering:
- User identity (email/name)
- SSH vs HTTPS remotes
- Authentication issues
- First commit setup

### Solution Implemented
1. **Global Git Config**: Set once, persists across sessions
2. **Setup Script**: `/root/jira-agency/scripts/git-setup.sh`
3. **Memory File**: This document as reference
4. **SSH Key**: Located at `~/.ssh/github_aiagencycx`

### Agent Instructions
When starting a new project or session:
1. Run: `/root/jira-agency/scripts/git-setup.sh`
2. Check: `git remote -v` (should be SSH)
3. If HTTPS: `git remote set-url origin git@github.com:aiagencycx-dot/REPO.git`
4. First commit in new repo: Set local config (script does this)

### GitHub Access
- Organization: aiagencycx-dot (personal account)
- SSH Key: Configured in GitHub account
- Default: Use SSH URLs for push/pull

### Common Issues & Fixes
1. **Permission denied**: SSH key not in agent, run `ssh-add ~/.ssh/github_aiagencycx`
2. **No identity**: Run global config commands above
3. **HTTPS 403**: Switch to SSH remote URL
4. **First commit error**: Set local repo config before committing

### Verification
```bash
# Test SSH connection
ssh -T git@github.com

# Check Git config
git config --global --list | grep user

# Check remote
git remote -v
```

Last Updated: $(date)
EOF

# 5. Update the current project's README with Git instructions
PROJECT_README="/root/jira-agency/agency_projects/vps-agency-optimization/README.md"
if [ -f "$PROJECT_README" ]; then
    cat >> "$PROJECT_README" << 'EOF'

## 🔧 Git Setup (No More Amnesia)
To prevent agents from forgetting Git configuration between sessions:
```bash
# Run once per session
/root/jira-agency/scripts/git-setup.sh

# Or manually:
git config --global user.email "pm@jira-agency.ai"
git config --global user.name "Jira Agency PM"
git remote set-url origin git@github.com:aiagencycx-dot/vps-agency-optimization.git
```

**SSH Key**: `~/.ssh/github_aiagencycx` (pre-configured)
**Memory File**: `/root/jira-agency/memory/git-setup.md`
EOF
fi

echo ""
echo "✅ Git Amnesia Fix Deployed"
echo "📁 Setup Script: $SETUP_SCRIPT"
echo "📖 Memory File: $MEMORY_FILE"
echo ""
echo "Agents: Run '/root/jira-agency/scripts/git-setup.sh' at session start"
echo "This story is now RESOLVED."