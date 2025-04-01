class Tavo < Formula
  include Language::Python::Virtualenv

  desc "Tavo CLI - Policy server management tool"
  homepage "https://github.com/percyding-antler/ovat-cli"
  url "https://github.com/percyding-antler/ovat-cli/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "8f04b682838e8b2ae5bfc93ae43818c080fc583cd587f0c3b5a67f2328c47215"
  license "MIT"

  depends_on "python@3.11"
  depends_on "opa"

  def install
    # Install using virtualenv
    virtualenv_install_with_resources
    
    # Ensure the main python files are in the right location
    bin.install "server.py"
    bin.install "policy_store.py"
    bin.install "prebuilt_policies.json" if File.exist?("prebuilt_policies.json")
    bin.install "db.json" if File.exist?("db.json")
    
    # Create a directory structure that matches what the script expects
    (libexec/"sdk").mkpath
    # Create symlinks in the sdk directory to the actual files
    ln_sf bin/"server.py", libexec/"sdk/server.py"
    ln_sf bin/"policy_store.py", libexec/"sdk/policy_store.py"
  end

  test do
    system "#{bin}/tavo", "--help"
  end
end 