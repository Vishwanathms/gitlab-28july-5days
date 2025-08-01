# test_app.py
def test_hello():
    from app import hello
    assert hello() == "Hello, GitLab Auto DevOps!"
