---
name: Feature Spec Generator
description: Use this skill when the user asks to "create a feature spec", "generate PRD", "spec out a feature", "plan a feature", "write product requirements", "create technical architecture", or needs comprehensive feature documentation before implementation.
---

# Feature Spec Generator

Generate comprehensive feature documentation through a PM-style interview workflow. Creates three documents:
1. **PRD (Product Requirements Document)** - filled via interview
2. **Technical Architecture Document** - generated from PRD
3. **Testing Document** - generated from PRD + Architecture

## Prerequisites

- Feature description provided by user (can be brief)
- Git repository context (uses current branch name for folder naming)

## Output Location

Documents are saved to `projects/{feature-branch-name}/` in the repository root:
```
projects/{branch-name}/
├── PRD.md
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
"I'll help you create comprehensive feature documentation in three phases:
1. PRD (through a PM-style interview)
2. Technical Architecture
3. Testing Document

All documents will be saved to `projects/{branch-name}/`. Let's start with the PRD."

### Phase 1: PRD Interview

Conduct a PM-style interview to understand and document the feature. Ask questions in batches of 2-3, waiting for responses before proceeding.

**Interview sections** (in order):

1. **Problem Context** (maps to Feature Overview)
   - What problem does this feature solve?
   - Who experiences this problem and how often?
   - Why is now the right time to address this?

2. **Users and Personas** (maps to User Stories)
   - Who is the primary user?
   - What is their context when using this feature?
   - Are there secondary user types?

3. **Functionality** (maps to Functional Requirements)
   - Walk through the happy path from start to finish
   - What are the must-have capabilities (P0)?
   - What inputs/outputs are involved?

4. **Constraints** (maps to Non-Functional Requirements)
   - Any performance requirements?
   - Security/privacy considerations?
   - Technical or compatibility constraints?

5. **Success Criteria** (maps to Success Metrics)
   - What metrics indicate success?
   - How will we measure them?

6. **Boundaries** (maps to Out of Scope)
   - What are we explicitly NOT building?
   - What might users expect that we won't deliver?

7. **Open Items** (maps to Open Questions)
   - What decisions still need to be made?
   - What assumptions need validation?

**Interview rules:**
- Present 2-3 questions at a time
- Allow "skip" or "not sure yet" for optional items
- Summarize understanding after each section
- At the end, present a summary and ask for confirmation

**After interview completion:**
1. Load PRD template from `templates/prd.md`
2. Fill template with interview responses
3. Write to `projects/{branch}/PRD.md`
4. Present summary and ask: "Does this PRD capture the feature correctly? Reply 'yes' to proceed to Architecture, or tell me what to adjust."

### Phase 2: Technical Architecture

Generate architecture document based on the completed PRD.

1. Read the PRD from `projects/{branch}/PRD.md`
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

Generate testing document based on PRD and Architecture.

1. Read PRD from `projects/{branch}/PRD.md`
2. Read Architecture from `projects/{branch}/ARCHITECTURE.md`
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
- `projects/{branch}/PRD.md`
- `projects/{branch}/ARCHITECTURE.md`
- `projects/{branch}/TESTING.md`

Next steps:
1. Review documents with stakeholders
2. Address open questions in the PRD
3. Begin implementation"

## Phase Transitions

| Transition | User Action Required |
|------------|---------------------|
| Init → Phase 1 | None |
| Phase 1 → Phase 2 | Explicit approval of PRD |
| Phase 2 → Phase 3 | Acknowledgment |
| Phase 3 → Complete | None |

## Important Notes

- This workflow is single-session and non-resumable
- If user abandons mid-interview, warn them the session cannot be resumed
- All three documents must be generated in sequence
- Templates are in the `templates/` subdirectory
- Interview guide reference is in `references/interview-guide.md`
