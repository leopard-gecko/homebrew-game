class RogueDos < Formula
  desc "DOS Rogue 1.48 tribute with Japanese/English and color support"
  homepage "https://github.com/leopard-gecko/rogue_dos_tribute"
  url "https://github.com/leopard-gecko/rogue_dos_tribute/releases/download/v092/rogue_dos_tribute_jec092-src.tar.gz"
  version "dos-1.4.8.jec.092"
  sha256 "21b9441b06d7e87b1c979b268f557c0436a253287f507da6fc06372f594e87e6"

  def install
    args = %W[
      --prefix=#{prefix}
      --program=rogue-dos
      --docdir=#{share}/doc/rogue-dos
    ]

    system "./configure", *args
    system "make", "install"
  end

  test do
    system "#{bin}/rogue-dos", "-s"
  end
end
