class Mataka < Formula
  desc "Lean drop-in replacement for the Hindsight agent-memory API"
  homepage "https://github.com/tlarevo/mataka"
  version "0.2.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/tlarevo/mataka/releases/download/v0.2.0/mataka_aarch64-apple-darwin.tar.gz"
      sha256 "5c307272f73ba88736c56e522b45dd9d4a467b6eec44e57ca5c2836f7ecf6890"
    end
  end
  on_linux do
    on_intel do
      url "https://github.com/tlarevo/mataka/releases/download/v0.2.0/mataka_x86_64-unknown-linux-gnu.tar.gz"
      sha256 "164fa6262827c7092823a6ac8d63bbc7abc27464476729555b66a3b8cf339044"
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
    # Default to apfel (on-device LLM via Apple Intelligence).
    # Override for other providers:
    #   brew services stop mataka
    #   launchctl unload ~/Library/LaunchAgents/homebrew.mxcl.mataka.plist
    #   # Edit plist EnvironmentVariables to point at your provider
    #   launchctl load ~/Library/LaunchAgents/homebrew.mxcl.mataka.plist
    environment_variables MATAKA_LLM_PROVIDER: "openai-compatible",
                          MATAKA_LLM_BASE_URL: "http://localhost:11434/v1",
                          MATAKA_LLM_MODEL: "apfel",
                          MATAKA_EMBEDDINGS_MODEL: "apfel"
  end

  test do
    # Start mock server, health check, then kill
    pid = fork do
      exec ENV["MATAKA_LLM_PROVIDER"] = "mock", bin/"mataka"
    end
    sleep 2
    assert_match "ok", shell_output("curl -sf http://localhost:8888/health")
  ensure
    Process.kill("TERM", pid) if pid
    Process.wait(pid) if pid
  end
end
