#!/bin/bash

# 检查是否提供了正确数量的参数
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <folder_name>"
    exit 1
fi

folder_name="$1"
main_file="$folder_name/main.cpp"
cases_folder="$folder_name/cases"
expected_output_folder="$folder_name/expected_output"

# 检查文件夹是否存在，如果存在则停止程序
if [ -d "$folder_name" ]; then
    echo "Folder '$folder_name' already exists. Exiting."
    exit 1
fi

# 创建文件夹
mkdir "$folder_name"
mkdir "$cases_folder"
mkdir "$expected_output_folder"

# 在文件夹中创建 main.cpp
echo -e "#include <iostream>\n\nint main() {\n    // Your code here\n    std::cout << \"Hello, World!\" << std::endl;\n    return 0;\n}" > "$main_file"

# 在 cases 文件夹和 expected_output 文件夹中创建 1.txt
touch "$cases_folder/1.txt"
touch "$expected_output_folder/1.txt"

echo "Folder creation and file creation successful."
