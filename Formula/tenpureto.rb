class Tenpureto < Formula
  desc "Project templating tool"
  homepage "https://github.com/rtimush/tenpureto"

  url "https://github.com/rtimush/tenpureto/archive/v0.1.4.tar.gz"
  sha256 "f984a9ecb58b14824df8a3639f8b1cc190d3acb4a5f8ade3b01a923bc62814a2"

  head "https://github.com/rtimush/tenpureto.git"

  bottle do
    root_url "https://dl.bintray.com/rtimush/bottles-tap"
    cellar :any
    sha256 "52fbaca4ebf3d01ed89cafd552aede8e869fec7527f789a613e098f2ea4374ae" => :mojave
    sha256 "e83ad3a1a0c1afa6706faed0ffe3e00670bdb671b5bc4b1d613b91b595be1372" => :high_sierra
  end

  depends_on "haskell-stack" => :build
  depends_on "icu4c"

  resource "ghc" do
    url "https://github.com/commercialhaskell/ghc/releases/download/ghc-8.6.4-release/ghc-8.6.4-x86_64-apple-darwin.tar.bz2"
    sha256 "62e7a420016e4ddd8a10b21638f3d3cd1edff81c33761217d2b6e7e86200ba98"
  end

  def install
    programs = buildpath/".brew_home"/".stack"/"programs"/"x86_64-osx"
    mkdir_p programs
    cp resource("ghc").fetch, programs/"ghc-#{resource("ghc").version}.tar.bz2"

    system "stack",
           "--no-terminal",
           "--jobs=#{ENV.make_jobs}",
           "--local-bin-path=#{bin}",
           "--extra-lib-dirs=#{HOMEBREW_PREFIX}/opt/icu4c/lib",
           "--extra-include-dirs=#{HOMEBREW_PREFIX}/opt/icu4c/include",
           "install"

    mkdir "completions"
    system "sh", "-c", "#{bin}/tenpureto --bash-completion-script #{bin}/tenpureto >completions/tenpureto"
    system "sh", "-c", "#{bin}/tenpureto --zsh-completion-script #{bin}/tenpureto >completions/_tenpureto"
    bash_completion.install "completions/tenpureto"
    zsh_completion.install "completions/_tenpureto"
  end

  test do
    system "#{bin}/tenpureto", "--help"
  end
end
