cask "financecopilot-nightly" do
  version "nightly-b0e7706"
  sha256 :no_check

  url "https://github.com/marcobazzani/FinanceCopilot/releases/download/latest/FinanceCopilot-macos.dmg"
  name "FinanceCopilot (Nightly)"
  desc "Personal wealth management desktop app — nightly build from main"
  homepage "https://github.com/marcobazzani/FinanceCopilot"

  app "FinanceCopilot.app"

  # Re-copy App.framework binary from staged DMG if endpoint security stripped it
  postflight do
    app_binary = "#{appdir}/FinanceCopilot.app/Contents/Frameworks/App.framework/Versions/A/App"
    staged_binary = "#{staged_path}/FinanceCopilot.app/Contents/Frameworks/App.framework/Versions/A/App"
    unless File.exist?(app_binary)
      if File.exist?(staged_binary)
        system_command "/bin/cp", args: [staged_binary, app_binary]
      end
    end
  end

  zap trash: [
    "~/Library/Application Support/com.example.assetManager",
  ]
end
