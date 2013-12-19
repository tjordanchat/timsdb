all: serv

rel.1:
        ./display_releases > %@

rel.dot: rel.1
        ./process < data > %@
        echo "}" >>%@

prel.gif: rel.dot
        neato -Tgif rel.dot -o %@

rel.gif: prel.gif
        convert rel.gif -font Courier-Bold -pointsize 72  -draw "text 1200,100 'Development'"  -draw "text 1360,400 'UAT'"  -draw "text 1360,700 'SIT'"  -draw "text 1200,1000 'Production'"  rel1.gif

serv: rel.gif
        server 8484
