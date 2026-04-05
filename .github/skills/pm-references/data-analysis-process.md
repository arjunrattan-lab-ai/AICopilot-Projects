# Data Analysis Process

Reference for structured Snowflake analysis with Glean cross-validation. Used by `atpm-discover` (Step 6) and optionally by `atpm-explore` (feasibility sizing).

Pattern derived from the DVIR Quality Analysis (90-day cohort study of 20.1M DVIRs, 32,764 companies).

---

## Why This Exists

Snowflake has thousands of tables across `DB_WH.K2_PROD_PUBLIC` and `BI`. Picking the wrong table or the wrong column produces plausible-looking numbers that are quietly wrong. The only reliable way to catch this early is to cross-validate Snowflake results against product docs indexed in Glean (PRDs, product reviews, Redash dashboards, Confluence pages) that contain independently reported metrics for the same domain.

If your Snowflake numbers contradict what the product team already reported, you probably queried the wrong table or filtered wrong.

---

## Phase 1: Schema Discovery

Before writing any analytical query, verify the tables exist and contain the columns you expect.

1. **Identify candidate tables.** Search Glean for the product area's data sources:
   - `glean_default-search` for "snowflake table {domain}" or "{feature} data model" or "TDD {feature}"
   - Look for: Backend TDDs, data engineering docs, Redash query links, prior analysis docs
   - These docs often name the exact tables and key columns

2. **Run discovery queries.** For each candidate table:
   ```sql
   SELECT column_name, data_type
   FROM information_schema.columns
   WHERE table_schema = '{schema}' AND table_name = '{table}'
   ORDER BY ordinal_position;
   ```

3. **Check row counts and freshness.**
   ```sql
   SELECT COUNT(*), MIN(created_at), MAX(created_at)
   FROM {schema}.{table}
   WHERE created_at >= DATEADD(day, -7, CURRENT_DATE());
   ```

4. **Record in scratch.** Save table names, key columns, row counts, and freshness to `scratch/data-sources-{timestamp}.md`.

**Gate:** Do not proceed to Phase 2 until you have confirmed the tables exist, the columns match expectations, and the data is fresh enough for the analysis window.

---

## Phase 2: Cohort Analysis

Structure the analysis around cohort comparisons. A single aggregate number rarely tells a useful story. Cohorts reveal where the signal is concentrated.

### Methodology checklist
- [ ] **Define the cohort split.** What dimension separates "affected" from "control"? (e.g., inspection duration > 3 min vs. <= 3 min)
- [ ] **Set minimum sample sizes.** Exclude entities below a threshold for statistical reliability (e.g., >= 50 DVIRs per company).
- [ ] **Cap outliers.** Set upper/lower bounds to prevent skewed averages (e.g., cap inspection_duration at 30 min).
- [ ] **State the data window.** Explicit date range with rationale (e.g., "90 days: covers full feature rollout period").
- [ ] **Document entity scope.** What is included/excluded and why (e.g., "vehicle entity type only, excludes assets").

### Analysis dimensions
Run these in order. Each builds on the previous.

1. **Cohort overview** — Size, volume, headline metrics for each cohort side-by-side.
2. **Quality/severity breakdown** — Within each cohort, what is the distribution of outcomes? (e.g., major vs. minor defects, churn reasons, ticket severity)
3. **Segment profiling** — Which customer segments (SMB/MM/ENT), industries, or regions are concentrated in each cohort?
4. **Business impact** — ARR exposure, revenue at risk, or growth opportunity per cohort.
5. **Threshold sensitivity** — Test 2-3 alternative cohort boundaries. Is the chosen threshold the right inflection point?

Save all query results to `scratch/data-{timestamp}.md` with the SQL included.

---

## Phase 3: Glean Cross-Validation (Self-Correcting Check)

**This phase is mandatory when Snowflake data was used.** It catches wrong-table errors, stale data, and misinterpreted columns.

