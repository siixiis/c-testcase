# #!/bin/bash

# # ����Ƿ��ṩ����ȷ�����Ĳ���
# if [ "$#" -ne 1 ]; then
#     echo "Usage: $0 <folder_name>"
#     exit 1
# fi


# folder_name="$1"
# executable_name="a.out"
# test_folder="$folder_name/cases"

# # ���� C++ Դ�ļ�
# g++ "$folder_name/main.cpp" -o "$folder_name/$executable_name"

# # �������Ƿ�ɹ�
# if [ $? -eq 0 ]; then
#     echo "Compilation successful."

#     # �������������ļ���
#     for test_case in "$test_folder"/*; do
#         if [ -f "$test_case" ]; then
#             echo "Running test case: $test_case"
            
#             # ���в�������
#             "$folder_name/$executable_name" < "$test_case"

#             # ������ķ���ֵ
#             if [ $? -eq 0 ]; then
#                 echo "Test case passed."
#             else
#                 echo "Test case failed."
#             fi
#         fi
#     done
# else
#     echo "Compilation failed."
# fi
#!/bin/bash

# ����Ƿ��ṩ����ȷ�����Ĳ���
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <folder_name>"
    exit 1
fi

folder_name="$1"
executable_name="a.out"
test_folder="$folder_name/cases"
expected_output_folder="$folder_name/expected_output"

# ���� C++ Դ�ļ�
g++ "$folder_name/main.cpp" -o "$folder_name/$executable_name"

# �������Ƿ�ɹ�
if [ $? -eq 0 ]; then
    echo "Compilation successful."

    # �������������ļ���
    for test_case in "$test_folder"/*; do
        if [ -f "$test_case" ]; then
            echo "Running test case: $test_case"
            
            # ���в�����������������浽��ʱ�ļ�
            output_file=$(mktemp)
            "$folder_name/$executable_name" < "$test_case" > "$output_file"

            # �Ƚ�ʵ�������Ԥ�����
            expected_output_file="$expected_output_folder/$(basename "$test_case")"
            echo "Output:"
            cat $output_file

            if cmp -s $output_file $expected_output_file; then
                echo "Test case passed."
            else
                echo "Test case failed. Expected output:"
                cat "$expected_output_file"
            fi

            # ɾ����ʱ�ļ�
            rm -f "$output_file"
        fi
    done
else
    echo "Compilation failed."
fi
