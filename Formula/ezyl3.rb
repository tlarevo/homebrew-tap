class Ezyl3 < Formula
  desc "Manage a local LiteLLM bridge for Cursor"
  homepage "https://github.com/tlarevo/ezyl3"
  version "0.1.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/tlarevo/ezyl3/releases/download/v0.1.1/ezyl3_0.1.1_darwin_arm64.tar.gz"
      sha256 "57860283f3c74897a2bc263d67e6bf0793c31772f23cfa05131da65b178b2ead"
    end

    on_intel do
      url "https://github.com/tlarevo/ezyl3/releases/download/v0.1.1/ezyl3_0.1.1_darwin_amd64.tar.gz"
      sha256 "1a9374409008f6f66f94f94d2344b76b034238ccad7e5d55b8530069330f8f8c"
    end
  end

  def install
    bin.install "ezyl3"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/ezyl3 version")
  end
end
