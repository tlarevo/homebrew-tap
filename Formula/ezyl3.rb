class Ezyl3 < Formula
  desc "Manage a local LiteLLM bridge for Cursor"
  homepage "https://github.com/tlarevo/ezyl3"
  version "0.1.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/tlarevo/ezyl3/releases/download/v0.1.0/ezyl3_0.1.0_darwin_arm64.tar.gz"
      sha256 "8ed9545e725416cc404f8e06fea9b24f8a18a45e584710c427ff46b7934a51fd"
    end

    on_intel do
      url "https://github.com/tlarevo/ezyl3/releases/download/v0.1.0/ezyl3_0.1.0_darwin_amd64.tar.gz"
      sha256 "6ec5a471cb70a6838f039afa626fc3c091f52fe1285bfdfa11ca6fe30cb0e232"
    end
  end

  def install
    bin.install "ezyl3"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/ezyl3 version")
  end
end
