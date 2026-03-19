# Jarvis (贾维斯) for Codex

Your personalized research strategist for Codex.

Jarvis is a Codex skill for researchers. It reads your papers, builds a profile of your methods and interests, tracks recent papers from arXiv and the venues you care about, and proposes 3-5 ranked research directions you can actually test.

The skill name is `research-junshi`.

You stay the researcher. Jarvis acts like a daily 贾维斯: it connects your past work to fresh literature, looks for gaps, and turns them into concrete ideas with a first experiment and a main risk.

It works across many fields, including machine learning, statistics, economics, biology, physics, robotics, and more.

## What changed from the Claude version

This repo ports the original `junshi-research/research-junshi` Claude Code skill to Codex:

- Skill install path uses `~/.codex/skills/research-junshi`
- User data is stored under `~/.codex/research-junshi`
- Automation uses `codex exec --search`
- Invocation is Codex-native via `$research-junshi`

## 30-second example

Start Codex with web search enabled, then say:

```text
Use $research-junshi.
I work on causal inference and econometrics.
My papers are in ~/papers.
I'm thinking about better ways to handle high-dimensional confounders.
```

Jarvis reads your papers, builds a profile, searches recent arXiv and venue papers, and saves a digest like:

```text
### [Rank 1] Debiased Lasso Meets Synthetic Control
Score: Novelty 4/5 · Feasibility 5/5 · Impact 4/5 -> 4.3/5

The pitch: Synthetic control methods break down when the donor pool is large
relative to the pre-treatment window. Your debiased Lasso work already handles
high-dimensional nuisance estimation. Applying it to reweight the donor pool
could yield valid inference even when p >> T.

Why now: Recent synthetic DiD work opened the direction but still leaves the
high-dimensional donor case underdeveloped.

First experiment: Simulate a panel with n=500 donors, T=50 periods, and sparse
true weights. Compare the debiased estimator against standard synthetic control
and SDID on coverage and RMSE.

Main risk: The weights may not sum to 1 after debiasing, so the projection step
may interfere with inference.
```

## What you get

- Ideas grounded in your own work rather than generic brainstorming
- Daily literature coverage across arXiv plus chosen venues
- Bold ranked ideas with first experiments and main risks
- A standing research profile that improves as you add papers and preliminary results

## Prerequisites

- Codex CLI installed and logged in
- Web search enabled when running the skill
- `pdftotext` available if you want Jarvis to read local PDFs

Install Poppler for PDF extraction if needed:

```bash
brew install poppler
```

## Installation

Clone this repo into your Codex skills directory:

```bash
git clone https://github.com/J0EYjoey/Jarvis.git ~/.codex/skills/research-junshi
```

Codex discovers skills from `~/.codex/skills/`. No extra plugin reload step is required.

## Usage

Run Codex with search enabled and invoke the skill naturally:

```bash
codex --search -C ~
```

Then in Codex:

```text
Use $research-junshi.
I work on [your field].
My papers are in ~/papers.
I'm thinking about [problem].
```

Jarvis will ask only for missing setup information, infer sensible defaults for venues and arXiv categories, and create:

```text
~/.codex/research-junshi/
├── profile.md
├── config.md
└── digests/
    ├── YYYY-MM-DD.md
    └── cron-junshi.log
```

### Daily digest

```text
Use $research-junshi and give me today's research digest.
```

### Update your profile

```text
Use $research-junshi and update my profile. I've shifted focus to [new direction].
```

### Add preliminary results

```text
Use $research-junshi and add a preliminary result: [result].
```

## Automation

To install a daily cron job:

```bash
bash ~/.codex/skills/research-junshi/scripts/setup_automation.sh
```

The script asks for your preferred time and creates a cron entry that runs Codex non-interactively.

Important:

- The automation script uses `codex exec --dangerously-bypass-approvals-and-sandbox --search`
- This is intentionally powerful and should only be used on a trusted local machine
- Review the script before enabling unattended execution

## Supported fields

Built-in venue knowledge covers:

| Field | Example venues |
|---|---|
| Machine Learning | NeurIPS, ICML, ICLR, JMLR |
| Computer Vision | CVPR, ICCV, ECCV |
| NLP | ACL, EMNLP, NAACL |
| Robotics | ICRA, RSS, CoRL |
| Biology | Nature, Science, Cell, Bioinformatics |
| Physics | PRL, PRX, Nature Physics |
| Economics / Statistics | Econometrica, AER, Annals of Statistics |
| Systems / HCI | SOSP, OSDI, SIGCHI, UIST |

If your field or venue is not listed, tell Jarvis and it will adapt.

## Repository layout

- `SKILL.md`: core Codex skill instructions
- `agents/openai.yaml`: Codex UI metadata
- `references/venues.md`: field-to-venue and arXiv category defaults
- `scripts/setup_automation.sh`: cron-based unattended execution

## License

Apache-2.0. This repo is derived from the original `junshi-research/research-junshi` project and adapted for Codex.
