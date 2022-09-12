class CargoZigbuild < Formula
  desc "Compile Cargo project with zig as linker"
  homepage "https://github.com/messense/cargo-zigbuild"
  url "https://github.com/messense/cargo-zigbuild/archive/refs/tags/v0.12.2.tar.gz"
  sha256 "90397c5170eb02ebcf8c378e499f2c9be3b1b63c85d20e1e0584aec459321ed7"
  license "MIT"
  head "https://github.com/messense/cargo-zigbuild.git", branch: "main"

  bottle do
    root_url "https://github.com/messense/homebrew-tap/releases/download/cargo-zigbuild-0.8.6"
    sha256 cellar: :any_skip_relocation, big_sur:      "56b308db20736025ac895cf2d1f0a5faf3d4c1e4a94b0e1b79069925c2fa93d3"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "94a3b6871e459308565345f6cf5162ffbecbd6af3ef46eb92e4eec7b34657cfb"
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
