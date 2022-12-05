#chat app
import socket

s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

HOST = "127.0.0.1"
PORT = 3456

s.bind((HOST, PORT))

s.listen()

conn, addr = s.accept()

while True:
    data = conn.recv(1024)

    if not data:
        break

    print(f"CLIENT:: {data.decode()}")

    conn.sendall(input("SERVER:: ").encode())

