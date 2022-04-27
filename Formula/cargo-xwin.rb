class CargoXwin < Formula
  desc "Cross compile Cargo project to Windows MSVC target with ease"
  homepage "https://github.com/messense/cargo-xwin"
  url "https://github.com/messense/cargo-xwin/archive/refs/tags/v0.8.2.tar.gz"
  sha256 "17c4ad96a9061c0e400212a7551f700cb68d95e0e18c2ebd564acd753e360522"
  license "MIT"
  head "https://github.com/messense/cargo-xwin.git", branch: "main"

  bottle do
    root_url "https://github.com/messense/homebrew-tap/releases/download/cargo-xwin-0.8.2"
    sha256 cellar: :any_skip_relocation, big_sur:      "e29ced21bde11b23698acefb7b94501c2596ef1e44e81ac6ff975aa2cfc66cf2"
    sha256                               x86_64_linux: "c97426efbcbeab84e2f4b3c2d5e085a98f5a2f60ccd2c291197d5b0ca8f3a333"
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
