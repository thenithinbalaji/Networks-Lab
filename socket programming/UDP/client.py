#one way
import socket

s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)

HOST = "127.0.0.1"
PORT = 4567

while True:
    data = input("Enter:: ")

    if not data:
        break

    s.sendto(data.encode(), (HOST, PORT))
    