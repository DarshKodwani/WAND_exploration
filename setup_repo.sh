#!/bin/bash
set -euo pipefail

echo "INFO: Creating project directory structure..."
mkdir -p .gemini \
         code/download \
         code/preprocessing \
         code/analysis \
         data/raw \
         data/derivatives \
         notebooks

echo "INFO: Creating .gitignore to exclude large data files..."
cat <<'EOF' > .gitignore
# Ignore large binary files, which should be handled by git-annex
*.nii.gz
*.fif
*.ds
*.mat
*.dat
*.zip
*.tar

# IDE and OS-specific files
.vscode/
.idea/
*.swp
*~
.DS_Store
EOF

echo "INFO: Configuring Gemini to ignore data directories..."
cat <<'EOF' > .gemini/config.yaml
ignore:
  - "data/**"
  - "derivatives/**"
  - "**/*.nii.gz"
EOF

echo "INFO: Creating Gemini style guide..."
cat <<'EOF' > .gemini/styleguide.md
# Neuroimaging Style Guide
This document outlines the coding standards for the WAND project.
- Use snake_case for variables and functions.
- Follow PEP 8 guidelines for Python code.
- Document functions with NumPy-style docstrings.
EOF

echo "INFO: Creating persistent context file for Gemini (GEMINI.md)..."
cat <<'EOF' > GEMINI.md
# Project WAND: Gemini's Long-Term Memory

## 1. Technical Reference
- **Scanner:** Connectom 3T MRI
- **Gradient Strength:** 300 mT/m
- **Key Sequences:** AxCaliber, CHARMED
- **Other Modalities:** 7T MRI & MRS, MEG

## 2. State Tracker: Current Tasks
- [ ] Initialize repository structure (setup_repo.sh)
- [ ] Configure git-annex for the `data/` directory
- [ ] Populate `code/download/` with initial data acquisition scripts.

## 3. AI Development Guidelines
- **File Paths:** Always use the `pathlib` library in Python for creating and manipulating file system paths to ensure cross-platform compatibility.
- **Workflow Management:** Use `nipype` for constructing and executing neuroimaging pipelines. This promotes reproducibility and modularity.
EOF

echo "INFO: Creating Conda environment file..."
cat <<'EOF' > environment.yml
name: wand
channels:
  - conda-forge
  - defaults
dependencies:
  - python=3.10
  - numpy
  - pandas
  - jupyterlab
  - nipype
  - bids-validator
  - git-annex
EOF

echo "INFO: Creating placeholder README files..."
echo "# Project Overview" > README.md
echo "# Data Download Scripts" > code/download/README.md
echo "# Preprocessing Pipelines" > code/preprocessing/README.md
echo "# Analysis and Visualization" > code/analysis/README.md
echo "# Exploratory Notebooks" > notebooks/README.md

echo "INFO: Initializing Git repository..."
git init

echo "INFO: Initializing git-annex..."
(cd data && git annex init "Project WAND Data")

echo "INFO: Staging all created files..."
git add .

echo "INFO: Committing initial project structure..."
git commit -m "feat: Initialise WAND project structure

- Create directory layout for code, data, and notebooks.
- Add configuration files for Gemini (.gemini/config.yaml) and git (.gitignore).
- Initialize git and git-annex to manage the repository.
- Add placeholder READMEs, environment.yml, and GEMINI.md."

echo "SUCCESS: Repository setup complete."
echo "Next steps:"
echo "1. Run 'conda env create -f environment.yml' to set up the environment."
echo "2. Use 'git annex add <file>' and 'git commit' to track large data files."
echo "3. Use 'git annex get <file>' to retrieve data."
