from typing import Any
def add_user_message(messages: list[dict[str, str]], text: str) -> None:
    messages.append({"role": "user", "content": text})


def add_assistant_message(messages: list[dict[str, str]], text: str) -> None:
    messages.append({"role": "assistant", "content": text})


def chat(client, model, messages):
    response = client.messages.create(
        model=model,
        max_tokens=1000,
        messages=messages,
    )
    return response.content[0].text


def chat_with_system_prompt(
    client,
    model,
    messages,
    system_prompt=None,
    temperature=0.1,
):
    params = {
        "model": model,
        "max_tokens": 1000,
        "messages": messages,
        "temperature": temperature,
    }
    if system_prompt:
        params["system"] = system_prompt

    response = client.messages.create(**params)
    return response.content[0].text


def chat_extended(
    client: Any,
    model: str,
    messages: list[dict[str, str]],
    *,
    system_prompt: str | None = None,
    temperature: float = 0.1,
    max_tokens: int = 1000,
    stop_sequences: list[str] | None = None,
):
    if not messages:
        raise ValueError("Messages list cannot be empty.")

    if messages[-1]["role"] == "assistant":
        raise ValueError("The conversation cannot end with an assistant message." \
        "Assistant prefilling is not supported by selected model.")
    
    params = {
        "model": model,
        "max_tokens": max_tokens,
        "messages": messages,
        "temperature": temperature,
    }
    if system_prompt:
        params["system"] = system_prompt

    if stop_sequences:
        params["stop_sequences"] = stop_sequences

    response = client.messages.create(**params)

    text_blocks = [content.text for content in response.content if hasattr(content, "text")]

    if not text_blocks:
        raise ValueError("No text content returned from the model.")
    return text_blocks
