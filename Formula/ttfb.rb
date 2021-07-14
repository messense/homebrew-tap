class Ttfb < Formula
  desc "Library + CLI-Tool to measure the TTFB (time to first byte) of HTTP requests"
  homepage "https://github.com/phip1611/ttfb"
  url "https://github.com/phip1611/ttfb/archive/refs/tags/v1.1.0.tar.gz"
  sha256 "7a32778707e283d8e3c28541f3ec1f66308e057f52a5598a1a5828687ec97042"
  license "MIT"
  head "https://github.com/phip1611/ttfb.git", branch: "main"

  bottle do
    root_url "https://github.com/messense/homebrew-tap/releases/download/ttfb-1.1.0"
    sha256 cellar: :any_skip_relocation, catalina:     "67a049e29e685f952314ab301cb3bb77bff757354dd50a77c78ae4a12126c238"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "51b845f87cdcd5817a8c662a3623e1d52bec01365f77ccac96b49f050010767a"
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
