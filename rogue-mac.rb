class RogueMac < Formula
  desc "Rogue for macOS CUI launcher with five bundled game dependencies"
  homepage "https://leopard-gecko.github.io/jrogue/"
  url "https://github.com/leopard-gecko/homebrew-game/releases/download/vrogue-mac.001/rogue-mac-001.tar.gz"
  version "0.1.0"
  sha256 "2a3d0f24ac93bb53a0f1a09e4d909651f4a0276770b754ccf209a71b11416ced"

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
    assert_match "rogue-mac 0.1.0", shell_output("#{bin}/rogue-mac --version")
  end
end
