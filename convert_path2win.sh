python -c "import sys
from ntpath import split
n = (len(sys.argv) - 1) / 2
li = sys.argv[1:(1+n)]
for i, path in enumerate(li):
    spr = path.split('/')
    if i == 0 and spr[1] == 'Volumes':
        if spr[2] == 'share':
            spr[1] = 'legspin'
        else:
            spr[1] = 'uva'
    out = '\\\'+'\\\'.join(spr)
    path, file_name_ext = split(out)
    if i == 0:
        print(path)
    print(file_name_ext)
" "$@";
