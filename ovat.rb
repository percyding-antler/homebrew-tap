class Ovat < Formula
  include Language::Python::Virtualenv

  desc "OVAT - Open Policy Agent Verification and Testing CLI tool"
  homepage "https://github.com/percyding-antler/ovat-cli"
  url "https://github.com/percyding-antler/ovat-cli/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "bdaafdfa8e4834128f124702ad96de4e0fcacec716b6cd4fc7149cb7d07458d4"
  license "MIT"

  depends_on "python@3.12"

  def install
    python_executable = Formula["python@3.12"].opt_bin/"python3.12"
    venv = virtualenv_create(libexec, python_executable)
    venv.pip_install_and_link buildpath

    bin.install_symlink libexec/"bin/ovat"
  end

  test do
    assert_match "OVAT - Open Policy Agent Verification and Testing CLI tool", shell_output("#{bin}/ovat --help")
    assert_match "Commands related to the OPA policy server", shell_output("#{bin}/ovat server --help")
    assert_match "Start the server in development mode", shell_output("#{bin}/ovat server start-dev --help")
  end
end 