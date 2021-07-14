class Ttfb < Formula
  desc "Library + CLI-Tool to measure the TTFB (time to first byte) of HTTP requests"
  homepage "https://github.com/phip1611/ttfb"
  url "https://github.com/phip1611/ttfb/archive/refs/tags/v1.1.0.tar.gz"
  sha256 "7a32778707e283d8e3c28541f3ec1f66308e057f52a5598a1a5828687ec97042"
  license "MIT"
  head "https://github.com/phip1611/ttfb.git", branch: "main"

  depends_on "rust" => :build
  depends_on "openssl@1.1"

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match "TTFB for https://example.com", shell_output("#{bin}/ttfb https://example.com ")
  end
end
