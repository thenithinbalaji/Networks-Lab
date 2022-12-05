#one way
import socket 

s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)

HOST = "127.0.0.1"
PORT = 4567

s.bind((HOST, PORT))

while True:
    data, addr = s.recvfrom(1024)

    if not data:
        break

    print(data.decode(), addr)