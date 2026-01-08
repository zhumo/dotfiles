# PRD Interview Guide

## Interview Principles

1. Ask 2-3 questions at a time
2. Wait for response before proceeding
3. Allow "skip" or "not sure yet" responses
4. Summarize understanding after each section
5. Get explicit approval before moving to architecture phase

---

## Section 1: Problem Context

**Transition:** "Let me understand the problem this feature solves."

### Questions (present 2-3 at a time):

1. "What specific problem does this feature solve?"
2. "Who is experiencing this problem? How often?"
3. "What happens if we don't solve this problem?"
4. "Why is now the right time to address this?"
5. "Are there existing workarounds users employ?"

**Maps to:** Feature Overview / Problem Statement

---

## Section 2: Users and Personas

**Transition:** "Now let's talk about who will use this feature."

### Questions:

1. "Who is the primary user of this feature?"
2. "What is their role or context?"
3. "What is their technical sophistication level?"
4. "In what context will they use this feature? (device, environment, frequency)"
5. "Are there other user types who will interact with this?"

**Maps to:** User Stories / Use Cases

---

## Section 3: Functionality

**Transition:** "Let's get into what this feature actually does."

### Questions:

1. "Walk me through the happy path - what does a user do from start to finish?"
2. "What are the absolute must-have capabilities (P0s)?"
3. "What would be nice to have but not essential (P1s)?"
4. "What inputs does the user provide?"
5. "What outputs or feedback do they receive?"
6. "How does this feature connect to existing features?"

**Maps to:** Functional Requirements

---

## Section 4: Constraints

**Transition:** "Let's discuss any constraints or requirements beyond functionality."

### Questions:

1. "Are there performance requirements? (response time, throughput)"
2. "What are the security/privacy considerations?"
3. "Are there technology constraints? (must use X, can't use Y)"
4. "Are there compatibility requirements? (browsers, devices, APIs)"
5. "Are there compliance or regulatory requirements?"

**Maps to:** Non-Functional Requirements

---

## Section 5: Success Metrics

**Transition:** "How will we know if this feature is successful?"

### Questions:

1. "What metrics would indicate success?"
2. "What's the target for each metric?"
3. "How will we measure these?"

**Maps to:** Success Metrics

---

## Section 6: Boundaries

**Transition:** "It's equally important to define what's NOT in scope."

### Questions:

1. "What are we explicitly NOT building in this version?"
2. "What might users expect that we won't deliver?"
3. "Are there adjacent features we're deferring to later?"

**Maps to:** Out of Scope

---

## Section 7: Open Questions

**Transition:** "Finally, let's capture what we still need to figure out."

### Questions:

1. "What decisions still need to be made?"
2. "What information are we missing?"
3. "What assumptions are we making that should be validated?"

**Maps to:** Open Questions

---

## Interview Wrap-Up

**Summary Template:**
"Based on our discussion, here's what I understand:

**Problem:** {summary}
**Users:** {summary}
**Core Functionality:** {summary}
**Key Constraints:** {summary}
**Success Looks Like:** {summary}
**Not Included:** {summary}
**Open Items:** {summary}

Does this capture the feature correctly? Reply 'yes' to proceed to the Technical Architecture phase, or tell me what to adjust."
