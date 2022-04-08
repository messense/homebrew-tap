class CargoXwin < Formula
  desc "Cross compile Cargo project to Windows MSVC target with ease"
  homepage "https://github.com/messense/cargo-xwin"
  url "https://github.com/messense/cargo-xwin/archive/refs/tags/v0.8.0.tar.gz"
  sha256 "0a82b58de22a86a737d1f6087e38bde92448bf4434f178a672b60797cfb25e2e"
  license "MIT"
  head "https://github.com/messense/cargo-xwin.git", branch: "main"

  bottle do
    root_url "https://github.com/messense/homebrew-tap/releases/download/cargo-xwin-0.8.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "05808f96ff64d40a40ccc988b4ea5640dfa7838a437d738bbc78922295dc1f7c"
    sha256                               x86_64_linux: "de788220342686b8d6d038138dea8c395871999ab7f52c2d3327e0c4a7ec7a21"
  end

  depends_on "rustup-init" => :test
  depends_on "llvm"
  depends_on "rust"

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    system "#{Formula["rustup-init"].bin}/rustup-init", "-y", "--no-modify-path"
    ENV.prepend_path "PATH", HOMEBREW_CACHE/"cargo_cache/bin"
    system "rustup", "target", "add", "x86_64-pc-windows-msvc"

    system "cargo", "new", "hello_world", "--bin"
    cd "hello_world" do
      system bin/"cargo-xwin", "xwin", "build", "--target", "x86_64-pc-windows-msvc"
    end
  end
end
