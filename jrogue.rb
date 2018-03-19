class Jrogue < Formula
  homepage "https://leopard-gecko.github.io/jrogue/"
  url "https://github.com/leopard-gecko/homebrew-game/releases/download/v5.4.5J.041/jrogue041.tar.gz"
  version "5.4.5J.041"
  sha256 "f17c7df1dbfcc01ddc92334c393d3421d174e42ea25802003133ecd69a22bd51"

  option "without-bg2black", "背景色を変更しない"
  option "without-invcursor", "プレイヤーの位置でカーソルを表示する"
  option "with-wizardmode", "ウィザードモードあり"

  def install
    args = %W[
      --prefix=#{prefix}
      --mandir=/usr/local/share/man/ja/man6
    ]
    
    args << "--enable-bg2black=no" if build.without? "bg2black"
    args << "--enable-invcursor=no" if build.without? "invcursor"
    args << "--enable-wizardmode" if build.with? "wizardmode"
    
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
