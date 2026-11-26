class Rogue34 < Formula
  desc "Reconstructed Rogue 3.4 with Japanese/English and modern terminal support"
  homepage "https://github.com/leopard-gecko/rogue_3.4_jec"
  url "https://github.com/leopard-gecko/rogue_3.4_jec/releases/download/v002/rogue_3.4_jec-002.tar.gz"
  version "3.4.002"
  sha256 "a21ac4979f5b734e2b6c863527684c35aa7b91b68de5e6c6a3878a0374989b39"

  def install
    system "make", "-C", "src", "install", "PREFIX=#{prefix}", "PROG=rogue34"
  end

  test do
    system "#{bin}/rogue34", "-s"
  end
end
