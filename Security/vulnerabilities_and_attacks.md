### <span style="color:yellow">Задание 1.</span>

* Enable service

PORT|STATE|SERVICE|
|--|--|--|
|21/tcp|open|ftp|
|22/tcp|open|ssh|
|23/tcp|open|telnet|
|25/tcp|open|smtp|
|53/tcp|open|domain|
|80/tcp|open|http|
|111/tcp|open|rpcbind|
|139/tcp|open|netbios-ssn|
|445/tcp|open|microsoft-ds|
|512/tcp|open|exec|
|513/tcp|open|login|
|514/tcp|open|shell|
|1099/tcp|open|rmiregistry|
|1524/tcp|open|ingreslock|
|2049/tcp|open|nfs|
|2121/tcp|open|ccproxy-ftp|
|3306/tcp|open|mysql|
|5432/tcp|open|postgresql|
|5900/tcp|open|vnc|
|6000/tcp|open|X11|
|6667/tcp|open|irc|
|8009/tcp|open|ajp13|
|8180/tcp|open|unknown|



1. Samba 3.5.0 - Remote Code Execution
2. vsftpd 2.3.4 - Backdoor Command Execution
3. ProFTPd 1.2 < 1.3.0 (Linux) - 'sreplace' Remote Buffer Overflow (Metasploit)

---
### <span style="color:yellow">Задание 2.</span>

1. SYN
   - Идет SYN запрос на порт, если он открыт то возвращается ответ [SYN, ACK], далее идет закрытие соединения [RST] 

2. FIN
   - Идет запрос на порт с флагом [ACK], обратный ответ всегда идет с флагом [RST]

3. Xmas 
   - Запрос на порт с флагами [FIN, PSH, URG], если порт закрыт возвращает [RST, ACK]

3. UDP 
   - Запрос на порт, если порт закрыт возвращает ICMP ответ Port unreachable.

