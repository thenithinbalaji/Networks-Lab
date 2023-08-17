# run server before client
import socket

class Server:
    def __init__(self, host="127.0.0.1", port=3456):
        self.host = host
        self.port = port
        self.s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

    def bind_and_listen(self):
        try:
            self.s.bind((self.host, self.port))
            self.s.listen()
        except socket.error as e:
            print(f"Socket error: {e}")
            return False
        return True

    def accept_connections(self):
        try:
            self.conn, self.addr = self.s.accept()
        except socket.error as e:
            print(f"Socket error: {e}")
            return False
        return True

    def receive_and_send_data(self):
        while True:
            try:
                data = self.conn.recv(1024)
                if not data:
                    break
                print(f"CLIENT:: {data.decode()}")
                self.conn.sendall(input("SERVER:: ").encode())
            except socket.error as e:
                print(f"Socket error: {e}")
                break

    def close_connection(self):
        self.conn.close()
        self.s.close()

server = Server()
if server.bind_and_listen():
    if server.accept_connections():
        server.receive_and_send_data()
    server.close_connection()
