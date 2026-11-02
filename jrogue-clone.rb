class JrogueClone < Formula
  desc "Rogue Clone III with Japanese, color, and macOS fixes"
  homepage "https://leopard-gecko.github.io/jrogue/"
  url "https://github.com/leopard-gecko/homebrew-game/releases/download/vclone-iii.jec.004/rogue_clone_iii_jec_004.tar.gz"
  version "clone-iii.jec.004"
  sha256 "61045be58c49a920c6b1ed9819e6c76bb1867dcd98906bfc445509e89e5dc0b4"

  def install
    args = %W[
      --prefix=#{prefix}
      --program=jrogue-clone
      --docdir=#{share}/doc/jrogue-clone
      --save-file=rogue-clone.save
      --score-file=rogue-clone.scores
      --lock-file=rogue-clone.lock
    ]

    system "./configure", *args
    system "make", "install"
  end

  test do
    system "#{bin}/jrogue-clone", "-s"
  end
end
