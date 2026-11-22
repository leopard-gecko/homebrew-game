class RogueDos < Formula
  desc "DOS Rogue 1.48 tribute with Japanese/English and color support"
  homepage "https://github.com/leopard-gecko/rogue_dos_tribute"
  url "https://github.com/leopard-gecko/rogue_dos_tribute/releases/download/v091/rogue_dos_tribute-091.tar.gz"
  version "dos-1.4.8.jec.091"
  sha256 "17a34d7807f316919ec6e45b9c94ad67c94918dcdbfa769d65061b915a391c0d"

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
