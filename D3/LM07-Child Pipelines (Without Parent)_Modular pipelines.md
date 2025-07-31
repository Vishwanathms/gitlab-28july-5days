<img src="https://r2cdn.perplexity.ai/pplx-full-logo-primary-dark%402x.png" class="logo" width="120"/>

# Child Pipelines (Without Parent)

Modular pipelines defined in a separate file and included with include:.
Example:
yaml
CopyEdit

# .gitlab-ci.yml (Main config)

include:

- local: 'child-pipeline.yml'

yaml
CopyEdit

# child-pipeline.yml

stages:

- lint

lint-job:
stage: lint
script: echo "Linting the code"

🔹 Behavior:
This is useful to split long pipelines into reusable, readable parts.

Here’s how you can present the concept of **Child Pipelines (Without Parent)** in your PowerPoint slide, including example YAML and a clear explanation of their behavior:

### Child Pipelines (Without Parent)

**Concept:**
Modular pipeline definitions can be separated into different files and included in the main pipeline configuration for **reuse** and **readability**.

#### Example

**Main Pipeline Configuration (`.gitlab-ci.yml`):**

```yaml
include:
  - local: 'child-pipeline.yml'
```

**Child Pipeline (`child-pipeline.yml`):**

```yaml
stages:
  - lint

lint-job:
  stage: lint
  script: echo "Linting the code"
```

**Behavior:**

- The main pipeline includes `child-pipeline.yml` using the `include:` keyword.
- The jobs and stages defined in `child-pipeline.yml` become part of the main pipeline.
- No explicit parent-child triggering; instead, this approach helps split long or complex pipelines into manageable, modular files.
- This method is especially useful for reusing common pipeline logic across projects or for improving maintainability.

**How to Visualize:**

- Main pipeline (`.gitlab-ci.yml`) "plugs in" other pipeline files via `include:`.
- All included jobs/stages run as if defined in a single pipeline, making configuration **modular** and **clean**.

You can add a flow diagram with:

- A "Main Pipeline" block showing an arrow to a "Child Pipeline File"
- Both blocks merging into a unified "Pipeline Execution" box, illustrating how included jobs are combined.

