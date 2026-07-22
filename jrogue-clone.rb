class JrogueClone < Formula
  desc "Rogue Clone III with Japanese, color, and macOS fixes"
  homepage "https://leopard-gecko.github.io/jrogue/"
  url "https://github.com/leopard-gecko/homebrew-game/releases/download/vclone-iii.jec.002/rogue_clone_iii_jec_002.tar.gz"
  version "clone-iii.jec.002"
  sha256 "bfb9d6f6d1ca6274de7674b06a34878a54e075867c13c86e72af64e89745136f"

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
