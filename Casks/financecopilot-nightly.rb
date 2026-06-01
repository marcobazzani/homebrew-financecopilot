cask "financecopilot-nightly" do
  version "nightly-be1f6a7"
  sha256 :no_check

  url "https://github.com/marcobazzani/FinanceCopilot/releases/download/latest/FinanceCopilot-macos.dmg"
  name "FinanceCopilot (Nightly)"
  desc "Personal wealth management desktop app — nightly build from main"
  homepage "https://github.com/marcobazzani/FinanceCopilot"

  app "FinanceCopilot.app"

  # Strip the quarantine xattr so macOS doesn't translocate the app on
  # first launch (translocation runs quarantined ad-hoc-signed apps from
  # a random read-only mount, which renders the Flutter window flat
  # black). Notarization would be the canonical fix but requires a
  # paid Apple Developer ID; clearing the flag here avoids that.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine",
                          "#{appdir}/FinanceCopilot.app"]
  end

  # No zap stanza: the app is sandboxed and writes everything under
  # ~/Library/Containers/net.bazzani.financecopilot/. brew zap would
  # be a footgun against the user's own data.
end
