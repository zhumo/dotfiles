# Technical Architecture: {Feature Name}

**PRD Reference:** projects/{branch}/PRD.md
**Created:** {date}
**Status:** Draft

---

## 1. System Overview

### Purpose
{Brief description of what this architecture enables}

### Scope
{Boundaries of this architecture document}

### High-Level Diagram
```
{ASCII diagram of system components}
```

---

## 2. Component Design

### Component Overview

| Component | Responsibility | Technology |
|-----------|---------------|------------|
| {name} | {what it does} | {tech stack} |

### Component Details

#### Component: {Name}

**Purpose:** {what this component does}

**Responsibilities:**
- {responsibility 1}
- {responsibility 2}

**Interfaces:**
- Input: {interface description}
- Output: {interface description}

**Error Handling:**
{error handling strategy}

---

## 3. Data Flow

### Primary Data Flow

```
[Input] -> [Component A] -> [Component B] -> [Output]
```

### Flow Description

1. **{Step Name}:** {description}
2. **{Step Name}:** {description}

### Data Transformations

| Stage | Input Format | Output Format | Transformation |
|-------|--------------|---------------|----------------|
| {stage} | {format} | {format} | {what changes} |

---

## 4. API/Interface Definitions

### External APIs

#### API: {Name}

**Endpoint:** `{HTTP method} /path`

**Request:**
```json
{
  "field": "type"
}
```

**Response:**
```json
{
  "field": "type"
}
```

**Error Codes:**
| Code | Description |
|------|-------------|
| {code} | {description} |

### Internal Interfaces

#### Interface: {Name}

**Methods:**
- `{method signature}` - {description}

---

## 5. Dependencies

### External Dependencies

| Dependency | Version | Purpose | Risk Level |
|------------|---------|---------|------------|
| {name} | {version} | {why needed} | Low/Medium/High |

### Internal Dependencies

| Module | Dependency Type | Impact if Unavailable |
|--------|-----------------|----------------------|
| {name} | {hard/soft} | {what breaks} |

---

## 6. Implementation Approach

### Development Phases

| Phase | Scope | Deliverables |
|-------|-------|--------------|
| 1 | {scope} | {what gets delivered} |

### Implementation Order

1. **{Component/Feature}** - {rationale for order}
2. **{Component/Feature}** - {rationale}

### Key Implementation Decisions

| Decision | Options Considered | Choice | Rationale |
|----------|-------------------|--------|-----------|
| {decision} | {options} | {chosen} | {why} |

---

## 7. Risk Assessment

### Technical Risks

| Risk | Probability | Impact | Mitigation |
|------|-------------|--------|------------|
| {risk} | Low/Med/High | Low/Med/High | {mitigation strategy} |

### Security Considerations
{security risks and mitigations}

### Performance Risks
{performance concerns and mitigations}

---

## Appendix

### Technology Stack Summary
- **Language:** {language}
- **Framework:** {framework}
- **Database:** {if applicable}
- **Infrastructure:** {if applicable}

### References
- {reference 1}
