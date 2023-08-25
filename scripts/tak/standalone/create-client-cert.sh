#!/bin/bash

SCRIPT_PATH=$(dirname "${BASH_SOURCE[0]}")
source ${SCRIPT_PATH}/shared.inc.sh

# =======================

export COUNTRY=${TAK_COUNTRY}
export STATE=${TAK_STATE}
export CITY=${TAK_CITY}
export ORGANIZATION=${TAK_ORGANIZATION}
export ORGANIZATIONAL_UNIT=${TAK_ORGANIZATIONAL_UNIT}

export CAPASS=${TAK_CAPASS}
export PASS=${TAK_PASS}

printf $warning "\n\n------------ Creating TAK Client Certificate ------------ \n\n"

read -p "What is the username: " USERNAME

cd ${CERT_PATH}
./makeCert.sh client ${USERNAME}

USER_PASS=${PAD1}$(pwgen -cvy1 -r ${PASS_OMIT} 25)${PAD2}
java -jar ${TAK_PATH}/utils/UserManager.jar usermod -p "${USER_PASS}" $USERNAME

# Admin Priv
# java -jar ${TAK_PATH}/utils/UserManager.jar certmod -A ${TAK_PATH}/certs/files/${USERNAME}.pem

printf $info "\nCreated Client Certificate ${FILE_PATH}/${USERNAME}.p12\n"

source ${TAK_SCRIPT_PATH}/v1/client-data-package.inc.sh ${USERNAME}

source ${SCRIPT_PATH}/restart-prompt.inc.sh