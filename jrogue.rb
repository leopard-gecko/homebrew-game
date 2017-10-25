class Jrogue < Formula
  homepage "http://leopardgecko.zouri.jp/rogue.html"
  url "http://file.leopardgecko.blog.shinobi.jp/jrogue026.tar.gz"
  version "5.4.5J.026"
  sha256 "0fc5cd240ff99317c6bfd1ec2325630415e199ea3ac97665d08935e17e19b114"

  option "without-bg2black", "背景色を黒に変更しない"

  def install
    
    args << "--enable-bg2black=no" if build.without? "bg2black"
    args << "--mandir=/usr/local/share/man/ja/man6"
    args << "--prefix=#{prefix}"
    
    system "./configure", *args
    system "make", "install" # if this fails, try separate make/make install steps
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
