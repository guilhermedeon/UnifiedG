# UnifiedG Project Rules & Unified Remote Architecture

## 1. Operating Rules & Constraints
- **Zero-Test Constraint:** Do NOT create test files or execute test suites. Use static analysis only.
- **Static Syntax Validation:** Validate all Lua files via LuaJIT compiler (`loadfile`) and all XML files via `[xml]`.
- **Environment Isolation:** Do NOT touch running processes, Unified Remote instances, or external directories (`%APPDATA%`, `%PROGRAMDATA%`). All operations must remain strictly inside this workspace.
- **Git Discipline:** Commit locally with Conventional Commits (`feat:`, `refactor:`, `fix:`). Do NOT push to remote repositories or open PRs unless explicitly instructed.
- **Custom Keybindings Authority:** `context/input.conf` contains the custom MPV.NET keybindings. It must remain 100% byte-for-byte identical (never edit or reformat it).

## 2. Unified Remote Specification Constraints
- **`meta.prop`:**
  - Standard keys: `meta.name`, `meta.author`, `meta.description`, `meta.platform: windows`, `meta.tags.category: media|utility`.
  - NEVER use `meta.version: 1.0/2.0` (it fails .NET integer parsing).
  - NEVER use `meta.id` (directory name is the remote ID).
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
  - In FFI, `user32` functions (`LockWorkStation`) reside in `ffi.C`. Wrap FFI in `pcall` with CLI fallbacks.

## 3. Workflow & Orchestration
- Use a multi-agent workflow: Orchestrator coordinates phases, Worker implements & checks, and Dual Reviewers (Quality/Spec Reviewer + Adversarial Reviewer) perform independent reviews before converging on semantic commits.
- Refer to the `unified-remote-dev` skill (`.agents/skills/unified-remote-dev/SKILL.md`) for full API and syntax details.

## 4. Authoritative Knowledge Sources & Reference Repositories
- **Unified Remote Documentation:** [https://github.com/unifiedremote/Docs](https://github.com/unifiedremote/Docs) — Complete API documentation, architecture concepts (`concepts/metadata.md`, `concepts/layout.md`, `concepts/remote.md`, `concepts/cross-platform.md`), control specifications (`controls/button.md`, `controls/styling.md`, `controls/tabs.md`, `controls/slider.md`, `controls/dialogs.md`), and library references (`libs/keyboard.md`, `libs/script.md`, `libs/ffi.md`, `libs/device.md`, `libs/timer.md`, `libs/server.md`).
- **Official Remotes Repository:** [https://github.com/unifiedremote/Remotes](https://github.com/unifiedremote/Remotes) — Canonical reference implementations of production remotes (`Main/MPC-HC`, `Main/VLC`, `Main/Power`, `Main/Volume`, etc.).
- **Unified Remote GitHub Organization:** [https://github.com/unifiedremote](https://github.com/unifiedremote) — Root ecosystem including community remotes and test suites (`unifiedremote/Test-Remotes`).
