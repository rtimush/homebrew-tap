class HaskellIdeEngine < Formula
  desc "Haskell IDE Engine"
  homepage "https://github.com/haskell/haskell-ide-engine"

  url "https://github.com/haskell/haskell-ide-engine.git",
    :tag => "0.8.0.0",
    :revision => "d96119645c12905858468a98429f6a887330e7d9"

  depends_on "haskell-stack" => :build

  @@ghc_versions = {
    "8.6.4" => "62e7a420016e4ddd8a10b21638f3d3cd1edff81c33761217d2b6e7e86200ba98",
  }

  @@ghc_versions.each do |version, hash|
    resource "ghc-#{version}" do
      url "https://github.com/commercialhaskell/ghc/releases/download/ghc-#{version}-release/ghc-#{version}-x86_64-apple-darwin.tar.bz2"
      sha256 hash
    end
  end

  def install
    programs = buildpath/".brew_home"/".stack"/"programs"/"x86_64-osx"
    mkdir_p programs

    @@ghc_versions.each_key do |ghc|
      ghc_bin = resource("ghc-#{ghc}")
      ghc_bin.verify_download_integrity(ghc_bin.fetch)
      cp ghc_bin.cached_download, programs/"ghc-#{ghc}.tar.bz2"
      system "stack",
             "--no-terminal",
             "--jobs=#{ENV.make_jobs}",
             "--local-bin-path=#{bin}",
             "--extra-lib-dirs=#{HOMEBREW_PREFIX}/opt/icu4c/lib",
             "--extra-include-dirs=#{HOMEBREW_PREFIX}/opt/icu4c/include",
             "--stack-yaml=stack-#{ghc}.yaml",
             "install"
      mv bin/"hie", bin/"hie-#{ghc}"
    end
  end
end
