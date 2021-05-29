import socket
import os
import subprocess
from datetime import datetime

class MineStat:
  NUM_FIELDS = 6                # number of values expected from server
  NUM_FIELDS_BETA = 3           # number of values expected from a 1.8b/1.3 server
  DEFAULT_TIMEOUT = 5           # default TCP timeout in seconds

  def enum(**enums):
    return type('Enum', (), enums)

  Retval = enum(SUCCESS = 0, CONNFAIL = -1, TIMEOUT = -2, UNKNOWN = -3)

  def __init__(self, address, port, timeout = DEFAULT_TIMEOUT):
    self.address = address
    self.port = port
    self.online = None          # online or offline?
    self.version = None         # server version
    self.motd = None            # message of the day
    self.current_players = None # current number of players online
    self.max_players = None     # maximum player capacity
    self.latency = None         # ping time to server in milliseconds

    # Connect to the server and get the data
    byte_array = bytearray([0xFE, 0x01])
    raw_data = None
    data = []
    try:
      sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
      sock.settimeout(timeout)
      start_time = datetime.now()
      sock.connect((address, port))
      self.latency = datetime.now() - start_time
      self.latency = int(round(self.latency.total_seconds() * 1000))
      sock.settimeout(None)
      sock.send(byte_array)
      raw_data = sock.recv(512)
      sock.close()
    except:
      self.online = False

    # Parse the received data
    if raw_data is None or raw_data == '':
      self.online = False
    else:
      data = raw_data.decode('cp437').split('\x00\x00\x00')
      if data and len(data) >= self.NUM_FIELDS:
        self.online = True
        self.version = data[2].replace("\x00", "")
        self.motd = data[3].encode('utf-8').replace(b"\x00", b"")
        self.current_players = data[4].replace("\x00", "")
        self.max_players = data[5].replace("\x00", "")
      else:
        self.online = False

if __name__ == "__main__":
    servers = { "mde": MineStat("mdecraft.com", 25565)
              , "lfw": MineStat("mc.lachlans.world", 25565) }

    server_info = [] 
    for name, stats in servers.items():
        if stats.online:
            server_info += [f"{name}: ({stats.current_players}/?)"]
        else:
            server_info += [f"{name} died :("]

    print(" * ".join(server_info))
