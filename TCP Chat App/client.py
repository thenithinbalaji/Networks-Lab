# run server before client
import socket

class Client:
    def __init__(self, host="127.0.0.1", port=3456):
        self.host = host
        self.port = port
        self.s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

    def connect(self):
        try:
            self.s.connect((self.host, self.port))
        except socket.error as e:
            print(f"Socket error: {e}")
            return False
        return True

    def send_and_receive_data(self):
        while True:
            try:
                data = input("CLIENT:: ")
                if not data:
                    break
                self.s.sendall(data.encode())
                newdata = self.s.recv(1024)
                if not newdata:
                    break
                print("SERVER:: ", newdata.decode())
            except socket.error as e:
                print(f"Socket error: {e}")
                break

    def close_connection(self):
        self.s.close()

client = Client()
if client.connect():
    client.send_and_receive_data()
client.close_connection()
