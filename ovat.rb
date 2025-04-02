class Ovat < Formula
  include Language::Python::Virtualenv

  desc "OVAT - Open Policy Agent Verification and Testing CLI tool"
  homepage "https://github.com/percyding-antler/ovat-cli"
  url "https://github.com/percyding-antler/ovat-cli/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "bdaafdfa8e4834128f124702ad96de4e0fcacec716b6cd4fc7149cb7d07458d4"
  license "MIT"

  depends_on "python@3"

  resource "click" do
    url "https://files.pythonhosted.org/packages/77/88/b0cc5fe062240edf03093a8218e1ce7f7d7a5b21f7524604c2e64e4da9ca/click-8.1.8.tar.gz"
    sha256 "c7591d93d063ab1a3f8931d43aea83f56fb4fb3a63afa50a5eed79af5dbf4cc2"
  end

  resource "flask" do
    url "https://files.pythonhosted.org/packages/99/9f/34db19ac62ead785eb64e81d8be66aa6aa97e3c9941cc4f0996fbe6e2bf4/flask-3.1.0.tar.gz"
    sha256 "2ef43e8557c16d84bc94f07387b3a0b3c2bd09897b16f4ec1b99abe2a2cd7603"
  end

  # Add other dependencies here based on your requirements.txt

  def install
    virtualenv_install_with_resources
  end

  test do
    assert_match "OVAT - Open Policy Agent Verification and Testing CLI tool", shell_output("#{bin}/ovat --help")
    assert_match "Commands related to the OPA policy server", shell_output("#{bin}/ovat server --help")
    assert_match "Start the server in development mode", shell_output("#{bin}/ovat server start-dev --help")
  end
end 