class CargoZigbuild < Formula
  desc "Compile Cargo project with zig as linker"
  homepage "https://github.com/messense/cargo-zigbuild"
  url "https://github.com/messense/cargo-zigbuild/archive/refs/tags/v0.8.6.tar.gz"
  sha256 "ced01090f5bb2b371f7a40291f4975cd017f496ed1533df38cd7adcf7faef64c"
  license "MIT"
  head "https://github.com/messense/cargo-zigbuild.git", branch: "main"

  bottle do
    root_url "https://github.com/messense/homebrew-tap/releases/download/cargo-zigbuild-0.8.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "97f8358149a3ffc13e0ecf0f12d60f9ce31f86e5407ed6653c2354d929fb1735"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "a3d33f4153f15b7bd651be912dbe51dd63e8d285712a1e79e707add8482ad83d"
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
