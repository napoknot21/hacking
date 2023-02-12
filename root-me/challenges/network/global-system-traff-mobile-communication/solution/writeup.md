# Global System Traffic for Mobile communications

after decompressing the zip file, open the file with ```WireShark```
```
wireshark ch9.pcap
```

Analysing the capture, we notice ```87``` frame has a greater package length than the others
```
87	230.766381	Modem	Unknown	ISI	126	
```

Checking its details, we see the following data
```
Frame 87: 126 bytes on wire (1008 bits), 96 bytes captured (768 bits)
Linux cooked capture v1
    Packet type: Unicast to us (0)
    Link-layer address type: PhoNet media type (820)
    Link-layer address length: 1
    Source: a0
    Unused: 00202020202020
    Protocol: ISI (0x00f5)
Intelligent Service Interface
    Receiver Device: Unknown (0xa0)
    Sender Device: Modem (0x00)
    Resource: Call (0x01)
    Length: 105
    Receiver Object: 0x00
    Sender Object: 0x00
    Packet ID: 103
    Data (72 bytes)
        Data: 00ff9c0402030201ffff0b5a0791233010210068040b917120336603f800002140206165…
        [Length: 72]

```

Focus on the data, let's analyse the value
```
Data: 00ff9c0402030201ffff0b5a0791233010210068040b917120336603f800002140206165028047c7f79b0c52bfc52c101d5d0699d9e133283d0785e764f87b6da7956bb7f82d2c8b
```

Checking the ```SMS-PDU``` structure, it seems that the encodage starts by `0791`, so let's *clean* the data value
```
Data: 00ff9c0402030201ffff0b5a0791233010210068040b917120336603f800002140206165028047c7f79b0c52bfc52c101d5d0699d9e133283d0785e764f87b6da7956bb7f82d2c8b
```
by
```
Data: 0791233010210068040b917120336603f800002140206165028047c7f79b0c52bfc52c101d5d0699d9e133283d0785e764f87b6da7956bb7f82d2c8b
```
> We just deleted the **00ff9c0402030201ffff0b5a** from the begining !

Use an online tool for decodin, we have the following output
```
Text message
From:	
+17023366308

Message:	
Good job, the flag is asdpokv4e57q7a2

...
```

So, the flag is 
```
asdpokv4e57q7a2
```
