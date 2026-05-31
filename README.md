# SnipSave Extension v1.0.1

An elegant, zero-overhead open-source extension that seamlessly coexists with the native Windows Snipping Tool (`Win` + `Shift` + `S`) to inject on-demand saving pipelines directly into your production workflow.

## 👁️ Vision

Built for developers and power users who heavily rely on copying snippets to clipboards for communications, but occasionally need to save specific crops locally without fracturing their workflow.

SnipSave adds an ultra-minimalist, Fluent-designed `[✓] Save File?` checkbox right next to the Windows top clipping menu. It dynamically tracks your selections, manages system memory thresholds, and terminates itself completely after file output to maintain a **0% idle system resource footprint**.

## ✨ Key Technical Architecture

- **Native Symbiosis:** Dynamically queries Windows handle hooks (`ScreenClippingWindow`) to bind visually to the OS overlay frame.
- **On-Demand Lifecycle:** 0MB RAM idle overhead. The script initiates instantaneously via hotkey parameters, resolves tasks, and triggers garbage collection hooks immediately upon mouse release.
- **DPI Aware Positioning:** Programmatically handles multi-monitor environments and varying window scaling metrics.
- **Zero-Dependency Compilation:** Utilizes a portable AutoHotkey v2 extraction pipeline to guarantee deterministic binary generation across all Windows environments.

## 🚀 End-User Installation

1. Navigate to the **[Releases](../../releases/latest)** page of this repository.
2. Download the latest `SnipSave-vX.X.X-Windows.zip` archive and extract it.
3. Right-click and execute `install.bat`.
4. The script will automatically resolve system pathing and map your global hotkey trigger to **`Ctrl + Shift + S`**.

## 🛠️ Developer Compilation (Build from Source)

If you wish to compile the binary locally from the source code:

1. Clone the repository:

   ```bash
   git clone https://github.com/kastrullen86/SnipSave-Extension.git
   ```

2. Open a PowerShell terminal in the project root and execute the dependency fetcher. This will download the portable AutoHotkey v2 compiler without requiring administrative installation:

   ```powershell
   .\requirements.ps1
   ```

3. Execute the local compilation command:

   ```powershell
   .\compiler\Ahk2Exe.exe /in .\src\SnipSave.ahk /out .\dist\SnipSave.exe /icon .\src\SnipSave.ico /base ".\compiler\v2_portable\AutoHotkey64.exe"
   ```

## 📄 License & Copyright

This repository operates under a dual-license structure:

- **Source Code:** Distributed under the **MIT License**.
- **Visual Assets:** The custom icon (`SnipSave.ico`) is distributed under the **CC BY-NC 4.0 License**. It is free for personal and open-source use, but commercial monetization requires a separate profit-sharing agreement.

See `LICENSE` for full legal details.
