# hadoop roll

MAVEN=/opt/maven

BIN=$MAVEN/bin

if [ -d ${BIN} ]; then
    if ! echo ${PATH} | /bin/grep -q ${BIN} ; then
        export PATH=${PATH}:${BIN}
    fi
fi

