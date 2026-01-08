# Requirements Interview Guide

## Interview Principles

1. Ask 2-3 questions at a time
2. Wait for response before proceeding
3. Allow "skip" or "I'll figure it out later" responses
4. Dig into edge cases and error conditions
5. Get explicit approval before moving to architecture phase

**Perspective:** Engineering manager peer helping to clarify requirements before implementation. Focus on concrete behavior, edge cases, and technical constraints - not product strategy.

---

## Section 1: Core Behavior

**Transition:** "Let's nail down exactly what this needs to do."

### Questions:

1. "Walk me through the main flow - what happens step by step?"
2. "What are the inputs? What are the outputs?"
3. "What triggers this? (user action, scheduled, event-driven?)"
4. "What existing systems or data does this interact with?"

**Maps to:** Functional Requirements

---

## Section 2: Edge Cases & Error Handling

**Transition:** "Now let's think about what could go wrong."

### Questions:

1. "What happens if the input is malformed or missing?"
2. "What if a dependency (API, database, service) is unavailable?"
3. "Are there rate limits, quotas, or resource constraints to handle?"
4. "What's the retry/fallback behavior when something fails?"
5. "Any race conditions or concurrency concerns?"

**Maps to:** Edge Cases, Error Handling

---

## Section 3: Data & State

**Transition:** "Let's talk about data."

### Questions:

1. "What data needs to be persisted vs. ephemeral?"
2. "What's the expected data volume/scale?"
3. "Are there data validation rules or constraints?"
4. "Any data that needs to be kept in sync across systems?"
5. "Sensitive data considerations? (PII, credentials, etc.)"

**Maps to:** Data Requirements, Non-Functional Requirements

---

## Section 4: Integration Points

**Transition:** "How does this fit with existing systems?"

### Questions:

1. "What existing code/systems does this touch or modify?"
2. "Any APIs being consumed or exposed?"
3. "Database changes needed? (new tables, schema changes)"
4. "Does this need to work with existing auth/permissions?"
5. "Any backwards compatibility concerns?"

**Maps to:** Dependencies, Integration Requirements

---

## Section 5: Scope Boundaries

**Transition:** "Let's be explicit about what's in and out of scope."

### Questions:

1. "What's the minimum viable version of this?"
2. "What are we explicitly NOT doing in this iteration?"
3. "Any tempting additions we should resist for now?"
4. "What can we hardcode now and make configurable later?"

**Maps to:** Out of Scope, MVP Definition

---

## Section 6: Open Questions

**Transition:** "What do we still need to figure out?"

### Questions:

1. "Any technical unknowns or spikes needed?"
2. "Decisions that depend on other teams or external factors?"
3. "Assumptions we're making that should be validated?"
4. "Anything blocked on more information?"

**Maps to:** Open Questions, Technical Risks

---

## Interview Wrap-Up

**Summary Template:**
"Here's my understanding:

**Core Flow:** {summary}
**Key Edge Cases:** {summary}
**Data Considerations:** {summary}
**Integration Points:** {summary}
**Scope:** {what's in} / NOT: {what's out}
**Open Items:** {summary}

Does this capture the requirements? Reply 'yes' to proceed to Technical Architecture, or let me know what to adjust."
