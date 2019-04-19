class Tenpureto < Formula
  desc "Project templating tool"
  homepage "https://github.com/rtimush/tenpureto"

  url "https://github.com/rtimush/tenpureto/archive/v0.1.1.tar.gz"
  sha256 "e18349cf8db2293b453a091ea30755b5d7996b09baadb7a57ca0253e302d95eb"
  revision 1

  head "https://github.com/rtimush/tenpureto.git"

  bottle do
    root_url "https://dl.bintray.com/rtimush/bottles-tap"
    cellar :any
    rebuild 1
    sha256 "b2e12661a5437a52a90d3d62e262acc5aef0f8a235e8d011d9ee2952dd503d24" => :mojave
    sha256 "06ce079a47a31cac2185e0e90ebfefd09ee77b69a7c489c6baabf309cf3bf7d3" => :high_sierra
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
