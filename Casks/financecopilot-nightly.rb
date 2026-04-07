cask "financecopilot-nightly" do
  version "nightly-b0e7706"
  sha256 :no_check

  url "https://github.com/marcobazzani/FinanceCopilot/releases/download/latest/FinanceCopilot-macos.dmg"
  name "FinanceCopilot (Nightly)"
  desc "Personal wealth management desktop app — nightly build from main"
  homepage "https://github.com/marcobazzani/FinanceCopilot"

  app "FinanceCopilot.app"

  # Recover binaries stripped by endpoint security (e.g. CrowdStrike) during extraction.
  # Re-mount the cached DMG (read-only) and copy missing framework binaries.
  postflight do
    system_command "/bin/bash", args: ["-c", <<~SH]
      APP="#{appdir}/FinanceCopilot.app/Contents/Frameworks/App.framework/Versions/A/App"
      if [ ! -f "$APP" ]; then
        DMG=$(ls ~/Library/Caches/Homebrew/downloads/*FinanceCopilot-macos.dmg 2>/dev/null | head -1)
        if [ -n "$DMG" ]; then
          hdiutil attach "$DMG" -nobrowse -readonly -mountpoint /tmp/fc_dmg_mount >/dev/null 2>&1
          if [ -f "/tmp/fc_dmg_mount/FinanceCopilot.app/Contents/Frameworks/App.framework/Versions/A/App" ]; then
            cp "/tmp/fc_dmg_mount/FinanceCopilot.app/Contents/Frameworks/App.framework/Versions/A/App" "$APP"
          fi
          hdiutil detach /tmp/fc_dmg_mount >/dev/null 2>&1
        fi
      fi
    SH
  end

  zap trash: [
    "~/Library/Application Support/com.example.assetManager",
  ]
end
