cask "samsung-printer-driver" do
  version "3.93.01"
  sha256 :no_check

  url "https://ftp.hp.com/pub/softlib/software13/printers/SS/Print_Common_SW/Samsung_Mac_Driver_V#{version}.dmg"
  name "Samsung Universal Print Driver"
  desc "Print driver for Samsung printers (C410, C43x, M2020 series)"
  homepage "https://support.hp.com/"

  pkg "MAC_Printer/Printer Driver.pkg"

  uninstall pkgutil: "com.samsung.*"
end
