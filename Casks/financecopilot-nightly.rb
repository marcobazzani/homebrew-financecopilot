cask "financecopilot-nightly" do
  version "nightly-823cb32"
  sha256 :no_check

  url "https://github.com/marcobazzani/FinanceCopilot/releases/download/latest/FinanceCopilot-macos.dmg"
  name "FinanceCopilot (Nightly)"
  desc "Personal wealth management desktop app — nightly build from main"
  homepage "https://github.com/marcobazzani/FinanceCopilot"

  app "FinanceCopilot.app"

  # No postflight xattr — CI strips quarantine before DMG creation.
  # xattr on symlinked frameworks can corrupt binaries on some machines.

  zap trash: [
    "~/Library/Application Support/com.example.assetManager",
  ]
end
