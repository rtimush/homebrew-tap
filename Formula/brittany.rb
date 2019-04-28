require "language/haskell"

class Brittany < Formula
    include Language::Haskell::Cabal

    desc "Haskell source code formatter"
  bottle do
    root_url "https://dl.bintray.com/rtimush/bottles-tap"
    cellar :any_skip_relocation
    sha256 "deb64c1cba04782b1d706eec3e9a389f084f14eb16bdedd68266e12d795c25f0" => :mojave
    sha256 "e1481b772fc3d40c96a6379efd4a1801167b041e35a077a1d088cd58923f78c9" => :high_sierra
  end

    homepage "https://github.com/lspitzner/brittany"

    url "https://github.com/lspitzner/brittany/archive/0.11.0.0.x2.tar.gz"
    sha256 "7815237fdb847ba71c956e6838387d1d9de14db8a021ce29af39475a8255aeb1"
    version "0.11.0.0"

    head "https://github.com/lspitzner/brittany.git"

    depends_on "cabal-install" => :build
    depends_on "ghc@8.2" => :build

    def install
      install_cabal_package "brittany"
    end

    test do
      system "#{bin}/brittany", "--version"
    end
  end
