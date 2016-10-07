require "formula"

class Mpfr < Formula
  homepage "http://www.mpfr.org/"
  # Upstream is down a lot, so use the GNU mirror + Gist for patches
  url "http://ftpmirror.gnu.org/mpfr/mpfr-3.1.5.tar.bz2"
  mirror "http://ftp.gnu.org/gnu/mpfr/mpfr-3.1.5.tar.bz2"
  sha1 "874e84bb5959fd5a19c032cfb5d673dded4b5cff"
  version "3.1.2-p8"

  bottle do
    cellar :any
    sha1 "ae9062f1736202e1e6324dbb74f6074d672708e8" => :mavericks
    sha1 "6f4e0967728cb9ff5fad9de53dc38eb1648eee8e" => :mountain_lion
    sha1 "63efa4c854ede1a352d73756d242514e042c8e2e" => :lion
  end

  depends_on "gmp"

  option "32-bit"

  fails_with :clang do
    build 421
    cause <<-EOS.undent
      clang build 421 segfaults while building in superenv;
      see https://github.com/Homebrew/homebrew/issues/15061
      EOS
  end

  def install
    ENV.m32 if build.build_32_bit?
    system "./configure", "--disable-dependency-tracking", "--prefix=#{prefix}"
    system "make"
    system "make check"
    system "make install"
  end
end
