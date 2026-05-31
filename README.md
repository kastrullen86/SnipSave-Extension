# SnipSave Extension v1.0.0

An elegant, zero-overhead open-source extension that seamlessly coexists with the native Windows Snipping Tool (`Win` + `Shift` + `S`) to inject on-demand saving pipelines directly into your production workflow.

## 👁️ Vision

Built for developers and power users who heavily rely on copying snippets to clipboards for communications, but occasionally need to save specific crops locally without fracturing their workflow.

SnipSave adds an ultra-minimalist, Fluent-designed `[✓] Save File?` checkbox right next to the Windows top clipping menu. It dynamically tracks your selections, manages system memory thresholds, and terminates itself completely after file output to maintain a **0% idle system resource footprint**.

## ✨ Key Technical Architecture

- **Native Symbiosis:** Dynamically queries Windows handle hooks (`ScreenClippingWindow`) to bind visually to the OS overlay frame.
- **On-Demand Lifecycle:** 0MB RAM idle overhead. The script initiates instantaneously via hotkey parameters, resolves tasks, and triggers garbage collection hooks immediately upon mouse release.
- **DPI Aware Positioning:** Programmatically handles multi-monitor environments and varying window scaling metrics.

## 🚀 Installation & Deployment

### Prerequisites

- [AutoHotkey v2.0+](https://autohotkey.com) installed on your host system.

### Automated Setup

1. Clone the repository locally:

    ```bash
      git clone https://github.com/kastrullen86/SnipSave-Extension.git
      ```

2. Navigate into the folder directory and execute `install.bat`.
3. The script will automatically resolve system pathing and map your global hotkey trigger to **`Ctrl + Shift + S`**.
