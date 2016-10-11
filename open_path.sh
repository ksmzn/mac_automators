#!/bin/bash
function mount_configure () {
    arr=( `echo $1 | tr -s '\\' ' '`)
    KEYCHAIN=${arr[0]}
    MOUNTNAME=${arr[1]}
    MOUNTPOINT='/Volumes/'$MOUNTNAME
    USERNAME=`security find-internet-password -gs ${KEYCHAIN} 2>/dev/null |grep "acct"|sed -e 's/"acct"<blob>="//' -e's/"//' -e's/^ *//g'`
    PASSWORD=`security find-internet-password -gs ${KEYCHAIN} -w`
}

function mount_path () {
    mount_configure $1
    mkdir -p ${MOUNTPOINT}
    mount_smbfs smb://${USERNAME}:${PASSWORD}@${KEYCHAIN}/${MOUNTNAME} ${MOUNTPOINT}
}

function open_path () {
    mount_path $1
    arr[0]='/Volumes'
    IFS=/ eval 'str="${arr[*]}"'
    mount -v | grep $MOUNTNAME
    if [ $? -eq 0 ]; then
        open $str
    fi
}

for f in "$@"
do
	open_path "$f"
done
