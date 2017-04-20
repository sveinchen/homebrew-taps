# Documentation: http://docs.brew.sh/Formula-Cookbook.html
#                http://www.rubydoc.info/github/Homebrew/brew/master/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class Macautopac < Formula
  desc "Update PAC(Proxy Auto Config) automatically according to Wi-Fi name for macOS."
  homepage "https://github.com/sveinchen/MacAutoPac/"
  url "https://github.com/sveinchen/MacAutoPac/archive/v0.1.4.tar.gz"
  version "0.1.4"
  sha256 "c7bd9dd0c0a386dd4d5d9e48f93a98f7bafda07ddb65937dff9e31cffbaa2010"

  # depends_on "cmake" => :build

  def install
    etc.install "etc/autopac.ini" => "autopac.ini"
    sbin.install "sbin/autopac.py" => "autopac"
  end

  def caveats; <<-EOS.undent
    The configuration file is located at #{etc}/autopac.ini
    EOS
  end

  plist_options :startup => true, :manual => "sudo autopac"

  def plist; <<-EOS.undent
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN"
      "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
      <plist version="1.0">
      <dict>
        <key>Label</key>
        <string>#{plist_name}</string>
        <key>ProgramArguments</key>
        <array>
          <string>#{opt_sbin}/autopac</string>
        </array>
        <key>RunAtLoad</key>
        <true/>
        <key>WorkingDirectory</key>
        <string>#{var}</string>
        <key>StandardErrorPath</key>
        <string>#{var}/log/autopac.log</string>
        <key>StandardOutPath</key>
        <string>#{var}/log/autopac.log</string>
        <key>WatchPaths</key>
        <array>
          <string>/Library/Preferences/SystemConfiguration/com.apple.airport.preferences.plist</string>
        </array>
      </dict>
    </plist>
    EOS
  end
end
