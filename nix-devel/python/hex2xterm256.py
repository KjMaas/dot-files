import sys
from x256 import x256

hex_value = sys.argv[-1]

x256_color = x256.from_hex(f'{hex_value}')
# print(hex_value)
print(x256_color)
