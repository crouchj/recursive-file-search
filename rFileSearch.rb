require 'find'

args = Hash[ ARGV.join(' ').scan(/--?([^=\s]+)(?:=(\S+))?/) ]

args['dir'] ||= Dir.pwd unless 
args['ext'] ||= ".*"
args['s']   ||= ""
args['r']   ||= ""

file_paths = []
begin
  Find.find(args['dir']) do |path|
    file_paths << path if path =~ /.*\.#{args['ext']}$/
  end
rescue
  puts "ERROR: No such file or directory!"
end

file_paths.each do |file_name|
  text = File.read(file_name)
  new_contents = text.gsub(/#{args['s']}/, args['r'])

  # To write changes to the file, use:
  File.open(file_name, "w") {|file| file.puts new_contents }
end