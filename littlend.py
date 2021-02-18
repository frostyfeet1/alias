
import sys

if (len(sys.argv) < 2) :
    print("usgae: script <hex_address>")
else:
    n = 2


    line = "0xdeadbeef"

    line = sys.argv[1]
    line = line.replace("0x","")
    print(line)


    list = [line[i:i+n] for i in range(0, len(line), n)]

    list1 = list[::-1]

    for i in list1:
        print("\\x" + i,end="")
