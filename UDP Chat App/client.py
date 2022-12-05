import socket

sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)

udp_host = "127.0.0.1"
udp_port = 4567

while True:
    msg = input("CLIENT:: ")
    if not msg:
        break

    sock.sendto(msg.encode(), (udp_host, udp_port))
    
    data, addr = sock.recvfrom(1024)
    
    if not data:
        break
    
    print("SERVER:: ", data.decode())
