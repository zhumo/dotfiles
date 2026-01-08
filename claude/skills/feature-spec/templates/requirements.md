# Requirements: {Feature Name}

**Branch:** {branch-name}
**Created:** {date}
**Status:** Draft

---

## 1. Overview

### Summary
{One paragraph describing what this feature does}

### Trigger
{What initiates this feature - user action, event, schedule, etc.}

---

## 2. Functional Requirements

### Core Flow

1. {Step 1}
2. {Step 2}
3. {Step 3}

### Inputs

| Input | Type | Required | Description |
|-------|------|----------|-------------|
| {name} | {type} | Yes/No | {description} |

### Outputs

| Output | Type | Description |
|--------|------|-------------|
| {name} | {type} | {description} |

### Detailed Behavior

#### {Scenario Name}
**Given:** {precondition}
**When:** {action}
**Then:** {expected result}

---

## 3. Edge Cases & Error Handling

### Input Validation

| Condition | Expected Behavior |
|-----------|-------------------|
| Missing required field | {behavior} |
| Invalid format | {behavior} |
| {other condition} | {behavior} |

### Failure Scenarios

| Failure | Handling | Retry? |
|---------|----------|--------|
| Dependency unavailable | {fallback behavior} | Yes/No |
| Timeout | {behavior} | Yes/No |
| {other failure} | {behavior} | Yes/No |

### Concurrency Considerations
{Race conditions, locking, idempotency requirements}

---

## 4. Data Requirements

### Persistence

| Data | Storage | Retention |
|------|---------|-----------|
| {data item} | {where stored} | {how long} |

### Data Validation Rules
- {rule 1}
- {rule 2}

### Sensitive Data
{PII, credentials, or other sensitive data considerations}

### Scale Expectations
- Expected volume: {volume}
- Growth rate: {rate}

---

## 5. Integration Points

### Systems Touched

| System | Interaction | Impact |
|--------|-------------|--------|
| {system} | Read/Write/Both | {what changes} |

### APIs

#### Consumed
| API | Purpose | Auth |
|-----|---------|------|
| {api} | {why needed} | {auth method} |

#### Exposed
| Endpoint | Method | Purpose |
|----------|--------|---------|
| {path} | GET/POST/etc | {description} |

### Database Changes
{Schema changes, new tables, migrations needed}

### Backwards Compatibility
{Breaking changes, deprecations, migration path}

---

## 6. Scope

### In Scope (MVP)
- {item 1}
- {item 2}

### Explicitly Out of Scope
- {item 1} - {reason/deferral}
- {item 2} - {reason/deferral}

### Hardcoded for Now
| Item | Current Value | Make Configurable When |
|------|---------------|------------------------|
| {item} | {value} | {trigger} |

---

## 7. Open Questions

| Question | Blocker? | Owner | Notes |
|----------|----------|-------|-------|
| {question} | Yes/No | {who} | {context} |

### Assumptions to Validate
- {assumption 1}
- {assumption 2}

### Technical Unknowns
- {unknown 1} - {spike needed?}

---

## Appendix

### Glossary
- **{term}:** {definition}

### References
- {reference 1}
