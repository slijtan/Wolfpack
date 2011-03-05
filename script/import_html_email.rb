#!/usr/bin/env ruby

# Arguments
infile = ARGV[0]
carrier = ARGV[1]
environment = ARGV[2] || 'development'

if infile.nil? || carrier.nil?
  puts <<INFO
Usage: import_html_email.rb infile carrier <environment>
Imports html contents of an email into our flights db
INFO
  exit
end

ENV['RAILS_ENV'] = environment
SCRIPT_FOLDER = File.expand_path(File.join(File.dirname(__FILE__)))

require File.join(SCRIPT_FOLDER, '../config/environment.rb')

email_html = File.new(infile, "r")

Flight.send("import_#{carrier}_email", email_html.read)
