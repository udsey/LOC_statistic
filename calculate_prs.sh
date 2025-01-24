#!/bin/bash

START_DATE="2024-10-23"
MAX_LOC=300

total_prs=0
prs_under_limit=0


open_prs=$(gh pr list --state open --json number,title,createdAt --limit 1000)
merged_prs=$(gh pr list --state merged --json number,title,createdAt --limit 1000)
all_prs=$(echo "$open_prs" | jq -c '.[]')$'\n'$(echo "$merged_prs" | jq -c '.[]')

while read -r pr; do
  pr_number=$(echo "$pr" | jq -r '.number')
  pr_date=$(echo "$pr" | jq -r '.createdAt')
  pr_title=$(echo "$pr" | jq -r '.title')

  if [[ "$pr_date" > "$START_DATE" ]]; then
    stats=$(gh pr view "$pr_number" --json additions,deletions)
    added=$(echo "$stats" | jq -r '.additions // 0')
    deleted=$(echo "$stats" | jq -r '.deletions // 0')
    total_loc=$((added + deleted))
    ((total_prs++))

    if ((total_loc < MAX_LOC)); then
      echo "PR #$pr_number: '$pr_title' (LOC: $total_loc)"
      ((prs_under_limit++))
    fi
  fi
done < <(echo "$all_prs")

echo "Total PRs: $total_prs"
echo "PRs with LOC < $MAX_LOC: $prs_under_limit"
if ((total_prs > 0)); then
  percentage=$(awk -v a=$prs_under_limit -v b=$total_prs 'BEGIN {printf "%.2f", (a / b) * 100}')
  echo "Percentage: $percentage%"
else
  echo "No PRs found after $START_DATE."
fi
