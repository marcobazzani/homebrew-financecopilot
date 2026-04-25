cask "financecopilot" do
  version "0.7.0"
  sha256 :no_check

  url "https://github.com/marcobazzani/FinanceCopilot/releases/download/v#{version}/FinanceCopilot-macos.dmg"
  name "FinanceCopilot"
  desc "Personal wealth management desktop app"
  homepage "https://github.com/marcobazzani/FinanceCopilot"

  app "FinanceCopilot.app"

  zap trash: [
    "~/Library/Application Support/net.bazzani.financecopilot",
  ]
end
