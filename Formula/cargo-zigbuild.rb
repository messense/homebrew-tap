class CargoZigbuild < Formula
  desc "Compile Cargo project with zig as linker"
  homepage "https://github.com/messense/cargo-zigbuild"
  url "https://github.com/messense/cargo-zigbuild/archive/refs/tags/v0.6.6.tar.gz"
  sha256 "f07475880460d84eb311dd3aa012fac16360ed76fedb6d9bf4b6c319142973d2"
  license "MIT"
  head "https://github.com/messense/cargo-zigbuild.git", branch: "main"

  bottle do
    root_url "https://github.com/messense/homebrew-tap/releases/download/cargo-zigbuild-0.6.6"
    sha256 cellar: :any_skip_relocation, big_sur:      "6868234b0eb1d3157b6c059ac6230ce646fe29fba2c6286c9b6f4a03f02bdcd8"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "363029ddb9304fe9015af37787a58c125c3d0d59a7d9a4e18bf8527531ce6e8c"
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
