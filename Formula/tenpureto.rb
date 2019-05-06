class Tenpureto < Formula
  desc "Project templating tool"
  homepage "https://github.com/rtimush/tenpureto"

  url "https://github.com/rtimush/tenpureto/archive/v0.1.3.tar.gz"
  sha256 "c359fdf902a92e9748f71089acff8c8d178423024b88dfac0e20cfdcfa9f6138"

  head "https://github.com/rtimush/tenpureto.git"

  bottle do
    root_url "https://dl.bintray.com/rtimush/bottles-tap"
    cellar :any
    sha256 "11b57bb2c36317e2b7c5c267ba2065cd5a58800cbbe3881bbf0a25131e90551a" => :mojave
    sha256 "bcc9ed17456d840ca6a14bad5840894df9a35193f760ab4d7dad8c9e7e5d52a2" => :high_sierra
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
