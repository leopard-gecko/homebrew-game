class RogueC3 < Formula
  desc "Rogue Clone III with Japanese, color, and macOS fixes"
  homepage "https://leopard-gecko.github.io/jrogue/"
  url "https://github.com/leopard-gecko/rogue_clone_iii_jec/releases/download/v005/rogue-clone-iii-005-src.tar.gz"
  version "clone-iii.jec.005"
  sha256 "8ad83efac94b71db440ca1521fc0e384640dda50175f8ca9ae65088c98ab126a"

  def install
    args = %W[
      --prefix=#{prefix}
      --program=rogue-c3
      --docdir=#{share}/doc/rogue-c3
      --save-file=rogue-clone.save
      --score-file=rogue-clone.scores
      --lock-file=rogue-clone.lock
    ]

    system "./configure", *args
    system "make", "install"
  end

  test do
    system "#{bin}/rogue-c3", "-s"
  end
end
