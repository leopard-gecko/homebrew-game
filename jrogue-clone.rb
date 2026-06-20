class JrogueClone < Formula
  desc "Rogue Clone III with Japanese, color, and macOS fixes"
  homepage "https://leopard-gecko.github.io/jrogue/"
  url "https://github.com/leopard-gecko/homebrew-game/releases/download/vclone-iii.jec.001/rogue_clone_iii_jec_001.tar.gz"
  version "clone-iii.jec.001"
  sha256 "5beb8c8143845ae005c0edd3dd1adfcd45aa1e1d01edcf022512cba76132ec16"

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
