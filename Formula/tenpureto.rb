class Tenpureto < Formula
  desc "Project templating tool"
  homepage "https://github.com/tenpureto/tenpureto"

  version "0.6.0"
  if OS.mac?
    url "https://github.com/tenpureto/tenpureto/releases/download/v#{version}/tenpureto-#{version}-x86_64-darwin"
    sha256 "044a0d0d7aa7c77232e9b23fdd514c432e798c7b700b6027698c3fe7b224cb4e"
  else
    url "https://github.com/tenpureto/tenpureto/releases/download/v#{version}/tenpureto-#{version}-x86_64-linux"
    sha256 "88e984d449b0163529c67f9fba0735be37bae4711c906b7311ca10070707f605"
  end

  bottle :unneeded

  def install
    if OS.mac?
      mv "tenpureto-#{version}-x86_64-darwin", "tenpureto"
    else
      mv "tenpureto-#{version}-x86_64-linux", "tenpureto"
    end
    FileUtils.chmod 0755, "tenpureto"
    mkdir "completions"
    system "sh", "-c", "./tenpureto --bash-completion-script #{bin}/tenpureto >completions/tenpureto"
    system "sh", "-c", "./tenpureto --zsh-completion-script #{bin}/tenpureto >completions/_tenpureto"
    bin.install "tenpureto"
    bash_completion.install "completions/tenpureto"
    zsh_completion.install "completions/_tenpureto"
  end

  test do
    actual = pipe_output("#{bin}/tenpureto --version")
    expected = "tenpureto #{version}\n"
    assert_equal expected, actual
  end
end
