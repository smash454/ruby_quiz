require_relative 'Encrypt'

input = ARGV[1]

if ARGV[0] == "encrypt"
  e = Encrypt.new(input)
  e.encode
  puts e.encrypted
end

if ARGV[0] == "decrypt"
  d = Encrypt.new(input)
  d.decode
  puts d.decrypted
end

