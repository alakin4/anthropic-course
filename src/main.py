import os

from dotenv import load_dotenv

load_dotenv()  # Load variables from .env


def main() -> str:
    """
    Main function to execute the script.

    This function serves as the entry point for the script and contains the main logic.
    It can be modified to include any functionality required for the project.
    """
    greeting = os.getenv("GREETING", "Hello, World!")
    print(greeting)
    return greeting


if __name__ == "__main__":
    main()
