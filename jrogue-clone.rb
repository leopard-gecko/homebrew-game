class JrogueClone < Formula
  desc "Rogue Clone III with Japanese, color, and macOS fixes"
  homepage "https://leopard-gecko.github.io/jrogue/"
  url "https://github.com/leopard-gecko/homebrew-game/releases/download/vclone-iii.jec.001/rogue_clone_iii_jec_001.tar.gz"
  version "clone-iii.jec.001"
  sha256 "57ad9de8a0052c6d3ddfaaad18a207513ec0f92fb9fa13f64a8b4c53155985f0"

  def install
    args = %W[
      --prefix=#{prefix}
      --program=jrogue-clone
      --docdir=#{share}/doc/jrogue-clone
      --save-file=rogue-clone.save
      --score-file=rogue-clone.scores
      --lock-file=rogue-clone.lock
      --modern
    ]

    system "./configure", *args
    system "make", "install"
  end

  test do
    system "#{bin}/jrogue-clone", "-s"
  end
end
