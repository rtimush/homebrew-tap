class Tenpureto < Formula
  desc "Project templating tool"
  homepage "https://github.com/rtimush/tenpureto"

  url "https://github.com/rtimush/tenpureto/archive/v0.3.0.tar.gz"
  sha256 "1f34e97f2b3133619fe3ae660fde3aab155ab3b780923e0791f165693e827aed"

  head "https://github.com/rtimush/tenpureto.git"

  bottle do
    root_url "https://dl.bintray.com/rtimush/bottles-tap"
    cellar :any
    sha256 "c3a36f7fd24705b262390de269d0e9d6a61aa0d4c4694c185b36cb87dc6a821f" => :mojave
    sha256 "e17b35b7749713401f4aba7e1460e603e52f35d32d3dde6aef294efde1b42447" => :high_sierra
  end

  depends_on "haskell-stack" => :build
  depends_on "icu4c"

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
