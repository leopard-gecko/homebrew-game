class RogueMac < Formula
  desc "Terminal launcher for five Rogue games with shared GUI preferences"
  homepage "https://leopard-gecko.github.io/jrogue/"
  url "https://github.com/leopard-gecko/homebrew-game/releases/download/vrogue-mac.004/rogue-mac-004.tar.gz"
  version "0.3.1"
  sha256 "64a10cf0a8f59046210b0bd4cc09e5dc8a97a27590ed17780eb7afcf979f04ae"

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
    assert_match "rogue-mac 0.3.1", shell_output("#{bin}/rogue-mac --version")
  end
end
