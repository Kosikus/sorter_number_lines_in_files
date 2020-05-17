# получение относительных путей к .txt файлам в текущей папке
file_paths = Dir[File.join(__dir__, '*.txt')]

# запись содержимого каждого из файлов построчно в массив (массив массивов строк)
files = file_paths.map { |file_path| File.readlines(file_path, encoding: 'UTF-8', chomp: true) }

# удаление пустых строк в каждом из файлов
files.each do |file|
  file.delete_if { |line| line.chomp.empty? }
end

# сортировка строк по возрастанию (числовому) в каждом из файлов
files = files.map { |file| file.sort { |a, b| a.to_i <=> b.to_i } }

# перезапись каждых из файлов файлами с отсортированными строками
file_paths.each_with_index { |file_path, index| File.write(file_path, files[index].join("\n")) + "\n"}
