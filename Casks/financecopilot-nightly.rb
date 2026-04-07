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
    app_binary = "#{appdir}/FinanceCopilot.app/Contents/Frameworks/App.framework/Versions/A/App"
    unless File.exist?(app_binary)
      # Find the cached DMG
      dmg = Dir.glob(File.expand_path("~/Library/Caches/Homebrew/downloads/*FinanceCopilot-macos.dmg")).first
      if dmg
        system_command "/usr/bin/hdiutil", args: ["attach", dmg, "-nobrowse", "-readonly"]
        vol = Dir.glob("/Volumes/FinanceCopilot*").first
        if vol
          system_command "/bin/cp",
                         args: ["-R", "#{vol}/FinanceCopilot.app/Contents/Frameworks/App.framework/Versions/A/App", app_binary]
          system_command "/usr/bin/hdiutil", args: ["detach", vol]
        end
      end
    end
  end

  zap trash: [
    "~/Library/Application Support/com.example.assetManager",
  ]
end
