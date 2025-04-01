class Tavo < Formula
  include Language::Python::Virtualenv

  desc "Tavo CLI - Policy server management tool"
  homepage "https://github.com/percyding-antler/ovat-cli"
  url "https://github.com/percyding-antler/ovat-cli/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "808edc6503d84335035b55e0870a9e4ea1d938a1066de75940966311e186780a"
  license "MIT"

  depends_on "python@3.11"
  depends_on "opa"

  def install
    virtualenv_install_with_resources
  end

  test do
    system "#{bin}/tavo", "--help"
  end
end 