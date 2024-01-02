def test_hello_world_message():
    with open("index.html", "r") as file:
        content = file.read()
        assert "Hello World!" in content
