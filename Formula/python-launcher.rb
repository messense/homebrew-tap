class PythonLauncher < Formula
  desc "Launch your Python interpreter the lazy/smart way"
  homepage "https://github.com/brettcannon/python-launcher"
  url "https://github.com/brettcannon/python-launcher/archive/refs/tags/v0.17.0.tar.gz"
  sha256 "2533d6be1ab4e61b1b3ef48177e71d08127ee453d40bb0bb3309b063ac07899e"
  license "MIT"
  head "https://github.com/brettcannon/python-launcher.git", branch: "main"

  bottle do
    root_url "https://github.com/messense/homebrew-tap/releases/download/python-launcher-0.17.0"
    sha256 cellar: :any_skip_relocation, catalina:     "cc7d65bf26bfbebf6ddec5cce77d422f2ea790111dcceaf02889fa13961a80b8"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "a4cc90e939da69d92d809bfbc1c2660e4cdd0d53931f8c95484c7f0e9e667828"
  end

  depends_on "rust" => :build
  depends_on "python@3.9" => :test

  def install
    system "cargo", "install", *std_cargo_args
    man1.install "docs/man-page/py.1"
    fish_completion.install "completions/py.fish"
  end

  test do
    assert_match "The Zen of Python", shell_output("#{bin}/py -3.9 -c 'import this'")
  end
end
