class RogueMac < Formula
  desc "Terminal launcher for five Rogue games with shared GUI preferences"
  homepage "https://leopard-gecko.github.io/jrogue/"
  url "https://github.com/leopard-gecko/homebrew-game/releases/download/vrogue-mac.003/rogue-mac-003.tar.gz"
  version "0.3.0"
  sha256 "ab0a7be3c091043cc3aa32b02260204863f72d276dbf1590c0290615de8d7ea5"

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
    assert_match "rogue-mac 0.3.0", shell_output("#{bin}/rogue-mac --version")
  end
end
