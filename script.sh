#! /bin/bash
set -ex
TEXTE=$(curl https://power-plugins.com/api/flipsum/ipsum/lorem-ipsum?paragraphs=3&start_with_fixed=1)
echo $TEXTE > /tmp/lorem.txt
