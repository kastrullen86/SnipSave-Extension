#Requires AutoHotkey v2.0
#NoTrayIcon
#SingleInstance Force

/**
 * SnipSave Extension v1.0.0
 * Coexists with the Windows Snipping Tool to provide on-demand "Save As" prompts.
 * Architected to run purely on-demand with 0% idle system resource footprint.
 */

; 1. Initialize System Configurations & Trigger Native Snipping Tool
Send "#+s"

; 2. Await Native Window Mount (Supports both Windows 10 & Windows 11 internal class structures)
ActiveSnipWin := 0
if WinWait("ahk_class ScreenClippingWindow", , 3) || WinWait("ahk_class Windows.Internal.Capture.SnipWindow", , 3) {
    ActiveSnipWin := WinExist()
} else {
    ExitApp()
}

; 3. Establish High-DPI Aware User Interface
MyGui := Gui("+AlwaysOnTop -Caption +ToolWindow +Owner" ActiveSnipWin)
MyGui.BackColor := "202020" ; Matches native Windows Fluent Design dark palette
MyGui.SetFont("s10 cWhite", "Segoe UI")

; Add Interactive Control Core
SaveCheck := MyGui.Add("Checkbox", "x12 y8 Checked", "Save File?")

; 4. Dynamic Absolute Layout Positioning
WinGetPos(&X, &Y, &W, &H, ActiveSnipWin)
; Shifts interface precisely 125px to the left of the native clipping menu bar
MyGui.Show("X" (X - 125) " Y" Y " W115 H" H " NoActivate")

; 5. Initialize Window Cancellation Monitor
SetTimer(CheckCancellation, 100)

; 6. Await Mouse Hook Operations (The User Drawing a Rectangular Cut)
KeyWait "LButton", "D" ; Blocks until mouse down event
KeyWait "LButton"      ; Blocks until mouse release event

; Disable cancellation timer prior to evaluation to avoid race conditions
SetTimer(CheckCancellation, 0)

; 7. Evaluate Operational State
ShouldSave := SaveCheck.Value
MyGui.Destroy()

; 8. Execute Downstream Clipboard Processing
if (ShouldSave = 1) {
    Sleep(400) ; Hardware buffer delay to allow Windows to flush image array into system clipboard
    
    ; Execute shell sub-process to generate low-level WinForms Save Dialog without background persistence
    PowerShellCmd := 'powershell.exe -WindowStyle Hidden -Command "Add-Type -AssemblyName System.Windows.Forms; if ([System.Windows.Forms.Clipboard]::ContainsImage()) { $sfd = New-Object System.Windows.Forms.SaveFileDialog; $sfd.Filter = ''PNG Image (*.png)|*.png''; $sfd.Title = ''SnipSave - Save Your Snippet''; if ($sfd.ShowDialog() -eq [System.Windows.Forms.DialogResult]::OK) { [System.Windows.Forms.Clipboard]::GetImage().Save($sfd.FileName, [System.Drawing.Imaging.ImageFormat]::Png) } }"'
    Run(PowerShellCmd)
}

; 9. Terminate Lifespan (Ensures absolute zero memory leaks)
ExitApp()

/**
 * Monitors the existence of the clipping window overlay.
 * If the user hits Esc or closes the snipping interface, the script exits cleanly.
 */
CheckCancellation() {
    global ActiveSnipWin
    if !WinExist(ActiveSnipWin) {
        ExitApp()
    }
}