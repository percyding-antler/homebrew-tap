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
    url "https://pypi.org/packages/source/a/aiodns/aiodns-3.2.0.tar.gz"
    sha256 "62869b23409349c21b072883ec8998316b234c9a9e36675756e8e317e8768f72"
  end

  resource "aiofiles" do
    url "https://pypi.org/packages/source/a/aiofiles/aiofiles-24.1.0.tar.gz"
    sha256 "22a075c9e5a3810f0c2e48f3008c94d68c65d763b9b03857924c99e57355166c"
  end

  resource "aiohappyeyeballs" do
    url "https://pypi.org/packages/source/a/aiohappyeyeballs/aiohappyeyeballs-2.5.0.tar.gz"
    sha256 "5e21ca6fa34810ee5d14c2c38f360efc5542a730e97c7c9a2a2edeb91fb15a69"
  end

  resource "aiohttp" do
    url "https://pypi.org/packages/source/a/aiohttp/aiohttp-3.11.13.tar.gz"
    sha256 "fe5fe222bec9b90458493960d8c904f4a231e812f3b4b7b51cc17b80020fbce5"
  end

  resource "flask" do
    url "https://pypi.org/packages/source/f/flask/flask-3.1.0.tar.gz"
    sha256 "5f873c5184c897c8d9d1b05df1e3d01b14910ce69607a117bd3277098a5836ac"
  end

  resource "opa-python-client" do
    url "https://pypi.org/packages/source/o/opa-python-client/opa-python-client-2.0.2.tar.gz"
    sha256 "d8b88c2dcef5a29fe1ce6cbcb66b0fad84d67b24d60dfd03bea5a93fe20c0cf0"
  end

  resource "requests" do
    url "https://pypi.org/packages/source/r/requests/requests-2.31.0.tar.gz"
    sha256 "942c5a758f98d790eaed1a29cb6eefc7ffb0d1cf7af05c3d2791656dbd6ad1e1"
  end

  resource "pymongo" do
    url "https://pypi.org/packages/source/p/pymongo/pymongo-4.7.2.tar.gz"
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