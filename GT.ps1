# -----------------------------
# GhostTypist.ps1
# -----------------------------

# ---- 1. Single instance ----
$mutexName = "Global\GhostTypistMutex"
$createdNew = $false
$mutex = New-Object System.Threading.Mutex($true, $mutexName, [ref]$createdNew)
if (-not $createdNew) { exit }

# ---- 2. Load SendKeys ----
Add-Type -AssemblyName System.Windows.Forms

# ---- 3. Sentences ----
$Sentences = @(
    "still working...",
    "hmm...",
    "wait a second",
    "typing something",
    "brb",
    "ok",
    "what was that",
    "continuing...",
    "note to self",
    "interesting"
)

# ---- 4. CONFIG ----
$MinDelay = 3
$MaxDelay = 10
$CharDelayMs = 5

# ---- 5. Typing function ----
function Send-FastText($text) {
    foreach ($ch in $text.ToCharArray()) {
        [System.Windows.Forms.SendKeys]::SendWait($ch)
        Start-Sleep -Milliseconds $CharDelayMs
    }
}

# ---- 6. Main loop ----
while ($true) {
    $wait = Get-Random -Minimum $MinDelay -Maximum $MaxDelay
    Start-Sleep -Seconds $wait

    $text = Get-Random -InputObject $Sentences

    try {
        Send-FastText $text
        [System.Windows.Forms.SendKeys]::SendWait("{ENTER}")
    } catch {
        # ignore and continue
    }
}
