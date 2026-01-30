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
