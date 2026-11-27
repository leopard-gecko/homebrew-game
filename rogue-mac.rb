class RogueMac < Formula
  desc "Terminal launcher for six Rogue editions with shared GUI preferences"
  homepage "https://leopard-gecko.github.io/jrogue/"
  url "https://github.com/leopard-gecko/homebrew-game/releases/download/vrogue-mac.031/rogue-mac-031.tar.gz"
  version "0.3.28"
  sha256 "c69fdc5b50e6b1c8f1276ae4f1aaa6e0a8ed452dfaa70317c26c98c2a53eed11"

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
    assert_match "rogue-mac 0.3.28", shell_output("#{bin}/rogue-mac --version")
  end
end
