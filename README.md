# LOC_statistic

Calculates statistics for a specific repository by analyzing pull requests (PRs). It identifies the total number of PRs created after a specified date, counts how many have changes under a defined LOC (lines of code) limit, and calculates the percentage of such PRs.

## How to Use:
1. Place this script (`LOC_statistic.sh`) in the root directory of the repository you want to analyze.
2. Ensure you have the following tools installed:
   - [GitHub CLI (`gh`)](https://cli.github.com/) and authenticated.
   - [`jq`](https://stedolan.github.io/jq/) for processing JSON data.
3. Run the script in your terminal:
   ```bash
   ./calculate_prs.sh
   ```
4. Customize the START_DATE and MAX_LOC variables in the script to suit your requirements.
