# UnifiedG

A collection of custom, production-ready remotes for [Unified Remote](https://www.unifiedremote.com/), featuring streamlined controls for media playback and system power management.

---

## 📱 Remotes Included

### Media Remotes (MPV & MPV.NET)

| Remote | Description | Highlights |
| :--- | :--- | :--- |
| **`gMPV`** | Classic, lightweight MPV controller | Fast single-tab playback, playlist navigation, chapter stepping, volume up/down/mute, and seek intervals. |
| **`gMPV v2`** | Advanced multi-tab remote tuned for **MPV.NET** | 4-tab interface covering granular seeking (-5m to +5m), audio track cycling, subtitle delay & positioning, speed scaling (0.5x to 2.0x), aspect ratio cycling, frame stepping, and stream URL loading. |

### Power & Timer Remotes (Windows)

| Remote | Description | Highlights |
| :--- | :--- | :--- |
| **`gSleepTimer`** | Classic shutdown timer | Quick-access grid for scheduled shutdowns from 10 minutes to 4.5 hours with collision-free cancellation. |
| **`gSleepTimer v2`** | Smart power manager & live timer | Real-time countdown label (1-second tick), visual progress bar, instant increments (+5m, +15m, -5m), custom duration prompt dialog, and sleep / hibernate / workstation lock integration. |

---

## 🚀 Installation & Setup

### 1. Copy to Custom Remotes Directory

Copy the desired remote folders (`gMPV`, `gMPV v2`, `gSleepTimer`, `gSleepTimer v2`) into your Unified Remote **Custom Remotes** folder:

- **Windows:** `%APPDATA%\Unified Remote\Remotes\Custom\`
- **macOS:** `~/Library/Application Support/Unified Remote/Remotes/Custom/`
- **Linux:** `~/opt/urserver/remotes/custom/`

#### PowerShell Example (Windows):
```powershell
# Copy all remotes into your Unified Remote Custom folder:
Copy-Item -Recurse -Path "gMPV", "gMPV v2", "gSleepTimer", "gSleepTimer v2" -Destination "$env:APPDATA\Unified Remote\Remotes\Custom\"
```

### 2. Reload Server Remotes

1. Open your browser and navigate to the Unified Remote Web Manager: [http://localhost:9510/web](http://localhost:9510/web).
2. Go to **Settings** > **Remotes**.
3. Click **Reload** to refresh the remote catalog.
4. Open the Unified Remote app on your mobile device to start using them.

---

## 🛠️ Remote Details & Features

### 🎬 gMPV v2

Built specifically for power users running MPV / MPV.NET:
- **Tab 1: Playback**
  - Large Play/Pause, Stop, and Fullscreen toggle.
  - Playlist item navigation (`Prev File` / `Next File`).
  - Chapter navigation.
  - Granular seek pad: `-5m`, `-30s`, `-5s`, `+5s`, `+30s`, `+5m`.
  - Master volume controls and mute toggle.
- **Tab 2: Audio & Subs**
  - Cycle audio tracks and adjust audio delay (`-0.1s` / `+0.1s`).
  - Cycle subtitle tracks and toggle subtitle visibility.
  - Fine subtitle delay sync (`-0.1s` / `+0.1s`).
  - Move subtitle position up/down on-screen.
- **Tab 3: Video & Speed**
  - Playback speed scaling: `0.5x`, `-10%`, `1.0x` (reset), `+10%`, `2.0x`.
  - Aspect ratio toggle and deinterlacing switch.
  - Screenshot capture and on-screen statistics (OSD).
- **Tab 4: Tools & OSD**
  - Window focus trigger for MPV.NET.
  - A-B loop and infinite file loop toggles.
  - Precise frame-stepping (backward and forward).
  - Open URL dialog: prompts for a stream URL and sends it directly to the player.

### ⏱️ gSleepTimer v2

Modernized Windows power management remote:
- **Live Countdown & Progress Bar:** Updates every second with formatted remaining time (`Shutting down in 1h 15m 00s`) and visual progress percentage.
- **Quick Timer Presets:** `15m`, `30m`, `45m`, `1h`, `2h`, `3h`.
- **Delta Adjustments:** Add or subtract time on-the-fly (`-5m`, `+5m`, `+15m`) with safe minimum boundary clamps.
- **Custom Duration Input:** Dialog prompt allowing exact duration input in minutes (1 to 1440 minutes).
- **Extended Power Modes:** Immediate Sleep, Hibernate, System Restart, and Workstation Lock via native Windows APIs with automatic command-line fallbacks.
- **Collision Protection:** Automatically runs `shutdown -a` before scheduling new timeouts to prevent Windows Error 1190 (*"A system shutdown has already been scheduled"*).

---

## 📋 Technical Specifications & Compatibility

- **Server Compatibility:** Unified Remote Server v3.x on Windows.
- **Client Compatibility:** Unified Remote for Android and iOS.
- **Platform Architecture:**
  - Layouts defined with standard XML matching Unified Remote layout specifications.
  - Backend scripts written in Lua 5.1 / LuaJIT with defensive error handling (`pcall`).
  - Native Windows power features use LuaJIT FFI with CLI fallbacks (`rundll32.exe`, `shutdown.exe`).
- **Styling Standards:** Compliant with official named colors (`red`, `grey`, `blue`, etc.) and hex background support (`lightcolor` / `darkcolor`).

---

## 🤝 Contributing & Development Rules

Contributions must follow the project rules outlined in [`AGENTS.md`](./AGENTS.md):
- **Mandatory Feature Branching:** Always create a dedicated branch (`feat/<name>`, `fix/<name>`, `docs/<name>`). Never commit directly to `main` or `master`.
- **Zero-Test Constraint:** Do not create test files or execute test suites; use static syntax validation only.
- **Syntax Validation:** Verify Lua scripts via LuaJIT compiler (`loadfile`) and XML files via XML DOM parsers.
- **Git Discipline:** Use Conventional Commits (`feat:`, `fix:`, `refactor:`, `docs:`).

---

## 📄 License

Distributed under the MIT License (or as designated by the repository owner).
