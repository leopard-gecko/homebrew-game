class JrogueWizard < Formula
  desc "Rogue 5.4.5 with wizard mode, color, and macOS fixes"
  homepage "https://leopard-gecko.github.io/jrogue/"
  url "https://github.com/leopard-gecko/homebrew-game/releases/download/v5.4.5.jec.056/rogue-5.4.5jec.056-src.tar.gz"
  version "5.4.5jec.056"
  sha256 "977126e7ff44fd55bd4ae6412c5498fd883b2462938a22f7b052a51bee6c72fc"

  def install
    args = %W[
      --prefix=#{prefix}
      --program=jrogue-wizard
      --docdir=#{share}/doc/jrogue
      --save-file=rogue.save
      --score-file=rogue.scr
      --wizard
    ]

    system "./configure", *args
    system "make", "install"
  end

  test do
    system "#{bin}/jrogue-wizard", "-s"
  end
end
