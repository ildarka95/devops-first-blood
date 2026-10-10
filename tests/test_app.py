import subprocess
import time
import requests
import sys


def test_app_responds():
    proc = subprocess.Popen([sys.executable, "app.py"])
    try:
        # Ждем, пока сервер поднимется (максимум 5 секунд)
        for _ in range(50):
            try:
                r = requests.get("http://localhost:8080", timeout=1)
                break
            except requests.ConnectionError:
                time.sleep(0.1)
        else:
            raise AssertionError("Server did not start in time")

        assert r.status_code == 200
        assert "alive" in r.text.lower()
    finally:
        proc.terminate()
        proc.wait(timeout=5)