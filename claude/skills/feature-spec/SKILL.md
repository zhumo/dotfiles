---
name: Feature Spec Generator
description: Use this skill when the user asks to "create a feature spec", "spec out a feature", "write requirements", "document requirements", "create technical spec", or needs to clarify requirements before implementation.
---

# Feature Spec Generator

Generate comprehensive feature documentation through a requirements interview. Creates three documents:
1. **Requirements Document** - filled via interview
2. **Technical Architecture Document** - generated from requirements
3. **Testing Document** - generated from requirements + architecture

**Perspective:** Engineering manager peer helping clarify requirements before implementation. Focus on concrete behavior, edge cases, and technical constraints.

## Prerequisites

- Feature description provided by user (can be brief)
- Git repository context (uses current branch name for folder naming)

## Output Location

Documents are saved to `projects/{feature-branch-name}/` in the repository root:
```
projects/{branch-name}/
├── REQUIREMENTS.md
├── ARCHITECTURE.md
└── TESTING.md
```

## Workflow Execution

### Initialization

1. Capture feature description from $ARGUMENTS or prompt user if not provided
2. Get branch name: `git branch --show-current`
3. Create output directory: `mkdir -p projects/{branch-name}`
4. Announce the three-phase process to user

**Opening message:**
"I'll help you document this feature in three phases:
1. Requirements (through an interview)
2. Technical Architecture
3. Testing Plan

All documents will be saved to `projects/{branch-name}/`. Let's start by nailing down the requirements."

### Phase 1: Requirements Interview

Conduct an interview to clarify and document requirements. Ask questions in batches of 2-3, waiting for responses before proceeding.

**Interview sections** (in order):

1. **Core Behavior** (maps to Functional Requirements)
   - Walk through the main flow step by step
   - What are the inputs and outputs?
   - What triggers this?
   - What existing systems does this interact with?

2. **Edge Cases & Error Handling** (maps to Edge Cases)
   - What if input is malformed or missing?
   - What if a dependency is unavailable?
   - Rate limits, quotas, resource constraints?
   - Retry/fallback behavior?
   - Concurrency concerns?

3. **Data & State** (maps to Data Requirements)
   - What data is persisted vs ephemeral?
   - Expected volume/scale?
   - Validation rules?
   - Sensitive data considerations?

4. **Integration Points** (maps to Integration)
   - What existing code/systems does this touch?
   - APIs consumed or exposed?
   - Database changes needed?
   - Backwards compatibility concerns?

5. **Scope Boundaries** (maps to Scope)
   - What's the minimum viable version?
   - What's explicitly out of scope?
   - What can be hardcoded for now?

6. **Open Questions** (maps to Open Questions)
   - Technical unknowns or spikes needed?
   - Decisions depending on external factors?
   - Assumptions to validate?

**Interview rules:**
- Present 2-3 questions at a time
- Allow "skip" or "I'll figure it out later" for items
- Dig into edge cases - that's where bugs hide
- Summarize understanding after each section
- At the end, present a summary and ask for confirmation

**After interview completion:**
1. Load requirements template from `templates/requirements.md`
2. Fill template with interview responses
3. Write to `projects/{branch}/REQUIREMENTS.md`
4. Present summary and ask: "Does this capture the requirements? Reply 'yes' to proceed to Architecture, or tell me what to adjust."

### Phase 2: Technical Architecture

Generate architecture document based on the completed requirements.

1. Read the requirements from `projects/{branch}/REQUIREMENTS.md`
2. Analyze requirements to determine:
   - System components needed
   - Data flows between components
   - APIs and interfaces
   - Dependencies (internal and external)
   - Implementation approach
   - Technical risks
3. Load architecture template from `templates/architecture.md`
4. Generate architecture document
5. Write to `projects/{branch}/ARCHITECTURE.md`
6. Present key highlights: "Architecture document complete. Key components: {list}. Proceeding to Testing document..."

### Phase 3: Testing Document

Generate testing document based on requirements and architecture.

1. Read requirements from `projects/{branch}/REQUIREMENTS.md`
2. Read architecture from `projects/{branch}/ARCHITECTURE.md`
3. Generate test plan covering:
   - Unit tests for each component
   - Integration tests for component interactions
   - Test cases mapped to requirements
   - Edge cases and error conditions
   - Test data requirements
4. Load testing template from `templates/testing.md`
5. Generate testing document
6. Write to `projects/{branch}/TESTING.md`

### Completion

Present final summary:
"Feature specification complete! Documents created:
- `projects/{branch}/REQUIREMENTS.md`
- `projects/{branch}/ARCHITECTURE.md`
- `projects/{branch}/TESTING.md`

Next steps:
1. Review documents
2. Resolve open questions
3. Begin implementation"

## Phase Transitions

| Transition | User Action Required |
|------------|---------------------|
| Init → Phase 1 | None |
| Phase 1 → Phase 2 | Explicit approval of requirements |
| Phase 2 → Phase 3 | Acknowledgment |
| Phase 3 → Complete | None |

## Important Notes

- This workflow is single-session and non-resumable
- If user abandons mid-interview, warn them the session cannot be resumed
- All three documents must be generated in sequence
- Templates are in the `templates/` subdirectory
- Interview guide reference is in `references/interview-guide.md`
