cask "financecopilot-nightly" do
  version "nightly-823cb32"
  sha256 :no_check

  url "https://github.com/marcobazzani/FinanceCopilot/releases/download/latest/FinanceCopilot-macos.dmg"
  name "FinanceCopilot (Nightly)"
  desc "Personal wealth management desktop app — nightly build from main"
  homepage "https://github.com/marcobazzani/FinanceCopilot"

  preflight do
    # Remove quarantine BEFORE the app is moved to /Applications.
    # Gatekeeper on some machines strips unsigned Mach-O binaries during move if quarantined.
    system_command "/usr/bin/xattr",
                   args: ["-drs", "com.apple.quarantine", "#{staged_path}/FinanceCopilot.app"]
  end

  app "FinanceCopilot.app"

  zap trash: [
    "~/Library/Application Support/com.example.assetManager",
  ]
end
