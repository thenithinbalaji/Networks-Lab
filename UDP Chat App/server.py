import socket

sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)

udp_host = "127.0.0.1"
udp_port = 4567

sock.bind((udp_host, udp_port))

while True:
    data, addr = sock.recvfrom(1024)

    if not data:
        break
    
    print("CLIENT:: ", data.decode())

    inp = input("SERVER:: ")

    if not inp:
        break
    
    sock.sendto(inp.encode(), (udp_host, udp_port))

sock.close()
