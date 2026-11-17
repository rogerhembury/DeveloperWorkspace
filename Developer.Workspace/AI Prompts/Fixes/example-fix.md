# Fix: Example Problem

## Branch

`fix/example-problem`

## Problem

Describe the observed failure, including exact error messages where available.

## Expected Behaviour

Describe what should happen instead.

## Reproduction

Document the known steps required to reproduce the problem.

## Diagnose First

Do not guess at a solution.

Before changing code:

1. Reproduce the problem.
2. Identify the root cause.
3. Inspect relevant recent changes.
4. Distinguish the primary failure from secondary errors.
5. Report if the problem cannot be reproduced.

## Fix

Once the root cause is known:

- Make the smallest appropriate change.
- Do not refactor unrelated code.
- Do not suppress errors or warnings merely to hide the symptom.
- Do not weaken security or validation to make the failure disappear.

## Verification

Verify:

- The original problem no longer reproduces.
- Existing behaviour still works.
- Relevant tests pass.
- The solution builds.

## Completion Report

Report:

- Root cause.
- Exact fix.
- Files changed.
- Tests performed.
- Build result.
- Any remaining concerns.

Do not commit unless explicitly instructed.