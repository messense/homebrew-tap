class CargoXwin < Formula
  desc "Cross compile Cargo project to Windows MSVC target with ease"
  homepage "https://github.com/messense/cargo-xwin"
  url "https://github.com/messense/cargo-xwin/archive/refs/tags/v0.8.2.tar.gz"
  sha256 "17c4ad96a9061c0e400212a7551f700cb68d95e0e18c2ebd564acd753e360522"
  license "MIT"
  head "https://github.com/messense/cargo-xwin.git", branch: "main"

  bottle do
    root_url "https://github.com/messense/homebrew-tap/releases/download/cargo-xwin-0.7.1"
    sha256 cellar: :any_skip_relocation, big_sur:      "bd780ee4135fe673fb07d9c609aab93b0aa5a7dff0f60e35f27c7adf4f59f3a9"
    sha256                               x86_64_linux: "dc7d70fa704a171568416ca440d3849a9a52bd502261a0b2f6a9bd5b297fac80"
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
