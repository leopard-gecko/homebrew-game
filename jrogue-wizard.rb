class JrogueWizard < Formula
  desc "Rogue 5.4.5 with wizard mode, color, and macOS fixes"
  homepage "https://leopard-gecko.github.io/jrogue/"
  url "https://github.com/leopard-gecko/homebrew-game/releases/download/v5.4.5.jec.051/rogue_545_jec_051.tar.gz"
  version "5.4.5jec.051"
  sha256 "74bcb15871641a4ceaa505cfba825feb9cb0ca6a36aaa617e5410533ec1d2346"

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
