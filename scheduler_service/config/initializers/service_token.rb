begin
  puts 'reading token from config/token.txt'
  ::TOKEN = File.read('config/token.txt')
rescue Errno::ENOENT
  puts 'not found, generating'
  ::TOKEN = SecureRandom.hex(16)
  File.open("config/token.txt", 'w') {|f| f.write(::TOKEN) }
end

puts 'service token: ', ::TOKEN