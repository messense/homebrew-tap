class CargoZigbuild < Formula
  desc "Compile Cargo project with zig as linker"
  homepage "https://github.com/messense/cargo-zigbuild"
  url "https://github.com/messense/cargo-zigbuild/archive/refs/tags/v0.7.1.tar.gz"
  sha256 "77d0bf9c72b4fc93de768acbe5a1be511db9e09468cfbca0acdfee587f98fb15"
  license "MIT"
  head "https://github.com/messense/cargo-zigbuild.git", branch: "main"

  bottle do
    root_url "https://github.com/messense/homebrew-tap/releases/download/cargo-zigbuild-0.7.1"
    sha256 cellar: :any_skip_relocation, big_sur:      "96bf7a95b766139b92bab9837ca55997676f080ed9062e0f131624d300bb7bbc"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "900a941f3a3ba1a7d94790024f8122e4db719ab51f8648221425be19d6eb499c"
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
