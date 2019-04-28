class Tenpureto < Formula
  desc "Project templating tool"
  homepage "https://github.com/rtimush/tenpureto"

  url "https://github.com/rtimush/tenpureto/archive/v0.1.2.tar.gz"
  sha256 "6c2cdf03c88cc012fb75a5c937fabd3b739cecccbd99e883375516e8dea2ea12"

  head "https://github.com/rtimush/tenpureto.git"

  bottle do
    root_url "https://dl.bintray.com/rtimush/bottles-tap"
    cellar :any
    sha256 "2576cb3fda43424af57fcc54eaaa8556820538abd283263b9d02f365f4e986d9" => :mojave
    sha256 "c4a07a5fbdbd5ff18333b9c0f48015fb1b3f309ab8e75475359df73c5d98b4a1" => :high_sierra
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
