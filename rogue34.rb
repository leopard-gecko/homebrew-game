class Rogue34 < Formula
  desc "Reconstructed Rogue 3.4 with Japanese/English and modern terminal support"
  homepage "https://github.com/leopard-gecko/rogue_3.4_jec"
  url "https://github.com/leopard-gecko/rogue_3.4_jec/releases/download/v002/rogue_3.4_jec-002.tar.gz"
  version "3.4.002"
  sha256 "15c7f40ccfaf2c4c27c7f14e689c3a3b4f6584763eddf7fc35b8e0321f5ab4ca"

  def install
    system "make", "-C", "src", "install", "PREFIX=#{prefix}", "PROG=rogue34"
  end

  test do
    system "#{bin}/rogue34", "-s"
  end
end
