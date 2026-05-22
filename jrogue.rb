class Jrogue < Formula
  homepage "https://leopard-gecko.github.io/jrogue/"
  url "https://github.com/leopard-gecko/homebrew-game/releases/download/v5.4.5J.043/jrogue043.tar.gz"
  version "5.4.5J.043"
  sha256 "94860183a12070c0466f3093dbb320f61130f3dce6fbd74198e2bc50a3414d1d"

  def install
    args = %W[
      --prefix=#{prefix}
      --mandir=/usr/local/share/man/ja/man6
    ]
    
    system "./configure", *args
    system "make", "install"
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! It's enough to just replace
    # "false" with the main program this formula installs, but it'd be nice if you
    # were more thorough. Run the test with `brew test libhoge`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "#{bin}/jrogue"
  end
end
