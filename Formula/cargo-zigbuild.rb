class CargoZigbuild < Formula
  desc "Compile Cargo project with zig as linker"
  homepage "https://github.com/messense/cargo-zigbuild"
  url "https://github.com/messense/cargo-zigbuild/archive/refs/tags/v0.7.2.tar.gz"
  sha256 "4a1836d10a52d106cd7775e4cd17aa6734335ab7923ffb86ad1771b9f52f2f81"
  license "MIT"
  head "https://github.com/messense/cargo-zigbuild.git", branch: "main"

  bottle do
    root_url "https://github.com/messense/homebrew-tap/releases/download/cargo-zigbuild-0.7.2"
    sha256 cellar: :any_skip_relocation, big_sur:      "7d157698a9b96ee850666346a0161b1100fd1effe15b77ee74d759fdbd7c7c4d"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "b48e0eb201a4f8f41b912a2a1a4442aa57555f59cdd6e464419cadfbd5202eeb"
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
