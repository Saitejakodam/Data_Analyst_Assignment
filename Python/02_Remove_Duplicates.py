def remove_duplicates(input_string):
    result = ""

    for char in input_string:
        if char not in result:
            result += char

    return result

user_input = input("Enter a string: ")
output = remove_duplicates(user_input)
print("Unique string:", output)
