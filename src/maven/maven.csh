# hadoop roll 

setenv MAVEN /opt/maven
set BIN=${MAVEN}/bin

if ( -d ${BIN}  ) then
	echo ${PATH} | /bin/grep -q ${BIN} 
	if ( $? != 0) then
        	setenv PATH "${PATH}:${BIN}"
	endif
endif
