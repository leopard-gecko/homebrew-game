class JrogueWizard < Formula
  desc "Rogue 5.4.5 with wizard mode, color, and macOS fixes"
  homepage "https://leopard-gecko.github.io/jrogue/"
  url "https://github.com/leopard-gecko/homebrew-game/releases/download/v5.4.5.jec.051/rogue_545_jec_051.tar.gz"
  version "5.4.5jec.051"
  sha256 "c2e6f71f5f30bd37706f8657a6404a7f09bae7d12fd51830d3329f60b0973cdc"

  def install
    args = %W[
      --prefix=#{prefix}
      --program=jrogue-wizard
      --docdir=#{share}/doc/jrogue
      --save-file=rogue.save
      --score-file=rogue.scr
      --lock-file=rogue.lck
      --wizard
    ]

    system "./configure", *args
    system "make", "install"
  end

  test do
    system "#{bin}/jrogue-wizard", "-s"
  end
end
