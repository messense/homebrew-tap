class CargoZigbuild < Formula
  desc "Compile Cargo project with zig as linker"
  homepage "https://github.com/messense/cargo-zigbuild"
  url "https://github.com/messense/cargo-zigbuild/archive/refs/tags/v0.6.4.tar.gz"
  sha256 "33ccefdcb370dfc656ce9e082489abf7b9113fe565310e73b0ef479f52f1aaf6"
  license "MIT"
  head "https://github.com/messense/cargo-zigbuild.git", branch: "main"

  bottle do
    root_url "https://github.com/messense/homebrew-tap/releases/download/cargo-zigbuild-0.6.4"
    sha256 cellar: :any_skip_relocation, big_sur:      "191d949fe9d8efd4d67bcc8d3678dfb64ba88104d04cc8440654cdc173a6e2a7"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "8e8de75f29ef622e9690e5567d3a31645d490a6e2c75760e65aea3959e4f6f8d"
  end

  depends_on "rustup-init" => :test
  depends_on "rust"
  depends_on "zig"

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    # https://github.com/ziglang/zig/issues/10377
    ENV.delete "CPATH"

    system "#{Formula["rustup-init"].bin}/rustup-init", "-y", "--no-modify-path"
    ENV.prepend_path "PATH", HOMEBREW_CACHE/"cargo_cache/bin"
    system "rustup", "target", "add", "aarch64-unknown-linux-gnu"

    system "cargo", "new", "hello_world", "--bin"
    cd "hello_world" do
      system "cargo", "zigbuild", "--target", "aarch64-unknown-linux-gnu.2.17"
    end
  end
end
