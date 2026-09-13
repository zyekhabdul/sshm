class Sshm < Formula
  desc "Interactive SSH Fuzzy Manager with Live Metadata Preview"
  homepage "https://github.com/zyekhabdul/sshm"
  url "https://github.com/zyekhabdul/sshm/archive/refs/tags/v1.1.0.tar.gz"
  license "MIT"
  head "https://github.com/zyekhabdul/sshm.git", branch: "main"

  depends_on "bash"
  depends_on "fzf"

  def install
    bin.install "bin/sshm"
  end

  test do
    system bin/"sshm", "--version"
    system bin/"sshm", "--help"
  end
end
