class RogueDos < Formula
  desc "DOS Rogue 1.48 tribute with Japanese/English and color support"
  homepage "https://github.com/leopard-gecko/rogue_dos_tribute"
  url "https://github.com/leopard-gecko/rogue_dos_tribute/releases/download/v091/rogue_dos_tribute-091.tar.gz"
  version "dos-1.4.8.jec.091"
  sha256 "e2bc45d02e9e9f5a146b7813d7cab804ef8ce45438e90a0f8c211cc570ec5101"

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
