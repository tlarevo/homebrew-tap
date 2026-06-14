class HindsightTui < Formula
  desc "Local-first terminal UI for Hindsight"
  homepage "https://github.com/tlarevo/hindsight-tui"
  url "https://github.com/tlarevo/hindsight-tui/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "35ec45d31e03a2db0e4cc17137a1c65fdad4e641fbe68313fa2abe3495722c8d"
  license "MIT"
  head "https://github.com/tlarevo/hindsight-tui.git", branch: "main"

  depends_on "go" => :build

  def install
    ldflags = "-s -w -X github.com/tlarevo/hindsight-tui/internal/cli.version=#{version}"
    system "go", "build", *std_go_args(ldflags:, output: bin/"hindsight-tui"), "./cmd/hindsight-tui"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/hindsight-tui --version")
    assert_match "backend: demo", shell_output("#{bin}/hindsight-tui --demo --doctor")
  end
end
