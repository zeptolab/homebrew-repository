class CocoapodsAT1162 < Formula
  desc "Dependency manager for Cocoa projects"
  homepage "https://cocoapods.org/"
  url "https://github.com/CocoaPods/CocoaPods/archive/refs/tags/1.16.2.tar.gz"
  sha256 "3067f21a0025aedb5869c7080b6c4b3fa55d397b94fadc8c3037a28a6cee274c"
  license "MIT"
  revision 2

  depends_on "pkgconf" => :build
  depends_on "ruby"
  uses_from_macos "libffi"

  conflicts_with cask: "cocoapods-app", because: "both install `pod` binaries"

  def install
    ENV["GEM_HOME"] = libexec
    system "gem", "build", "cocoapods.gemspec"
    system "gem", "install", "cocoapods-#{version}.gem"
    # Other executables don't work currently.
    bin.install libexec/"bin/pod", libexec/"bin/xcodeproj"
    bin.env_script_all_files(libexec/"bin", GEM_HOME: ENV["GEM_HOME"])
  end

  test do
    system bin/"pod", "list"
  end
end

