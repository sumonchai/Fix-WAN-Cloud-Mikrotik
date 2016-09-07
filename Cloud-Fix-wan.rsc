{
#----------------------------------#
# เอาไปแจก ไม่เครดิต ประจาน :)
# Cloud Mikrotik FIX Out
# Support PPPoE WAN
# fb.com/ljtechnology
# ตัวอย่างส่วนหนึ่งจาก Mikrotik http://forum.mikrotik.com/
#----------------------------------#
:local wan "2"; # << WAN ที่ต้องการ ตัวอย่างเลข 2
#----------------------------------#
:local IPs
:local data
:set IPs ""
:set data ""
:foreach i in=[/ip dns cache all find where (name~"cloud.mikrotik.com") && \
  (type="A") ] do={:set $data [/ip dns cache get $i address];
    :put $data
    :set IPs ($IPs . $data . ",")
    :delay delay-time=10ms;
}
:put ("cloud.mikrotik.com IP search found " . [:len [:toarray $IPs]])

/ip route {
    :local findex; :local listaddr; :local listaddrs; :local IPsFound ""
    #:put ("Searching list ...")
    :foreach l in=[find comment~"Cloud mikrotik fix"] do={ \
        :set listaddrs [get $l dst-address]
        :for i from=( [:len $listaddrs] - 1) to=0 do={ \
          :if ( [:pick $listaddrs $i] = "/") do={\
          :put [:pick $listaddrs 0 $i]
        :set listaddr [:pick $listaddrs 0 $i]
        :put ("LIST: " . $listaddr)}}
        :put $IPs
        :if ([:len [:find [:toarray $IPs] [:toip $listaddr]]] = 0) do={
            :put ("   " . $IPs .":" . $listaddr . " not found in search, removing...")
            remove $l
        } else={
            :put ($IPs . ":" . $listaddr . " found address in IPs \r\n")
            :set IPsFound ($IPsFound . $listaddr . ",")
            :put ("IPsFound " . $IPsFound )
          #  remove $l
        }
      }
    :set findex 0
    :foreach ip in=[:toarray $IPs] do={
    :put $IPs
    #:put ("ip " . $ip)
       :if ([:len [:find [:toarray $IPsFound] [:toip $ip]]] = 0) do={
         :put ("   Adding address " . $ip)
        add dst-address=[:toip $ip] comment="Cloud mikrotik fix" \
          disabled=no gateway=("WAN" . $wan)
       }
       :set findex ($findex + 1)
       :put $findex
    }
}}}
