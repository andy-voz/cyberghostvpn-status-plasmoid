#!/bin/bash
rm -r .build
mkdir -p .build/com.andyvoz.plasmoid.cyberghoststatus

rsync -a metadata.desktop .build/com.andyvoz.plasmoid.cyberghoststatus/
rsync -a contents .build/com.andyvoz.plasmoid.cyberghoststatus/

cd .build
tar -czvf cyberghoststatus.tar.gz com.andyvoz.plasmoid.cyberghoststatus
cd -