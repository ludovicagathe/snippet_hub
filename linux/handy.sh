# list files in a directory and sort by size
du -sch .[!.]* * |sort -h

# convert word files to .txt with LibreOffice
libreoffice --headless --convert-to "txt:Text (encoded):UTF8" mydocument.doc
