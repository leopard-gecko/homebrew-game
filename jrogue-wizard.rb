class JrogueWizard < Formula
  desc "Rogue 5.4.5 with wizard mode, color, and macOS fixes"
  homepage "https://leopard-gecko.github.io/jrogue/"
  url "https://github.com/leopard-gecko/homebrew-game/releases/download/v5.4.5.jec.056/rogue-5.4.5jec.056-src.tar.gz"
  version "5.4.5jec.056"
  sha256 "bd5e32e6ec024ab4d2d92b47d1f2665183f752d7230a2e6addc5236e9fa665f1"

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
