#chat app
import socket

s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

HOST = "127.0.0.1"
PORT = 3456

s.connect((HOST, PORT))

while True:
    data = input("CLIENT:: ")

    if not data:
        break

    s.sendall(data.encode())
    newdata = s.recv(1024)

    if not newdata:
        break

    print("SERVER:: ", newdata.decode())
