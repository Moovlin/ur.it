'''
    Simple socket server using threads
'''
from flask import Flask
import socket
import sys
import threading
import io




app = Flask(__name__)

@app.route("/add")
def playerAdd():
	
@app.route("/it")
def whosIt():
	return 

HOST = ''   # Symbolic name, meaning all available interfaces
PORT = 8888 # Arbitrary non-privileged port


s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

print('Socket created')

#Bind socket to local host and port
try:
    s.bind((HOST, PORT))
except socket.error as msg:
    print('Bind failed.')
    sys.exit()

print('Socket bind complete')

#Start listening on socket
s.listen(10)
print('Socket now listening')

threads = []

#now keep talking with the client
while 1:
    #wait to accept a connection - blocking call
    conn, addr = s.accept()
    print('Connected with ' + addr[0] + ':' + str(addr[1]))
    newThread = threading.Thread(target=player)
    newThread.start()
    threads.append(newThread)


s.close()
