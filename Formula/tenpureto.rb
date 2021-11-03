class Tenpureto < Formula
  desc "Project templating tool"
  homepage "https://github.com/tenpureto/tenpureto"

  version "0.6.3"
  if OS.mac?
    url "https://github.com/tenpureto/tenpureto/releases/download/v#{version}/tenpureto-#{version}-x86_64-darwin"
    sha256 "135f9e94c4095a007614f5377d97f5ab430a9acdf95a5ccea9f761b7d6ea192a"
  else
    url "https://github.com/tenpureto/tenpureto/releases/download/v#{version}/tenpureto-#{version}-x86_64-linux"
    sha256 "d1d75d387cddccafe60549be16f88d918be990c3f184669a04274a60ac22b45d"
  end

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
