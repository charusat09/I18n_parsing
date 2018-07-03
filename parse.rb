file = File.open("index.html.erb", 'a+')
line_number = 0
file.each do |line|
  line_number += 1
  if line.include? '***'
    file_path = File.expand_path(__FILE__)
    file_path_in_keys = file_path.gsub('/','.')
    file_path_in_keys[0] = ''

    rough_key = /(?<=\*\*\*).*(?=\*\*\*)/.match line
    key = rough_key.to_s.downcase.gsub(/\-|\,|\.|\'/, '').split(/\s|\-/).join("_")

    File.open("log.txt", 'a') {|f|
      f.write("\n")
      f.write("#{file_path}:#{line_number} --> #{key}: #{rough_key}")
      f.write("\n")
      f.write(file_path_in_keys)
    }

    original_line = "***"+rough_key.to_s+"***"
    updated_line = line.gsub original_line, key
    File.write(file, File.read(file).gsub(original_line,key))
  end
end
