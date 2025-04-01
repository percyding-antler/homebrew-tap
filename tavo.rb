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
    sha256 "18fde6204a76deeabc97c48bdd01d5801cfda5d6b9c8bbeb1aaaee9d648ca191"
  end

  resource "aiohttp" do
    url "https://pypi.org/packages/source/a/aiohttp/aiohttp-3.11.13.tar.gz"
    sha256 "8ce789231404ca8fff7f693cdce398abf6d90fd5dae2b1847477196c243b1fbb"
  end

  resource "flask" do
    url "https://pypi.org/packages/source/f/flask/flask-3.1.0.tar.gz"
    sha256 "5f873c5184c897c8d9d1b05df1e3d01b14910ce69607a117bd3277098a5836ac"
  end

  resource "opa-python-client" do
    url "https://files.pythonhosted.org/packages/c1/6c/22cc509869e1feb1b292bb9e8a3ab738018bfab34abf117c0214db165353/opa_python_client-2.0.2.tar.gz"
    sha256 "e7582cc1d370941c33b22a34307bd5946341f96318f4563dd81a11ef087ec5bb"
  end

  resource "requests" do
    url "https://pypi.org/packages/source/r/requests/requests-2.31.0.tar.gz"
    sha256 "942c5a758f98d790eaed1a29cb6eefc7ffb0d1cf7af05c3d2791656dbd6ad1e1"
  end

  resource "pymongo" do
    url "https://pypi.org/packages/source/p/pymongo/pymongo-4.7.2.tar.gz"
    sha256 "9024e1661c6e40acf468177bf90ce924d1bc681d2b244adda3ed7b2f4c4d17d7"
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