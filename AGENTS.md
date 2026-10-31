# UnifiedG Project Rules & Unified Remote Architecture

## 1. Operating Rules & Constraints
- **Mandatory Feature Branching:** ALWAYS create and switch to a dedicated feature branch (`feat/<name>`, `fix/<name>`, `docs/<name>`, `refactor/<name>`) before making changes. NEVER commit directly to `master` or `main`.
- **Mandatory Documentation Reconciliation:** ALWAYS reconcile and keep all documentation (`AGENTS.md`, skills under `.agents/skills/`, `README.md`, and any project docs) 100% up-to-date whenever making architectural, naming, or code changes. There are to be NO OUTDATED docs anywhere in this project.
- **Zero-Test Constraint:** Do NOT create test files or execute test suites. Use static analysis only.
- **Static Syntax Validation:** Validate all Lua files via LuaJIT compiler (`loadfile`) and all XML files via `[xml]`.
- **Lua Execution Safety & Host Protection:** NEVER execute, call, or dynamically test Lua functions or action handlers (`actions.<name>()`) on the host machine. Remote scripts interface directly with Windows OS APIs and CLI commands (`shutdown.exe`, `rundll32.exe`, `PowrProf.SetSuspendState`, `user32.LockWorkStation`, volume keystrokes). Executing them will trigger live host side-effects: shutting down the developer's computer, locking the screen, muting or altering audio volume, or disrupting active applications. All Lua verification must remain strictly static (`loadfile` bytecode compilation check only).
- **Environment Isolation:** Do NOT touch running processes, Unified Remote instances, or external directories (`%APPDATA%`, `%PROGRAMDATA%`). All operations must remain strictly inside this workspace.
- **Path Hygiene & Public Repo Standards:** Do NOT reference files outside the repository. Do NOT use hardcoded absolute paths specific to any developer's local machine (such as developer home directories or local drive roots). All paths must be relative or standard environment variables (`%APPDATA%`, `~/`).
- **Git Discipline:** Commit locally on dedicated feature branches with Conventional Commits (`feat:`, `refactor:`, `fix:`, `docs:`, `chore:`). NEVER commit directly to `master` or `main`. Do NOT push to remote repositories or open PRs unless explicitly instructed.
- **Custom Keybindings Authority:** `context/input.conf` contains the custom MPV.NET keybindings. It must remain 100% byte-for-byte identical (never edit or reformat it).

## 2. Unified Remote Specification Constraints
- **Canonical Remote Inventory & Standards:**
  - All remotes are authored by `g` (`meta.author: g`).
  - Legacy identifiers (`gbyn`, `SuperTimer`, `Pro`) are strictly prohibited across all remotes and documentation.
  - `gMPV`: Classic single-tab MPV / MPV.NET media remote (`meta.tags.category: media`).
  - `gMPV v2`: Advanced 4-tab MPV.NET media remote with audio/sub sync, speed scaling, and OSD tools (`meta.tags.category: media`).
  - `gSleepTimer`: Classic grid-based Windows shutdown timer (`meta.tags.category: utility`).
  - `gSleepTimer v2`: Smart Windows power manager with live countdown, progress bar, custom dialog, and sleep/hibernate (`meta.tags.category: utility`).
- **`meta.prop`:**
  - Standard keys: `meta.name`, `meta.author: g`, `meta.description`, `meta.platform: windows`, `meta.tags.category: media|utility`.
  - NEVER use `meta.version` or `meta.id`: Omit `meta.version` entirely across all remotes to avoid .NET integer parsing exceptions (`FormatException`). NEVER use `meta.id` (directory name is the remote ID).
- **`layout.xml`:**
  - Control element `color="..."` strictly accepts named colors: `red`, `grey`, `blue`, `green`, `orange`, `purple`, `pink`, `yellow`, `transparent`.
  - Never pass hex (`#hex`) to `color` on controls. Use `lightcolor` and `darkcolor` on `<layout>`.
  - Official icon names: `vmute` (NOT `mute`), `vup`, `vdown`, `playpause`, `fullscreen`, etc.
  - Tab titles: Use `and` instead of `&` or `&amp;`.
- **`remote.lua`:**
  - Helper functions must be chunk-scoped: `function helper ()`. NEVER use `local function`.
  - Action formatting: `actions.<name> = function ()` with space before `()` and statement semicolons (`;`).
  - Actions must have `--@help <Description>` annotations.
  - When calling Windows shutdown, always prepend `shutdown -a` to avoid Error 1190.
  - In FFI, `user32` functions (`LockWorkStation`) reside in `ffi.C`, while power states (`SetSuspendState` for sleep/hibernate) are loaded via `ffi.load("PowrProf")`. Always wrap FFI in `pcall` with CLI fallbacks (`rundll32.exe`, `shutdown.exe`).
  - **Runtime Execution Hazard:** Never call action functions in test scripts, harnesses, or subagent tasks. Doing so triggers real system actions (power off, lock, mute).

## 3. Workflow & Orchestration
- Use a multi-agent workflow: Orchestrator coordinates phases on dedicated feature branches, Worker implements & checks, and Dual Reviewers (Quality/Spec Reviewer + Adversarial Reviewer) perform independent reviews before converging on semantic commits. Never commit directly to `master` or `main`.
- Dual reviewers must enforce documentation reconciliation: no PR or milestone convergence is allowed if documentation (`README.md`, `AGENTS.md`, skill files) is lagging behind code changes.
- Refer to the `unified-remote-dev` skill (`.agents/skills/unified-remote-dev/SKILL.md`) for full API and syntax details.

## 4. Authoritative Knowledge Sources & Reference Repositories
- **Unified Remote Documentation:** [https://github.com/unifiedremote/Docs](https://github.com/unifiedremote/Docs) — Complete API documentation, architecture concepts (`concepts/metadata.md`, `concepts/layout.md`, `concepts/remote.md`, `concepts/cross-platform.md`), control specifications (`controls/button.md`, `controls/styling.md`, `controls/tabs.md`, `controls/slider.md`, `controls/dialogs.md`), and library references (`libs/keyboard.md`, `libs/script.md`, `libs/ffi.md`, `libs/device.md`, `libs/timer.md`, `libs/server.md`).
- **Official Remotes Repository:** [https://github.com/unifiedremote/Remotes](https://github.com/unifiedremote/Remotes) — Canonical reference implementations of production remotes (`Main/MPC-HC`, `Main/VLC`, `Main/Power`, `Main/Volume`, etc.).
- **Unified Remote GitHub Organization:** [https://github.com/unifiedremote](https://github.com/unifiedremote) — Root ecosystem including community remotes and test suites (`unifiedremote/Test-Remotes`).
