cask "financecopilot" do
  version "0.3.6"
  sha256 :no_check

  url "https://github.com/marcobazzani/FinanceCopilot/releases/download/v#{version}/FinanceCopilot-macos.dmg"
  name "FinanceCopilot"
  desc "Personal wealth management desktop app"
  homepage "https://github.com/marcobazzani/FinanceCopilot"

  app "FinanceCopilot.app"

  # No postflight xattr — CI strips quarantine before DMG creation.
  # xattr on symlinked frameworks can corrupt binaries on some machines.

  zap trash: [
    "~/Library/Application Support/com.example.assetManager",
  ]
end
