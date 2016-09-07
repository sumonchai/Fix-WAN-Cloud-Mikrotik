# Fix-WAN-Cloud-Mikrotik
Help Script Fix route cloud mikrotik to wan

# Fix-WAN-Cloud-Mikrotik

- เพิ่ม-ลบ IP Route ให้เรา อัตโนมัติจากการ get dns


### กำหนดเส้นทางให้ Cloud Mikrotik ออก Wan ที่เราต้องการ

####:local wan "2"; # << WAN ที่ต้องการ ตัวอย่างเลข 2

### อ้างอิงชื่อ WAN
####gateway=("WAN" . $wan)


