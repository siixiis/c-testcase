#!/bin/bash

# ����Ƿ��ṩ����ȷ�����Ĳ���
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <folder_name>"
    exit 1
fi

folder_name="$1"
main_file="$folder_name/main.cpp"
cases_folder="$folder_name/cases"
expected_output_folder="$folder_name/expected_output"

# ����ļ����Ƿ���ڣ����������ֹͣ����
if [ -d "$folder_name" ]; then
    echo "Folder '$folder_name' already exists. Exiting."
    exit 1
fi

# �����ļ���
mkdir "$folder_name"
mkdir "$cases_folder"
mkdir "$expected_output_folder"

# ���ļ����д��� main.cpp
echo -e "#include <iostream>\n\nint main() {\n    // Your code here\n    std::cout << \"Hello, World!\" << std::endl;\n    return 0;\n}" > "$main_file"

# �� cases �ļ��к� expected_output �ļ����д��� 1.txt
touch "$cases_folder/1.txt"
touch "$expected_output_folder/1.txt"

echo "Folder creation and file creation successful."
