class Mataka < Formula
  desc "Lean drop-in replacement for the Hindsight agent-memory API"
  homepage "https://github.com/tlarevo/mataka"
  version "0.2.3"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/tlarevo/mataka/releases/download/v0.2.3/mataka_aarch64-apple-darwin.tar.gz"
      sha256 "f196c498904bb98d01794b3bbf161ccd9ab15e82334a481125e1368b05306a74"
    end
  end
  on_linux do
    on_intel do
      url "https://github.com/tlarevo/mataka/releases/download/v0.2.3/mataka_x86_64-unknown-linux-gnu.tar.gz"
      sha256 "15658cfd96ef9f3d4c55d7f2ea1211fff81fc316b75770cc9c3d1db6709d4afb"
    end
  end

  def install
    bin.install "mataka"
  end

  service do
    run [opt_bin/"mataka"]
    keep_alive true
    log_path var/"log/mataka.log"
    error_log_path var/"log/mataka.log"
    # Default to Ollama (qwen2.5:3b + nomic-embed-text)
    # Override for other providers:
    #   brew services stop mataka
    #   launchctl unload ~/Library/LaunchAgents/homebrew.mxcl.mataka.plist
    #   # Edit plist EnvironmentVariables to point at your provider
    #   launchctl load ~/Library/LaunchAgents/homebrew.mxcl.mataka.plist
    environment_variables MATAKA_LLM_PROVIDER: "openai-compatible",
                          MATAKA_LLM_BASE_URL: "http://localhost:11434/v1",
                          MATAKA_LLM_MODEL: "qwen2.5:3b",
                          MATAKA_EMBEDDINGS_MODEL: "nomic-embed-text"
  end

  test do
    # Start mock server, health check, then kill
    pid = fork do
      exec ENV["MATAKA_LLM_PROVIDER"] = "mock", bin/"mataka"
    end
    sleep 2
    assert_match "ok", shell_output("curl -sf http://localhost:8889/health")
  ensure
    Process.kill("TERM", pid) if pid
    Process.wait(pid) if pid
  end
end
