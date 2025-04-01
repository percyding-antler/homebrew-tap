class Tavo < Formula
  include Language::Python::Virtualenv

  desc "Tavo CLI - Policy server management tool"
  homepage "https://github.com/percyding-antler/ovat-cli"
  url "https://github.com/percyding-antler/ovat-cli/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "8f04b682838e8b2ae5bfc93ae43818c080fc583cd587f0c3b5a67f2328c47215"
  license "MIT"

  depends_on "python@3.13"
  depends_on "opa"

  resource "aiodns" do
    url "https://files.pythonhosted.org/packages/fa/10/4de99e6e67ac1e19f59a7a59619eb2b502c3ea99c9ecc65a0b8cecd30b3e/aiodns-3.2.0.tar.gz"
    sha256 "371bbb6bbe20bfcfb0240a2059d6d39c787c41bf6b371a505b4f4d8578b9cde6"
  end

  resource "aiofiles" do
    url "https://files.pythonhosted.org/packages/5f/b2/8553d44d0bb3138a45fb6bf88a4dcade8c0e1f3bd03d1fffdb87eabf37a4/aiofiles-24.1.0.tar.gz"
    sha256 "5b3675c3746906f78881f8d399f9f196b2d022916c843fe9cf178dc41ce43682"
  end

  resource "aiohappyeyeballs" do
    url "https://files.pythonhosted.org/packages/cc/75/4e9d3a9f1dc602187f4bf7a22f3085145252ac161f0e6053c48ba75db1a5/aiohappyeyeballs-2.5.0.tar.gz"
    sha256 "5e21ca6fa34810ee5d14c2c38f360efc5542a730e97c7c9a2a2edeb91fb15a69"
  end

  resource "aiohttp" do
    url "https://files.pythonhosted.org/packages/c4/4e/ad2be0f203c2d3461ebb56ffde0e8d2b448e6be0a7fff967ec3c2d82e12c/aiohttp-3.11.13.tar.gz"
    sha256 "fe5fe222bec9b90458493960d8c904f4a231e812f3b4b7b51cc17b80020fbce5"
  end

  resource "flask" do
    url "https://files.pythonhosted.org/packages/65/eb/3478b20a2d9dfa3b4613dbc45e2df059bf3a1d6265557df03d8f88ac3f7a/flask-3.1.0.tar.gz"
    sha256 "ede54265fc0f3c0fe920ccad0c351cb9c853f6250b8ab886aa9c846f7305e6bb"
  end

  resource "opa-python-client" do
    url "https://files.pythonhosted.org/packages/59/9f/2d65a82df6e8c0e5d9daffa58d3af2cf6bfd5c113e2e2c9f66e06a5344a3/opa-python-client-2.0.2.tar.gz"
    sha256 "d8b88c2dcef5a29fe1ce6cbcb66b0fad84d67b24d60dfd03bea5a93fe20c0cf0"
  end

  resource "requests" do
    url "https://files.pythonhosted.org/packages/9d/be/10918a2eac4ae9f02f6cfe6414b7a155ccd8f7f9d4380d62fd5b955065c3/requests-2.31.0.tar.gz"
    sha256 "942c5a758f98d790eaed1a29cb6eefc7ffb0d1cf7af05c3d2791656dbd6ad1e1"
  end

  resource "pymongo" do
    url "https://files.pythonhosted.org/packages/eb/5d/ab84046a63da2632054f07dc078aa2ef41ff93e6a4d28f9b354a24caa2dd/pymongo-4.7.2.tar.gz"
    sha256 "401dc447afbd52e98ca494493ea3c5437a9ef85f416b4608007abd3d5fdcbbb0"
  end

  def install
    virtualenv_install_with_resources
    
    # Create a wrapper script that uses the virtualenv python
    (bin/"tavo-server").write <<~EOS
      #!/bin/bash
      "#{libexec}/bin/python" "#{libexec}/server.py" "$@"
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