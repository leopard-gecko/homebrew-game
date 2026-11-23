class Rogue36 < Formula
  desc "Rogue 3.6 with Japanese/English and modern terminal support"
  homepage "https://github.com/leopard-gecko/rogue_3.6_jec"
  url "https://github.com/leopard-gecko/rogue_3.6_jec/releases/download/v006/rogue36_006-src.tar.gz"
  version "3.6.006"
  sha256 "b47293c34854b69cb9b59aaeada921a0422ec184a3d2c5f320144c9a3eed8f9e"

  def install
    system "./configure", "--prefix=#{prefix}", "--program=rogue36"
    system "make", "install"

    doc.install Dir["README*.md", "rogue_*.txt", "rogue_*.html", "LICENSE*"]
  end

  test do
    system "#{bin}/rogue36", "-s"
  end
end
