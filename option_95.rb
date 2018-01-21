def zero(str,num)
  v=str.to_s
  while v.length<num
    v="0"+v
  end
  return v
end
def option_95(ipv6_prefix,ipv6_prefix_len,ipv6_dmr,ipv6_dmr_len,ea_len,psid_off,ipv4a,ipv4_prefix_len,ipv6_pre)
  #定义变量
  option_95="005f"
  option_89="0059"
  option_91="005b"
  option_93="005d"
  #psid
  str=ipv6_prefix.split('::')[0].split(':')
  len=str.size
  ipv6_ad=""
  len.times do |i|
    ipv6_ad=ipv6_ad+zero(str[i],4)
  end
  psid_len=(ea_len-(32-ipv4_prefix_len))
  v6len=ipv6_ad.length
  psid=ipv6_ad[v6len-(psid_len/4)..v6len-1]
  #option93
  if  ipv4_prefix_len+ea_len<=32
    option_93=""
  else
    option_93=option_93+"0004"+"#{zero(psid_off.to_s(16),2)}"+"#{zero(psid_len.to_s(16),2)}"+"#{zero(psid,4)}"
  end
  #option89
  ipv6_pre=ipv6_pre.delete(":")
  option_89_len=8+ipv6_pre.length/2+option_93.length/2
  option_89=option_89+"#{zero(option_89_len.to_s(16),4)}"+"00"+"#{ea_len.to_s(16)}"+"#{ipv4_prefix_len.to_s(16)}"+ipv4a+"#{ipv6_prefix_len.to_s(16)}"+ipv6_pre
  #option91
  ipv6_dmr_ad=ipv6_dmr.delete(":")
  option_91=option_91+"#{zero((1+ipv6_dmr_ad.length/2).to_s(16),4)}"+"#{ipv6_dmr_len.to_s(16)}"+ipv6_dmr_ad
  #option95
  option_95_len=(option_89.length+option_93.length+option_91.length)/2
  option_95=option_95+"#{zero(option_95_len.to_s(16),4)}"
  return option=option_95+option_89+option_93+option_91
end
puts str=option_95(@ipv6_prefix,@ipv6_prefix_len,@ipv6_dmr,@ipv6_dmr_len,@ea_len,@psid_off,@ipv4a,@ipv4_prefix_len,@ipv6_pre)
puts str.upcase