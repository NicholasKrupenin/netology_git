### <span style="color:yellow">Задание 1.</span>

![](/Security/img/cryptouser_1.jpg)
![](/Security/img/cryptouser_2.jpg)
![](/Security/img/cryptouser_3.jpg)

---
### <span style="color:yellow">Задание 2.</span>

```bash
sudo dd if=/dev/urandom of=/root/secret.key bs=1024 count=2
sudo chmod 0400 /root/secret.key
cryptsetup luksFormat /dev/sdb1 /root/secret.key
cryptsetup luksAddKey /dev/sdb1 /root/secret.key --key-file=/root/secret.key
cryptsetup luksOpen /dev/sdb1 secret --key-file=/root/secret.key
cryptsetup resize secret
mkfs.ext4 /dev/mapper/secret
sudo mkdir -p /secret
sudo chmod 755 /secret
mount /dev/mapper/secret /secret
```

