class JrogueWizard < Formula
  desc "Rogue 5.4.5 with wizard mode, color, and macOS fixes"
  homepage "https://leopard-gecko.github.io/jrogue/"
  url "https://github.com/leopard-gecko/homebrew-game/releases/download/v5.4.5.jec.055/rogue_545_jec_055.tar.gz"
  version "5.4.5jec.055"
  sha256 "c95bfe4519826c336e0ea3f1bec5a0a4d04b2ee810806caee83f82634f4e1746"

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
