class Rogue34 < Formula
  desc "Reconstructed Rogue 3.4 with Japanese/English and modern terminal support"
  homepage "https://github.com/leopard-gecko/rogue_3.4_jec"
  url "https://github.com/leopard-gecko/rogue_3.4_jec/releases/download/v001/rogue_3.4_jec-001.tar.gz"
  version "3.4.001"
  sha256 "9e8d8fc5ba0efb115f8d4f7c32b2857ea92adef31d0bcc7214923c60c3999a9f"

  def install
    system "make", "-C", "src", "install", "PREFIX=#{prefix}", "PROG=rogue34"
  end

  test do
    system "#{bin}/rogue34", "-s"
  end
end
