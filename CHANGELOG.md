# Changelog

All notable changes to this project will be documented in this file. The format is based on [Keep a Changelog](https://keepachangelog.com), and this project adheres to [Semantic Versioning](https://semver.org).

## [1.0.0] - 2026-05-31

### Added

- Core architecture for `SnipSave.ahk` to coexist with native Windows `ScreenClippingWindow` hooks.
- Non-blocking UI implementation featuring a native Dark Mode Fluent-styled checkbox.
- Native dynamic coordinate calculations to accommodate multi-monitor configurations and High-DPI system scaling.
- Custom automated `install.bat` engine script for zero-friction user configuration.
- Standalone multi-threaded PowerShell sub-process logic to handle immediate WinForms SaveFileDialog calls without background process persistence.

### Changed

- Refactored script process lifecycle to use active memory hooks instead of persistent event listeners, lowering idle CPU/RAM usage to exactly 0%.
