## Developing a New `*.agent.md` (Brief Dev Introduction)

### What it is

A `*.agent.md` file defines a **custom Copilot agent**.
It acts as a structured system prompt that loads when you call `@AgentName` in Copilot Chat.

It is **instruction injection**, not a separate runtime.

---

## 1️⃣ Required Location

Must be placed in:

```
.github/agents/
```

Example:

```
.github/agents/architect.agent.md
```

If it’s not in this folder, Copilot won’t detect it.

---

## 2️⃣ Minimal Structure

```markdown
---
name: Architect
description: System architecture and technical design expert.
---

# Role
You are a senior software architect.

# Responsibilities
- Translate business requirements into system design
- Identify tradeoffs
- Define boundaries and interfaces

# Output Format
- Context
- Constraints
- Architecture Proposal
- Risks
```

### Required:

* Frontmatter (`---`)
* `name`
* `description`

Keep it concise. Agents degrade if bloated.

---

## 3️⃣ Design Principles

### 1. One Role Per Agent

Do not mix PM + Architect + Reviewer in one file.
Create separate agents.

### 2. Constrain Output

Define output structure explicitly.
Ambiguity weakens reliability.

### 3. Reduce Verbosity

Avoid motivational language.
Avoid personality fluff.
Keep task-scoped.

### 4. Assume Stateless

Agents do not persist memory.
Everything important must be in the prompt or repo context.

---

## 4️⃣ Usage

In Copilot Chat:

```
@Architect design a scalable API for ...
```

Copilot loads that file as system instruction.

---

## 5️⃣ When to Create a New Agent

Create a new `.agent.md` when:

* Role requires different reasoning style
* Output structure differs
* Evaluation criteria differ
* Risk lens differs

Do NOT create agents for:

* Minor tone differences
* Temporary task variations

---

## 6️⃣ Common Mistakes

* Overlong instructions
* Mixing implementation details inside role definition
* No output format
* Storing agents outside `.github/agents/`
* Expecting memory between calls

---

## 7️⃣ Mental Model

Think of `*.agent.md` as:

> A reusable, structured cognitive lens.

Not an AI framework.
Not an execution harness.
Just deterministic instruction scaffolding.

---

If you want, I can give you a **minimal high-performance template** optimized for multi-agent repo workflows.
