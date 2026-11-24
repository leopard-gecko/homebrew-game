class RogueMac < Formula
  desc "Terminal launcher for five Rogue games with shared GUI preferences"
  homepage "https://leopard-gecko.github.io/jrogue/"
  url "https://github.com/leopard-gecko/homebrew-game/releases/download/vrogue-mac.028/rogue-mac-028.tar.gz"
  version "0.3.25"
  sha256 "5b0260724a3f18d6e7e3df8488746cce73c5c6cb1148b050a4bb66cb799e6ca9"

  depends_on :macos
  depends_on "leopard-gecko/game/rogue54"
  depends_on "leopard-gecko/game/rogue-c3"
  depends_on "leopard-gecko/game/rogue-dos"
  depends_on "leopard-gecko/game/rogue36"
  depends_on "leopard-gecko/game/rogue52"

  def install
    bin.install "rogue-mac"
    doc.install "README_rogue-mac.md", "README_rogue-mac_ja.md"
  end

  test do
    assert_match "Rogue for macOS", shell_output("#{bin}/rogue-mac --help")
    assert_match "rogue-mac 0.3.25", shell_output("#{bin}/rogue-mac --version")
  end
end
