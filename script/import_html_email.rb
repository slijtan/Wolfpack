# Arguments
infile = ARGV[0]
carrier = ARGV[1]

if infile.nil? || carrier.nil?
  puts <<INFO
Usage: import_html_email.rb infile carrier
Imports html contents of an email into our flights db
INFO
  exit
end

email_html = File.new(infile, "r")

p y Flight.send("import_#{carrier}_email", email_html.read)
