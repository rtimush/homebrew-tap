class Tenpureto < Formula
  desc "Project templating tool"
  homepage "https://github.com/tenpureto/tenpureto"

  version "0.6.1"
  if OS.mac?
    url "https://github.com/tenpureto/tenpureto/releases/download/v#{version}/tenpureto-#{version}-x86_64-darwin"
    sha256 "9a7ee1987328e87a7a99e9678e42601cd090a6163250882fdca092f4b58a2ee2"
  else
    url "https://github.com/tenpureto/tenpureto/releases/download/v#{version}/tenpureto-#{version}-x86_64-linux"
    sha256 "623218683c93b744c85fd12aefb82ca7fed777b95e9b3ff2bad016e44500357d"
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
