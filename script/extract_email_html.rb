#!/usr/bin/env ruby

# Arguments
infile = ARGV[0]
environment = ARGV[1] || 'development'

if infile.nil?
  puts <<INFO
Usage: extract_email_html.rb infile <environment>
Takes a raw email and prints out the html body decoded
INFO
  exit
end

ENV['RAILS_ENV'] = environment
SCRIPT_FOLDER = File.expand_path(File.join(File.dirname(__FILE__)))

require File.join(SCRIPT_FOLDER, '../config/environment.rb')
require 'mail'

raw_email = File.new(infile, "r")
mail = Mail.new(raw_email.read)

if mail.parts.length > 0
  mail.parts.each do |part|
    puts part.body.decoded  if part.content_type =~ /text\/html/
  end
else
  puts mail.body.decoded
end
