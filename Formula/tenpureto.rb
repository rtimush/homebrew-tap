class Tenpureto < Formula
  desc "Project templating tool"
  homepage "https://github.com/tenpureto/tenpureto"

  version "0.4.1"
  if OS.mac?
    url "https://github.com/tenpureto/tenpureto/releases/download/v#{version}/tenpureto-#{version}-x86_64-darwin"
    sha256 "b675d2834714eb567f0fb6c02430c7278b892962440c33caf3726cd8d361215c"
  else
    url "https://github.com/tenpureto/tenpureto/releases/download/v#{version}/tenpureto-#{version}-x86_64-linux"
    sha256 "6da809b90d6f718c4b530f48a3c7aa71239fb4da7eedc7a06e7368ccb2e3f414"
  end

  bottle :unneeded

  def install
    mv "tenpureto-#{version}-x86_64-*", "tenpureto"
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
