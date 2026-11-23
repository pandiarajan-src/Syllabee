# Feasibility Questions

## Q1. [Architect] What the project rules already answer

The project rules already settle these points. Please confirm them so I do not ask each one separately.

- Tech stack and skills: Python with FastAPI, Pydantic, SQLite via SQLAlchemy and Alembic on the backend; React with TypeScript built with Vite on the frontend; pytest, Vitest and Playwright for tests (project.md, "Tech Stack").
- Hosting: one Docker image on Fly.io, one machine, one volume at /data for the SQLite file; staging and production as separate apps (project.md, "Tech Stack" and "Deployment").
- Existing systems to integrate with: none beyond the above; tests never call real external services (project.md, "Testing Posture").
- Data and compliance exposure: no personal data; the passcode is stored only as an Argon2 hash (project.md, "Security"; product-brief.md, "Users").
- Cloud: AWS is not used; deployment is through GitHub Actions to Fly.io (project.md, "Deployment").

- A. All correct
- B. Some need changing (say which and how)
- X. Other (please specify)

[Answer]: A. All correct

## Q2. [Product owner] Are there any regulatory or compliance requirements?

The project collects no personal data, so I expect none, but your documents do not say so explicitly.

- A. None apply
- B. Some apply (say which under Other, for example data residency)
- C. Not yet known
- X. Other (please specify)

[Answer]: A. None apply

## Q3. [Product owner] What is the budget for running Syllabee?

Fly.io hosting for staging and production may cost a small monthly amount, while the left-out list excludes paid third-party services. This question sets what hosting spend is acceptable.

- A. Keep hosting at or near the free allowance
- B. A small monthly cap (give the amount under Other)
- C. No fixed limit
- D. Not yet defined
- X. Other (please specify)

[Answer]: A. Keep hosting at or near the free allowance

## Q4. [Product owner] What timeline do you have?

Your documents give the release order (v0.1, v0.2, v0.3, then v1.0) but no dates.

- A. No deadline; ship each release when it is ready
- B. A target date for v1.0 (give it under Other)
- C. A regular cadence (say how often under Other)
- D. Not yet defined
- X. Other (please specify)

[Answer]: A. No deadline; ship each release when it is ready

## Q5. [Delivery] Which accounts and access are already in place?

The deployment rules need a Fly.io account, a GitHub repository with Actions, and someone who runs the account-bound commands (fly, gh, git push).

- A. Fly.io and GitHub are both ready, and you run those commands
- B. GitHub is ready; Fly.io still needs setting up
- C. Neither is ready yet
- D. Not yet defined
- X. Other (please specify)

[Answer]: B. GitHub is ready; Fly.io still needs setting up

## Q6. [Product owner] Where will the word list come from?

The product uses its own word list and never the original game's. The word list must also carry a permissive licence, like every dependency.

- A. You will supply the list
- B. Use a permissively licensed public list (I will propose candidates for your approval)
- C. Not yet decided
- X. Other (please specify)

[Answer]: A. You will supply the list

## Q7. [Product owner] Are there organisational blockers?

For example a change freeze, competing priorities, or approvals needed outside this project.

- A. None
- B. Some (say which under Other)
- C. Not yet known
- X. Other (please specify)

[Answer]: A. None

## Consolidated Summary Confirmation

- Looks correct
- Request changes

[Answer]: Looks correct
