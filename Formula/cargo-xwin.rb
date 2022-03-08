class CargoXwin < Formula
  desc "Cross compile Cargo project to Windows MSVC target with ease"
  homepage "https://github.com/messense/cargo-xwin"
  url "https://github.com/messense/cargo-xwin/archive/refs/tags/v0.6.0.tar.gz"
  sha256 "668383f7fb4203a19038e190cf7a4a5e63d72d6a9e5b3436af66077ea3434eee"
  license "MIT"
  head "https://github.com/messense/cargo-xwin.git", branch: "main"

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
