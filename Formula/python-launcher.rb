class PythonLauncher < Formula
  desc "Launch your Python interpreter the lazy/smart way"
  homepage "https://github.com/brettcannon/python-launcher"
  url "https://github.com/brettcannon/python-launcher/archive/refs/tags/v0.17.0.tar.gz"
  sha256 "2533d6be1ab4e61b1b3ef48177e71d08127ee453d40bb0bb3309b063ac07899e"
  license "MIT"
  head "https://github.com/brettcannon/python-launcher.git", branch: "main"

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
