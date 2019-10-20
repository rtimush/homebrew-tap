class Tenpureto < Formula
  desc "Project templating tool"
  homepage "https://github.com/tenpureto/tenpureto"

  url "https://github.com/tenpureto/tenpureto/archive/v0.4.0.tar.gz"
  sha256 "bb6a6acd7932f1f1a54bf4f01a7e4ef71f9f2910e7c3d112b9042bd32e8afd1c"

  head "https://github.com/tenpureto/tenpureto.git"

  bottle do
    root_url "https://dl.bintray.com/rtimush/bottles-tap"
    cellar :any_skip_relocation
    sha256 "81b5b8cc816b7aba8b2c8b0c01348a23b30176368f1053feb6d2557ccc7ea5e1" => :mojave
    sha256 "2c2db13354c55ebb0b54bec2e1f0e453086c9a95b584b04d5fc43144d2e0b807" => :high_sierra
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
