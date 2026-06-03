class Ezyl3 < Formula
  desc "Manage a local LiteLLM bridge for Cursor"
  homepage "https://github.com/tlarevo/ezyl3"
  version "0.2.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/tlarevo/ezyl3/releases/download/v0.2.0/ezyl3_0.2.0_darwin_arm64.tar.gz"
      sha256 "cd818cb7ba55f4e3a6c09a58e8fa403b171361b36c433023a49f34c4ae982a4d"
    end

    on_intel do
      url "https://github.com/tlarevo/ezyl3/releases/download/v0.2.0/ezyl3_0.2.0_darwin_amd64.tar.gz"
      sha256 "351b8490fafb0227bbec607412a74e735d421ec4fd75d44a67750e1d72e5dca2"
    end
  end

  def install
    bin.install "ezyl3"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/ezyl3 version")
  end
end