### Process

1. **Search Glean for prior metrics.** Run 2-3 searches for independently reported numbers in the same domain:
   - `glean_default-search` for "{feature} product review" or "{feature} metrics"
   - `glean_default-search` for "{feature} PRD" or "{feature} success metrics"
   - `glean_default-search` for "{feature} redash" or "{feature} dashboard"

2. **Extract reference numbers.** From Glean results, pull any concrete metrics:
   - Adoption rates, compliance percentages, closure rates, volume counts
   - These come from product reviews, PRD success criteria, Redash dashboards, prior analyses

3. **Compare Snowflake results vs. Glean reference numbers.** For each overlapping metric:

   | Metric | Snowflake Result | Glean Reference | Source | Match? |
   |--------|-----------------|-----------------|--------|--------|
   | {metric_1} | {value} | {value} | {doc title + link} | ✓ / ✗ |
   | {metric_2} | {value} | {value} | {doc title + link} | ✓ / ✗ |

4. **Evaluate mismatches.**
   - **Small delta (< 20% difference):** Likely explained by different time windows or filters. Note the difference and proceed.
   - **Large delta (> 2x off) or directionally wrong:** Stop. Re-examine query joins, filters, and table choice. Common causes:
     - Wrong table (e.g., `V2_INSPECTION_REPORTS` vs. `INSPECTION_REPORTS` — the V2 table has different columns)
     - Missing filter (e.g., forgot to filter by entity_type, region, or active status)
     - Wrong join key (e.g., joining `company_id` to `sfdc_account_id` without the mapping table)
     - Stale column (e.g., column exists but stopped being populated)

5. **Record the cross-validation.** Save the comparison table to `scratch/data-validation-{timestamp}.md`. If mismatches were found and resolved, document what was wrong and what was fixed.

### What to check in Glean

| Glean Search | What It Catches |
|---|---|
| Product reviews (quarterly/monthly) | Wrong adoption rates, wrong volume counts |
| PRD success metrics | Wrong baseline for feature impact |
| Redash/dashboard links | Different query logic for the same metric |
| Backend TDDs | Wrong column names, deprecated tables |
| Prior analysis docs by other PMs | Different conclusions from the same data |

---

## Phase 4: Decision Log

Every analysis must include a decision log in the scratch folder and summarized in the artifact (PROBLEM.md, SOLUTION.md). This makes the analysis reproducible and auditable.

### Required fields

```markdown
## Data Sources & Decision Log

### Tables Used
| Table | Key Columns | Row Count | Purpose |
|---|---|---|---|
| {schema.table} | {columns} | {N} | {why this table} |

### Glean Cross-Validation
| Metric | Snowflake | Glean Reference | Source | Status |
|---|---|---|---|---|
| {metric} | {value} | {value} | {doc} | ✓ Confirmed / ✗ Fixed: {what changed} |

### Analysis Decisions
| Decision | Choice | Rationale |
|---|---|---|
| Time window | {N} days | {why} |
| Minimum sample | {N} per entity | {why} |
| Outlier cap | {value} | {why} |
| Entity scope | {what included/excluded} | {why} |
| Cohort threshold | {value} | {why — ideally from threshold sensitivity testing} |
```

---

## When to Use This Process

| Situation | Use Full Process? | Notes |
|---|---|---|
| Signal is data-driven (metrics, percentages, volumes) | **Yes** — all 4 phases | Core use case |
| Signal is customer escalation with quantifiable impact | **Yes** — all 4 phases | Size the problem beyond the one customer |
| Signal is competitive or exec directive | **Phase 1 + 3 only** | Verify the internal baseline. Cohort analysis may not apply. |
| Snowflake is not configured | **Skip entirely** | Add blocker to PM-STATE.md. Note in artifact that quantitative validation is incomplete. |
| Quick fact-check (single number lookup) | **Phase 1 + 3 only** | Still verify the table and cross-check the number. |
