# CI/CD and Deployment

This document explains the Continuous Integration and Continuous Deployment (CI/CD) setup for the Memorix AI documentation.

## Overview

The documentation uses GitHub Actions for automated testing, building, and deployment. The CI/CD pipeline ensures that:

- All changes are tested before deployment
- Documentation is automatically built and deployed
- Preview environments are created for pull requests
- Dependencies are kept up to date

## Workflows

### 1. Test Documentation (`.github/workflows/test.yml`)

**Triggers:**
- Push to `main`, `master`, or `develop` branches
- Pull requests to `main` or `master`

**What it does:**
- Installs Python dependencies
- Builds the documentation
- Validates markdown files
- Checks for broken links
- Ensures file structure is correct
- Validates MkDocs configuration

### 2. Deploy Documentation (`.github/workflows/deploy.yml`)

**Triggers:**
- Push to `main` or `master` branches
- Pull requests to `main` or `master`

**What it does:**
- Builds the documentation
- Deploys to GitHub Pages (only on main/master)
- Creates deployment artifacts

### 3. Preview Documentation (`.github/workflows/preview.yml`)

**Triggers:**
- Pull requests to `main` or `master`

**What it does:**
- Creates a preview deployment
- Comments on the PR with the preview URL
- Allows reviewers to see changes before merging

### 4. Dependabot Auto-merge (`.github/workflows/dependabot.yml`)

**Triggers:**
- Pull requests from Dependabot

**What it does:**
- Automatically merges patch updates
- Runs tests for minor/major updates
- Ensures dependency updates are safe

## Deployment Process

### Automatic Deployment

1. **Push to main branch** → Triggers build and deploy
2. **GitHub Actions builds** → Documentation using MkDocs
3. **Deploy to GitHub Pages** → Site goes live at `https://memorix-ai.github.io/memorix-docs/`

### Manual Deployment

You can also deploy manually using the provided script:

```bash
# Build and deploy
./deploy.sh

# Or use MkDocs directly
mkdocs build
mkdocs gh-deploy
```

## Environment Setup

### Required GitHub Settings

1. **Enable GitHub Pages:**
   - Go to Settings → Pages
   - Source: "GitHub Actions"
   - Branch: Leave empty (handled by workflow)

2. **Enable GitHub Actions:**
   - Go to Settings → Actions → General
   - Allow all actions and reusable workflows

3. **Set up permissions:**
   - Go to Settings → Actions → General
   - Enable "Read and write permissions"
   - Enable "Allow GitHub Actions to create and approve pull requests"

### Required Secrets

No additional secrets are required for basic deployment. The workflows use the default `GITHUB_TOKEN`.

## Monitoring and Troubleshooting

### Check Workflow Status

1. Go to the **Actions** tab in your repository
2. View the status of recent workflow runs
3. Click on a workflow to see detailed logs

### Common Issues

#### Build Failures

```bash
# Check locally
mkdocs build

# Check configuration
mkdocs config
```

#### Deployment Failures

1. Check GitHub Pages settings
2. Verify repository permissions
3. Check workflow logs for specific errors

#### Preview Not Working

1. Ensure the preview workflow is enabled
2. Check that the PR is targeting the correct branch
3. Verify GitHub Pages is configured correctly

## Best Practices

### For Contributors

1. **Always test locally:**
   ```bash
   mkdocs serve
   ```

2. **Check your changes:**
   - Validate markdown syntax
   - Test internal links
   - Ensure images are properly referenced

3. **Use descriptive commit messages:**
   ```bash
   git commit -m "docs: add new API reference section"
   ```

### For Maintainers

1. **Review PRs thoroughly:**
   - Check the preview deployment
   - Validate all links work
   - Ensure consistent formatting

2. **Monitor dependency updates:**
   - Review Dependabot PRs
   - Test major version updates
   - Keep dependencies current

3. **Regular maintenance:**
   - Update MkDocs and themes
   - Review and update documentation
   - Monitor workflow performance

## Customization

### Adding New Workflows

To add a new workflow:

1. Create a new `.yml` file in `.github/workflows/`
2. Define triggers and jobs
3. Test locally using `act` (optional)

### Modifying Existing Workflows

1. Edit the workflow file
2. Test changes in a branch
3. Create a PR to merge changes

### Environment Variables

You can add environment variables in the workflow files:

```yaml
env:
  CUSTOM_VAR: "value"
```

## Security

### Permissions

The workflows use minimal required permissions:
- `contents: read` - Read repository content
- `pages: write` - Deploy to GitHub Pages
- `id-token: write` - Generate deployment tokens

### Dependencies

All dependencies are pinned to specific versions in `requirements.txt` to ensure reproducible builds.

## Support

If you encounter issues with the CI/CD setup:

1. Check the [GitHub Actions documentation](https://docs.github.com/en/actions)
2. Review workflow logs for specific errors
3. Create an issue in the repository
4. Contact the maintainers

## Related Documentation

- [Contributing Guide](contributing.md)
- [Installation Guide](install.md)
- [API Reference](api/memory_api.md) 