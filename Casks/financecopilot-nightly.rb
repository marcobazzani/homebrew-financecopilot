cask "financecopilot-nightly" do
  version "nightly-2fd035a"
  sha256 :no_check

  url "https://github.com/marcobazzani/FinanceCopilot/releases/download/latest/FinanceCopilot-macos.dmg"
  name "FinanceCopilot (Nightly)"
  desc "Personal wealth management desktop app — nightly build from main"
  homepage "https://github.com/marcobazzani/FinanceCopilot"

  app "FinanceCopilot.app"

  zap trash: [
    "~/Library/Application Support/net.bazzani.financecopilot",
  ]
end
