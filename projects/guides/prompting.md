<aside>
🧠

Prompting is a *skill*. Better prompts do not make the model “smarter”. They make **your intent unambiguous**, reduce wrong assumptions, and force the model to work within useful constraints.

</aside>

Do you typically use AI to produce an output and then copy paste it?

No worries, we’ve all been there. Good news is you can improve it a lot by improving the initial prompt, keep prompting it right, and finally giving it the human touch.

### Quick nav

- **Start here:** see **Initial prompts: do this every time**
- **Advanced:** scroll to **Advanced prompting**
    - Borrow long system prompts (with sources)
    - Emotional and incentive nudges
    - High-effort template

### Initial prompts: do this every time

1. **State the outcome**
    - What do you want at the end? A plan, code, a decision, a draft, a table, a checklist.
2. **Give context**
    - Audience, constraints, tech stack, what is already done, and what “good” looks like.
3. **Provide inputs**
    - Paste the relevant text, data, logs, code, or examples.
4. **Set constraints**
    - Length, format, tone, dependencies allowed, what to avoid, how many you want.
5. **Ask for the process**
    - “Ask me clarifying questions first” or “list assumptions before answering.”
6. **Request verification**
    - “Flag uncertainties,” “cite sources when using external facts,” “show tests,” “include edge cases.”

### A simple framework: TARC

- **T — Target**: what you want as output
- **A — Audience**: who it is for (beginner, CTO, client, what is their level of understanding etc.)
- **R — Resources**: the inputs you provide (text, repo structure, requirements, examples)
- **C — Constraints**: rules the answer must follow (based on expert insight)

### Don’t make the model guess (common failure modes)

- **Vague goal**: “help me build an app” → too broad.
- **Missing constraints**: budget, timeline, stack, compliance, audience.
- **Missing inputs**: asking for a rewrite but not providing the text.
- **Too much at once**: 8 tasks in one prompt.
- **No definition of done**: the model cannot know what “good” means for you.

### “Bad prompt” → “Good prompt” examples

- **Bad**: “Can you help me make an application?”
- **Better**: “I want a simple web app that tracks personal expenses. Audience: me. Stack: Next.js + SQLite. Constraints: no login, one screen, must work on mobile. Output: a step-by-step build plan + minimal schema + 3 UI wireframe descriptions.”
- **Bad**: “Write a blog post about AI.”
- **Better**: “Write a 900-word blog post for US SME founders about practical AI use in ops. Tone: direct, non-hype. Include 3 concrete examples, a short ‘risks’ section, and a checklist at the end. Follow the example of this website.”

### Model choice

- perplexity for everyday questions, it’s good because it cites its sources and is using more recent information
- gemini for deep research because it makes a draft it asks you to confirm before starting the research and takes longer
- claude for writing and coding
- chatgpt for coding and tasks
- https://www.linkedin.com/posts/ingliguori_ai-genai-aistrategy-activity-7426662165949861888-OBNY?utm_source=social_share_video_v2&utm_medium=android_app&rcm=ACoAAE5RE0wBGrst7RsSAFeBj0zKg0zOr4NkcIE&utm_campaign=copy_link

### Expert tips

- Use AI to find out how much you actually know about a topic, and learn.
- Whenever you have a question, ask AI and do research. When we believe we know, we stay a novice.
- Ask it to review things for you and then improve them yourself, don’t just make it rewrite it - or to write it for you.

### Your next 30 minutes (clear list of things to do)

- [ ]  Pick one task you do weekly (email, doc, code change, research).
- [ ]  Write a prompt using the **Beginner’s checklist** above.
- [ ]  Add constraints: format, length, audience.
- [ ]  Ask for clarifying questions first.
- [ ]  Run it, then ask: “What did you assume?”
- [ ]  Provide missing info, then request a second draft.
- [ ]  Save the final prompt as a reusable template.

More:

[https://godmodechatgpt.notion.site/Prompt-Engineering-Guide-6ac6981af5824c988be263f1c4d7c18a](https://www.notion.so/6ac6981af5824c988be263f1c4d7c18a?pvs=21)

https://thinkaiprompt.beehiiv.com/p/how-i-vet-every-prompt

https://anthropic.skilljar.com/

### Advanced prompting

Use this when you already have a decent “baseline prompt”, but you want more *thoroughness* and fewer shallow answers.

#### 1) Borrow long system prompts

A lot of high-performing AI products ship with **long, specific system prompts**. Reading a few will teach you how they:

- Set role and expertise
- Define “quality”
- Force step-by-step work
- Add self-checks

**Example sources:**

- Anthropic publishes system prompts used in their chat experiences (release notes). https://platform.claude.com/docs/en/release-notes/system-prompts
- system-prompts-and-models-of-ai-tools (large repo; verify claims): https://github.com/x1xhlol/system-prompts-and-models-of-ai-tools
- DALL·E / image model prompt collections (various): https://github.com/0xeb/TheBigPromptLibrary

But this guide is only the beginning. It’s about teaching you to look not giving you the answers.

**What to look for inside these prompts (copy the *patterns*, not the brand):**

- **Expertise first:** role + domain + “what good looks like”
- **Process:** assumptions → plan → execute → self-check
- **Output control:** short answer first, then detail, strict format

**Example “system prompt inspired” skeleton**

```
You are a senior [field] specialist with [X] years of experience.
Goal: [goal].
Style: direct, no fluff.
Process:
1) Ask clarifying questions if needed
2) List assumptions
3) Provide solution
4) Self-check for edge cases
Output format: [table/bullets/checklist]
```

#### 2) Emotional / incentive nudges (use sparingly)

These phrasing patterns often push the model to produce a higher-effort answer by signaling **stakes** and **deliberate work**.[[1]](45)

**Most important:** explicitly tell it what **expertise** it should use.

- “Act as a senior **[field]** specialist. Optimize for **[goal]**. Call out tradeoffs and edge cases.”

Other useful nudges (pick 1–2):

- Stakes: “This is critical. Double-check assumptions.”
- Deliberate reasoning: “Take a deep breath and work step by step.”
- Challenge: “Most solutions miss an edge case. Don’t.”
- Incentive language: “I’ll tip you $200 for a perfect, production-ready answer.”
- Self-check: “Rate confidence 0–1. If < 0.9, revise.”

<aside>
⚠️

These can increase verbosity. Pair with hard constraints like “max 200 words” or “table only”.

</aside>

#### Copy/paste template: “high-effort mode”

```
[EXPERTISE]
You are a **[field]** expert with **[X]** years of experience. Optimize for **[goal]**. Provide tradeoffs and edge cases.

[STAKES]
This is important. Mistakes will cost time and credibility.

[METHODOLOGY]
Take a deep breath and work step by step. List assumptions first.

[CONSTRAINTS]
- Keep it under 300 words.
- Use bullet points.
- Include edge cases.
- If unsure, say so and ask clarifying questions.

[TASK]
<put the actual request here>
```