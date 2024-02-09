# #!/bin/bash

# # 检查是否提供了正确数量的参数
# if [ "$#" -ne 1 ]; then
#     echo "Usage: $0 <folder_name>"
#     exit 1
# fi


# folder_name="$1"
# executable_name="a.out"
# test_folder="$folder_name/cases"

# # 编译 C++ 源文件
# g++ "$folder_name/main.cpp" -o "$folder_name/$executable_name"

# # 检查编译是否成功
# if [ $? -eq 0 ]; then
#     echo "Compilation successful."

#     # 遍历测试用例文件夹
#     for test_case in "$test_folder"/*; do
#         if [ -f "$test_case" ]; then
#             echo "Running test case: $test_case"
            
#             # 运行测试用例
#             "$folder_name/$executable_name" < "$test_case"

#             # 检查程序的返回值
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

# 检查是否提供了正确数量的参数
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <folder_name>"
    exit 1
fi

folder_name="$1"
executable_name="a.out"
test_folder="$folder_name/cases"
expected_output_folder="$folder_name/expected_output"

# 编译 C++ 源文件
g++ "$folder_name/main.cpp" -o "$folder_name/$executable_name"

# 检查编译是否成功
if [ $? -eq 0 ]; then
    echo "Compilation successful."

    # 遍历测试用例文件夹
    for test_case in "$test_folder"/*; do
        if [ -f "$test_case" ]; then
            echo "Running test case: $test_case"
            
            # 运行测试用例并将结果保存到临时文件
            output_file=$(mktemp)
            "$folder_name/$executable_name" < "$test_case" > "$output_file"

            # 比较实际输出与预期输出
            expected_output_file="$expected_output_folder/$(basename "$test_case")"
            echo "Output:"
            cat $output_file

            if cmp -s $output_file $expected_output_file; then
                echo "Test case passed."
            else
                echo "Test case failed. Expected output:"
                cat "$expected_output_file"
            fi

            # 删除临时文件
            rm -f "$output_file"
        fi
    done
else
    echo "Compilation failed."
fi
