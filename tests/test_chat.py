from unittest.mock import Mock

from src.utils.chat import chat_extended


def test_chat_extended_drops_trailing_assistant_prefill():
    client = Mock()
    client.messages.create.return_value = Mock(content=[Mock(text="done")])

    messages = [
        {"role": "user", "content": "Please answer"},
        {"role": "assistant", "content": "prefill"},
    ]

    chat_extended(client, "claude-sonnet-4-6", messages)

    sent_messages = client.messages.create.call_args.kwargs["messages"]
    assert sent_messages == [{"role": "user", "content": "Please answer"}]
