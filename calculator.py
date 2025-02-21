import math


def square_root(x):
    return math.sqrt(x)


def factorial(x):
    return math.factorial(x)


def natural_log(x):
    if x <= 0:
        raise ValueError("Natural log is only defined for positive numbers.")
    return math.log(x)


def power(x, b):
    return math.pow(x, b)


def main():
    while True:
        print("\nScientific Calculator")
        print("1. Square Root (√x)")
        print("2. Factorial (x!)")
        print("3. Natural Logarithm (ln(x))")
        print("4. Power Function (x^b)")
        print("5. Exit")

        choice = input("Choose an operation (1-5): ")

        if choice == "1":
            x = float(input("Enter a number: "))
            print("Result:", square_root(x))
        elif choice == "2":
            x = int(input("Enter a number: "))
            print("Result:", factorial(x))
        elif choice == "3":
            x = float(input("Enter a number: "))
            print("Result:", natural_log(x))
        elif choice == "4":
            x = float(input("Enter the base: "))
            b = float(input("Enter the exponent: "))
            print("Result:", power(x, b))
        elif choice == "5":
            print("Exiting...")
            break
        else:
            print("Invalid choice. Please try again.")


if __name__ == "__main__":
    main()
