require 'mail'

# Arguments
infile = ARGV[0]

if infile.nil?
  puts <<INFO
Usage: extract_email_html.rb infile
Takes a raw email and prints out the html body decoded
INFO
  exit
end

raw_email = File.new(infile, "r")
mail = Mail.new(raw_email.read)

if mail.parts.length > 0
  mail.parts.each do |part|
    puts part.body.decoded  if part.content_type =~ /text\/html/
  end
else
  puts mail.body.decoded
end
