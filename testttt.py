# test.py

def greet(name):
    """
    This function greets the given name.
    """
    return f"Hello, {name}! Welcome to the test file."

def add_numbers(a, b):
    """
    This function adds two numbers and returns their sum.
    """
    return a + b

if __name__ == "__main__":
    # This block gets executed when the script is run directly

    print("--- Running test.py ---")

    # Example 1: Using the greet function
    user_name = "Alice"
    message = greet(user_name)
    print(message) # Expected: Hello, Alice! Welcome to the test file.

    # Example 2: Using the add_numbers function
    num1 = 10
    num2 = 5
    sum_result = add_numbers(num1, num2)
    print(f"The sum of {num1} and {num2} is: {sum_result}") # Expected: The sum of 10 and 5 is: 15

    # You can add more test cases or code here
    print("\n--- Test complete ---")
