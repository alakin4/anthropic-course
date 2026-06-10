import os

from dotenv import load_dotenv

from src.main import main


def test_main_returns_env_variable():
    """
    Test the main function to ensure it returns the expected environment variable.
    """
    load_dotenv()
    expected = os.getenv("GREETING")
    result = main()
    assert result == expected
