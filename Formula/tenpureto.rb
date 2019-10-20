class Tenpureto < Formula
  desc "Project templating tool"
  homepage "https://github.com/tenpureto/tenpureto"

  url "https://github.com/tenpureto/tenpureto/archive/v0.4.0.tar.gz"
  sha256 "bb6a6acd7932f1f1a54bf4f01a7e4ef71f9f2910e7c3d112b9042bd32e8afd1c"

  head "https://github.com/tenpureto/tenpureto.git"

  bottle do
    root_url "https://dl.bintray.com/rtimush/bottles-tap"
    cellar :any
    sha256 "822aeeb07787e0b54c581393434051fda7e909213b8e916ca94d73a44f441f06" => :mojave
    sha256 "e9d85e3eac9dabafe06d4f9ee391aaab6dc854c35de3e8aa262dc195ff05ad4c" => :high_sierra
  end

  depends_on "haskell-stack" => :build

  def install
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
