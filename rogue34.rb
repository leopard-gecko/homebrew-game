class Rogue34 < Formula
  desc "Reconstructed Rogue 3.4 with Japanese/English and modern terminal support"
  homepage "https://github.com/leopard-gecko/rogue_3.4_jec"
  url "https://github.com/leopard-gecko/rogue_3.4_jec/releases/download/v003/rogue_3.4_jec-003.tar.gz"
  version "3.4.003"
  sha256 "6ccac8fdf06b86d01747d4d75766b2c08ba80a8a9d2e0c9b7ec2b3b83665ea42"

  def install
    system "make", "-C", "src", "install", "PREFIX=#{prefix}", "PROG=rogue34"
  end

  test do
    system "#{bin}/rogue34", "-s"
  end
end
