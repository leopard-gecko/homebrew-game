class RogueC3 < Formula
  desc "Rogue Clone III with Japanese, color, and macOS fixes"
  homepage "https://leopard-gecko.github.io/jrogue/"
  url "https://github.com/leopard-gecko/rogue_clone_iii_jec/releases/download/v004/rogue_clone_iii_jec-004.tar.gz"
  version "clone-iii.jec.004"
  sha256 "4b4889344c691192468917641c2d8775243c8a34e98aae2913fcd5f26951dec0"

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
