class RogueMac < Formula
  desc "Terminal launcher for six Rogue editions with shared GUI preferences"
  homepage "https://leopard-gecko.github.io/jrogue/"
  url "https://github.com/leopard-gecko/homebrew-game/releases/download/vrogue-mac.030/rogue-mac-030.tar.gz"
  version "0.3.27"
  sha256 "1b5908f6717677d62db4c86ac8780b88e7efbd3a8f48f2ea49d715f07d2a0118"

  depends_on :macos
  depends_on "leopard-gecko/game/rogue54"
  depends_on "leopard-gecko/game/rogue-c3"
  depends_on "leopard-gecko/game/rogue-dos"
  depends_on "leopard-gecko/game/rogue36"
  depends_on "leopard-gecko/game/rogue52"
  depends_on "leopard-gecko/game/rogue34"

  def install
    bin.install "rogue-mac"
    doc.install "README_rogue-mac.md", "README_rogue-mac_ja.md"
  end

  test do
    assert_match "Rogue for macOS", shell_output("#{bin}/rogue-mac --help")
    assert_match "rogue-mac 0.3.27", shell_output("#{bin}/rogue-mac --version")
  end
end
