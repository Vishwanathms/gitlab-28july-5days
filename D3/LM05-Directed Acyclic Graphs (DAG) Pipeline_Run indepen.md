<img src="https://r2cdn.perplexity.ai/pplx-full-logo-primary-dark%402x.png" class="logo" width="120"/>

# Directed Acyclic Graphs (DAG) Pipeline

Run independent jobs in parallel as long as dependencies are defined.
Example:
yaml
CopyEdit
stages:

- build
- test

build-a:
stage: build
script: echo "Build A"

build-b:
stage: build
script: echo "Build B"

test-a:
stage: test
script: echo "Test A"
needs: [build-a]

test-b:
stage: test
script: echo "Test B"
needs: [build-b]

🔹 Behavior:
build-a and build-b run in parallel.
test-a only waits for build-a; test-b waits for build-b.

create ppt

Here's a ready-to-use PowerPoint slide visual for explaining a **Directed Acyclic Graphs (DAG) Pipeline** with your provided YAML example, showcasing both the workflow and a conceptual diagram for clear understanding:

![PowerPoint slide content for DAG Pipeline with YAML example, behavior explanation, and visual diagram.](https://ppl-ai-code-interpreter-files.s3.amazonaws.com/web/direct-files/f38a1f8662c5770757b6294adc432c78/77dabc31-a925-4abd-b573-c62acb6fa30c/7e41d968.png)

PowerPoint slide content for DAG Pipeline with YAML example, behavior explanation, and visual diagram.

### Slide Content

#### Directed Acyclic Graphs (DAG) Pipeline

- **Concept:**
Run independent jobs in parallel as long as dependencies are defined.


#### YAML Example

```yaml
stages:
  - build
  - test

build-a:
  stage: build
  script: echo "Build A"

build-b:
  stage: build
  script: echo "Build B"

test-a:
  stage: test
  script: echo "Test A"
  needs: [build-a]

test-b:
  stage: test
  script: echo "Test B"
  needs: [build-b]
```


#### Behavior

- `build-a` and `build-b` run in **parallel**
- `test-a` waits only for `build-a`
- `test-b` waits only for `build-b`


#### Visual Diagram

The diagram visually represents parallel execution of `build-a` and `build-b`, each with its own dependent test job, exemplifying how a DAG pipeline leverages job dependencies for efficient CI/CD workflows.

<div style="text-align: center">⁂</div>

