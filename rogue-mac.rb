class RogueMac < Formula
  desc "Terminal launcher for six Rogue editions with shared GUI preferences"
  homepage "https://leopard-gecko.github.io/jrogue/"
  url "https://github.com/leopard-gecko/homebrew-game/releases/download/vrogue-mac.033/rogue-mac-033.tar.gz"
  version "0.3.30"
  sha256 "342c07a393fb71ab5356f230e128fbae06b8c101bcbd057ec17c4f3859bc2fb7"

  depends_on :macos
  depends_on "leopard-gecko/game/rogue54"
  depends_on "leopard-gecko/game/rogue-c3"
  depends_on "leopard-gecko/game/rogue-dos"
  depends_on "leopard-gecko/game/rogue36"
  depends_on "leopard-gecko/game/rogue52"
  depends_on "leopard-gecko/game/rogue34"

  def install
    bin.install "rogue-mac"
    libexec.install "rogue-crt-tab.applescript"
    doc.install "README_rogue-mac.md", "README_rogue-mac_ja.md"
  end

  test do
    assert_match "Rogue for macOS", shell_output("#{bin}/rogue-mac --help")
    assert_match "rogue-mac 0.3.30", shell_output("#{bin}/rogue-mac --version")
  end
end
