class Tenpureto < Formula
  desc "Project templating tool"
  homepage "https://github.com/rtimush/tenpureto"

  url "https://github.com/rtimush/tenpureto/archive/v0.1.0.tar.gz"
  sha256 "117007c8bdf689cf6a4d122e2dff2492429b9859e75ba8b64f9446cf3c8a883e"

  head "https://github.com/rtimush/tenpureto.git"

  bottle do
    root_url "https://dl.bintray.com/rtimush/bottles-tap"
    cellar :any
    sha256 "a39a4df78634aaa7ca3a478ac36fdd0c8a39945b8ef473229ec635de17a01013" => :mojave
    sha256 "ee786ddd66f2ebd68a1b8c338000f7e456657916202b2defe0def34a55e09276" => :high_sierra
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
