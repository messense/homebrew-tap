class Ttfb < Formula
  desc "Library + CLI-Tool to measure the TTFB (time to first byte) of HTTP requests"
  homepage "https://github.com/phip1611/ttfb"
  url "https://github.com/phip1611/ttfb/archive/refs/tags/v1.3.0.tar.gz"
  sha256 "8073833b0a7a500617302328620799d04a6fafedead9abed677eb18c0737b543"
  license "MIT"
  head "https://github.com/phip1611/ttfb.git", branch: "main"

  bottle do
    root_url "https://github.com/messense/homebrew-tap/releases/download/ttfb-1.3.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "7b0d96530a32355c953671c1fb461b6f6c9a92009c3f3cbb487e4f5ceecd065c"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "054859a821b01d3dd7236e71fbf106f7a694ded54ae6aaaed221b59d3b554c42"
  end

  depends_on "rust" => :build
  depends_on "openssl@1.1"

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match "TTFB for https://example.com", shell_output("#{bin}/ttfb https://example.com ")
  end
end
