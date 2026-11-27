class Rogue34 < Formula
  desc "Reconstructed Rogue 3.4 with Japanese/English and modern terminal support"
  homepage "https://github.com/leopard-gecko/rogue_3.4_jec"
  url "https://github.com/leopard-gecko/rogue_3.4_jec/releases/download/v002/rogue_3.4_jec-002.tar.gz"
  version "3.4.002"
  sha256 "553f2c217ecab7582eb334373419d698bb2551662851e79850313c63811fcb43"

  def install
    system "make", "-C", "src", "install", "PREFIX=#{prefix}", "PROG=rogue34"
  end

  test do
    system "#{bin}/rogue34", "-s"
  end
end
