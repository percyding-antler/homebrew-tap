class Tavo < Formula
  include Language::Python::Virtualenv

  desc "Tavo CLI - Policy server management tool"
  homepage "https://github.com/percyding-antler/ovat-cli"
  url "https://github.com/percyding-antler/ovat-cli/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "8f04b682838e8b2ae5bfc93ae43818c080fc583cd587f0c3b5a67f2328c47215"
  license "MIT"

  depends_on "python@3.13"
  depends_on "opa"

  def install
    # Install using virtualenv
    virtualenv_install_with_resources

    # Create a wrapper script that sets up the environment properly
    (bin/"tavo-server").write <<~EOS
      #!/bin/bash
      exec /usr/bin/env python3 "#{prefix}/libexec/server.py" "$@"
    EOS
    
    # Move the Python files to libexec
    libexec.install "server.py"
    libexec.install "policy_store.py"
    libexec.install "prebuilt_policies.json" if File.exist?("prebuilt_policies.json")
    libexec.install "db.json" if File.exist?("db.json")
    
    # Make the wrapper script executable
    chmod 0755, bin/"tavo-server"
  end

  test do
    system "#{bin}/tavo", "--help"
  end
end 