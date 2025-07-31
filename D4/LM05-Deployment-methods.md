<img src="https://r2cdn.perplexity.ai/pplx-full-logo-primary-dark%402x.png" class="logo" width="120"/>

# Here are key discussion points to cover Deployment Strategies in GitLab from the perspectives of manual, automatic deployments, and environments:

🚀 Deployment Strategies in GitLab CI/CD

1. Manual Deployments
These require a human to trigger the deployment manually from the GitLab UI or API.
📌 Key Talking Points:
Use when: manual in .gitlab-ci.yml.
Useful for production deployments that need approval.
Appears as a play button in the pipeline UI.
Can be combined with allow_failure: false to block pipeline until approval.
Ideal for release gates, staging-to-prod promotion, or hotfix approval.
Example:
deploy_prod:
stage: deploy
script: ./deploy.sh
when: manual
environment: production
2. Automatic Deployments
Triggered automatically based on defined conditions like branch, tag, or MR.
📌 Key Talking Points:
Happens without user intervention.
Often used for dev, test, or staging environments.
Can be controlled using rules: or only/except clauses.
Use for continuous delivery pipelines.
Example:
deploy_staging:
stage: deploy
script: ./deploy.sh
rules:
    - if: '\$CI_COMMIT_BRANCH == "develop"'
3. Using GitLab Environments
GitLab provides first-class support for deployment environments.
📌 Key Talking Points:
Define environments like dev, staging, production.
Environment-specific features:
Deployment tracking
Rollback options
Environment URLs for preview
Approval policies (protected environments)
Allows you to visually track where a commit is deployed.
Example:
deploy_dev:
stage: deploy
script: ./deploy.sh dev
environment:
name: development
url: https://dev.example.com
4. Protected Environments
Prevent deployments to sensitive environments (e.g., production) without approval.
Only authorized users or groups can deploy.
How to Enable:
Project → Settings → CI/CD → Environments → Protect
5. Review Apps (Dynamic Environments)
Temporary environments created per branch or MR.
Useful for previewing feature branches before merge.
Example:
deploy_review:
stage: deploy
script: ./deploy.sh
environment:
name: review/$CI_COMMIT_REF_NAME
 url: https://$CI_COMMIT_REF_NAME.example.com
on_stop: stop_review
6. Rollback Strategy
Use Git tags or previous builds to redeploy old versions.
Use GitLab environments’ "Re-deploy" button for quick rollback.
7. Deployment Visibility
GitLab shows:
Deployment history
Who triggered it
Duration
Target environment

✅ Summary Slide (Optional):
StrategyTriggerUse Case
Manual
User action
Prod releases, hotfixes
Auto
On push/MR
Dev/test deployments
Review Apps
MR
Feature preview
Protected
Controlled access
Secure production deployment

Let me know if you'd like this turned into a slide deck or table format.

Provide details labs for each scenario

Here are **detailed lab exercises** for each GitLab deployment strategy scenario, so you can practice and understand how each feature works in a real repo. Each lab assumes you have a project with GitLab CI/CD enabled and pipeline runners available.

## 1. Manual Deployments

**Goal:** Deploy to production only after human approval.

**Lab Steps:**

1. Open your project’s `.gitlab-ci.yml` and add:

```yaml
stages:
  - build
  - deploy

build:
  stage: build
  script: echo "Building..."

deploy_prod:
  stage: deploy
  script: echo "Deploying to Production"
  when: manual
  environment: production
  allow_failure: false
```

2. Push the change. Observe that after the build finishes, a "play" button appears for the `deploy_prod` job in the pipeline UI.
3. Try clicking the play button; deployment will only happen with explicit approval.

**What to check:**

- Only authorized users can manually trigger deploy.
- Pipeline blocks at deploy stage until approval.


## 2. Automatic Deployments

**Goal:** Trigger auto deployment to staging on every push to `develop`.

**Lab Steps:**

1. Add to your `.gitlab-ci.yml`:

```yaml
deploy_staging:
  stage: deploy
  script: echo "Deploying to Staging"
  rules:
    - if: '$CI_COMMIT_BRANCH == "develop"'
  environment:
    name: staging
```

2. Commit/push to the `develop` branch.
3. Verify that `deploy_staging` runs automatically without user input when you push.

**What to check:**

- Job runs without manual trigger on `develop` branch.
- The pipeline shows deployment to staging environment.


## 3. Using GitLab Environments

**Goal:** Track deployments, URLs, and status per environment.

**Lab Steps:**

1. Use this in `.gitlab-ci.yml`:

```yaml
deploy_dev:
  stage: deploy
  script: echo "Deploying to Development"
  environment:
    name: development
    url: https://dev.example.com
```

2. After pipeline runs, visit **Operations → Environments** in GitLab.
3. See “development” with last deployment, active status, and direct URL.

**Experiment:**

- Deploy to different environments (dev, staging, prod) and watch status updates in the Environments dashboard.


## 4. Protected Environments

**Goal:** Protect production deployments so only approved users can deploy.

**Lab Steps:**

1. As a project maintainer, go to:
    - Project → **Settings** → **CI/CD** → Environments → **Protect**
2. Protect the `production` environment, assigning deploy rights to specific users/groups.
3. In your YAML, add:

```yaml
deploy_prod:
  stage: deploy
  script: echo "Deploying to Production"
  environment: production
  when: manual
```

4. Try running a production deploy as a non-authorized user; deployment should be blocked.

**What to check:**

- Only authorized users see/play the "deploy" button for protected environments.


## 5. Review Apps (Dynamic Environments)

**Goal:** Create a live preview environment for each MR or branch.

**Lab Steps:**

1. Add to `.gitlab-ci.yml`:

```yaml
deploy_review:
  stage: deploy
  script: echo "Deploying review for $CI_COMMIT_REF_NAME"
  environment:
    name: review/$CI_COMMIT_REF_NAME
    url: https://$CI_COMMIT_REF_NAME.example.com
    on_stop: stop_review

stop_review:
  stage: deploy
  script: echo "Stopping review app $CI_COMMIT_REF_NAME"
  when: manual
  environment:
    name: review/$CI_COMMIT_REF_NAME
    action: stop
```

2. Create a new branch, push a commit, and open a merge request.
3. Observe a “review/\$CI_COMMIT_REF_NAME” environment appears in GitLab, with a custom URL.

**What to check:**

- Each MR gets a unique environment.
- Stopping the review environment works via the “Stop” button.


## 6. Rollback Strategy

**Goal:** Roll back production to a previous working version.

**Lab Steps:**

1. Deploy a build as usual to production.
2. Tag the good release (e.g., `v1.0.0`).
3. If a bad deploy occurs, go to **Operations → Environments**.
4. Use the “Re-deploy” button next to an older successful deployment, or push an older tag/commit and watch the pipeline deploy it.

**What to check:**

- GitLab shows exact commit, who deployed, and re-deploys reliably.
- The pipeline history clearly marks deployments and rollbacks.


## 7. Deployment Visibility

**Goal:** Track every deployment’s status, duration, and person.

**Lab Steps:**

1. Trigger both manual and automatic deployments using earlier labs.
2. Go to **Operations → Environments**; review:
    - Deployment history (list of deploys)
    - Who triggered which deployment
    - Timestamps and durations
    - Links to each environment

**What to check:**

- Who, what, when is visible for every deployment.
- Links to running Review Apps or env URLs open expected previews.

**Tip:** You can run these labs in a test project for a demo or training scenario, and extend them with real deploy scripts, approvals, or infrastructure actions!

Let me know if you’d like this in a **table format** or need .gitlab-ci.yml code for a specific real application scenario.

