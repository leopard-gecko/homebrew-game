class Jrogue < Formula
  homepage "http://leopardgecko.zouri.jp/rogue.html"
  url "http://file.leopardgecko.blog.shinobi.jp/jrogue027.tar.gz"
  version "5.4.5J.027"
  sha256 "bb321a574283df3689a49163a24227c6663e56729765b62948c3bf151e44833d"

  option "without-bg2black", "背景色を変更しない"
  option "without-nocursor", "カーソルを表示する"

  def install
    args = %W[
      --prefix=#{prefix}
      --mandir=/usr/local/share/man/ja/man6
    ]
    args << "--enable-bg2black=no" if build.without? "bg2black"
    args << "--enable-nocursor=no" if build.without? "nocursor"
    
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
