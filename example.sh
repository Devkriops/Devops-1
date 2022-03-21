 grep -r --include *.[wj]ar "JndiLookup.class" / 2>&1 | grep matches | grep -v '2.17.0' >> /home/scguser/OUTPUTFILE
 find / -iname 'log4j*.jar' 2>/dev/null | grep -v '2.17.0' >> /home/scguser/OUTPUTFILE 

 grep -r --include *.[wj]ar "JndiLookup.class" / 2>&1 | grep matches >> /home/scguser/#{node['hostname']}
 find / -iname 'log4j*.jar' >> /home/scguser/#{node['hostname']}  2>/dev/null
