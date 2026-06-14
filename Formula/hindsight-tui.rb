class HindsightTui < Formula
  desc "Local-first terminal UI for Hindsight"
  homepage "https://github.com/tlarevo/hindsight-tui"
  url "https://github.com/tlarevo/hindsight-tui/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "4fe6425b3f8bc3d2fab7323957c989c63633561dfbf1292c6869d76caa270f11"
  license "MIT"
  head "https://github.com/tlarevo/hindsight-tui.git", branch: "main"

  depends_on "go" => :build

  def install
    ldflags = "-s -w -X hindsight-tui/internal/cli.version=#{version}"
    system "go", "build", *std_go_args(ldflags:, output: bin/"hindsight-tui"), "./cmd/hindsight-tui"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/hindsight-tui --version")
    assert_match "backend: demo", shell_output("#{bin}/hindsight-tui --demo --doctor")
  end
end
