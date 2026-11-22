class RogueMac < Formula
  desc "Terminal launcher for five Rogue games with shared GUI preferences"
  homepage "https://leopard-gecko.github.io/jrogue/"
  url "https://github.com/leopard-gecko/homebrew-game/releases/download/vrogue-mac.006/rogue-mac-006.tar.gz"
  version "0.3.3"
  sha256 "cc41684213a857e6859bee0490bc2cf512ac94dc80535380397052490d352482"

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
    assert_match "rogue-mac 0.3.3", shell_output("#{bin}/rogue-mac --version")
  end
end
