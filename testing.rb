require 'wmi-lite'

# Connect to the WMI namespace
wmi = WmiLite::Wmi.new

# Query for Win32_CDROMDrive class to find DVD drives
dvd_drives = wmi.query('SELECT * FROM Win32_CDROMDrive')

if dvd_drives.empty?
  puts 'No DVD drives found.'
else
  puts 'DVD Drives:'
  dvd_drives.each do |drive|
    puts "Device ID: #{drive['DeviceID']}"
    puts "Drive Name: #{drive['Name']}"
    puts "Drive Manufacturer: #{drive['Manufacturer']}"
    puts "Drive Description: #{drive['Description']}"
    puts
  end
end
