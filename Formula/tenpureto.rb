class Tenpureto < Formula
  desc "Project templating tool"
  homepage "https://github.com/tenpureto/tenpureto"

  version "0.5.1"
  if OS.mac?
    url "https://github.com/tenpureto/tenpureto/releases/download/v#{version}/tenpureto-#{version}-x86_64-darwin"
    sha256 "6da81de2bd15705a9a79ef88f50abb0aa9ec59426541b74ebed04384ac4a6a3d"
  else
    url "https://github.com/tenpureto/tenpureto/releases/download/v#{version}/tenpureto-#{version}-x86_64-linux"
    sha256 "2b96278f40d081d25bc31e2dc74009b411030f7c1de9688e716161ace4ea89e5"
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
