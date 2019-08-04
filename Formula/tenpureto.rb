class Tenpureto < Formula
  desc "Project templating tool"
  homepage "https://github.com/rtimush/tenpureto"

  url "https://github.com/rtimush/tenpureto/archive/v0.3.0.tar.gz"
  sha256 "1f34e97f2b3133619fe3ae660fde3aab155ab3b780923e0791f165693e827aed"

  head "https://github.com/rtimush/tenpureto.git"

  bottle do
    root_url "https://dl.bintray.com/rtimush/bottles-tap"
    cellar :any
    sha256 "ffbecf9b0919f9d52fb8375f4de830ee04297c01f44f75dd3ff9875cb9d03b89" => :mojave
    sha256 "6b0b4a2876a87525344568de83ae0586ab2e0872d6bd1aaea16a7e80594d7637" => :high_sierra
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
