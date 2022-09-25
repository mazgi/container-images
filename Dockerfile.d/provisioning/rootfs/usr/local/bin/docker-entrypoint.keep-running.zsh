#!/usr/bin/env -S zsh -eu

readonly local SCRIPT_NAME=$(basename $0)
readonly local termColorClear='\033[0m'
echoDebug() {
  readonly local termColorDebug='\033[1;34m'
  echo -e "${termColorDebug}$@${termColorClear}"
}
echoInfo() {
  readonly local termColorInfo='\033[1;32m'
  echo -e "${termColorInfo}$@${termColorClear}"
}
echoWarn() {
  readonly local termColorWarn='\033[1;33m'
  echo -e "${termColorWarn}$@${termColorClear}"
}
echoErr() {
  readonly local termColorErr='\033[1;31m'
  echo -e "${termColorErr}$@${termColorClear}"
}

readonly local STATUS_FILE=/var/run/container-stat-myself/status.json
getStatusFilePath () {
  echo ${STATUS_FILE:?}
}
resetStatus () {
  readonly local _dir=$(dirname ${STATUS_FILE:?})
  sudo mkdir -p ${_dir:?}/
  sudo chmod 777 ${_dir:?}/
  echo '{}' > ${STATUS_FILE:?}
}
updateStatusToSucceeded () {
  readonly local _tmpfile=${STATUS_FILE:?}.tmp
  cp ${STATUS_FILE:?} ${_tmpfile:?}
  jq '. + {succeeded:true}' ${_tmpfile:?} | tee ${STATUS_FILE:?}
  rm -rf ${_tmpfile:?}
}
updateStatusToFailed () {
  readonly local _tmpfile=${STATUS_FILE:?}.tmp
  cp ${STATUS_FILE:?} ${_tmpfile:?}
  jq '. + {succeeded:false}' ${_tmpfile:?} | tee ${STATUS_FILE:?}
  rm -rf ${_tmpfile:?}
}

# Export functions as symlinks
case ${SCRIPT_NAME} in
  echoDebug|echoInfo|echoWarn|echoErr)
    ${SCRIPT_NAME} "$@"
    exit 0
    ;;
  getStatusFilePath|updateStatusToSucceeded|updateStatusToFailed)
    ${SCRIPT_NAME}
    exit 0
    ;;
esac

resetStatus
trapSigTerm () {
  echoDebug "Exit by SIGTERM."
  exit 0
}
trap 'trapSigTerm' SIGTERM

echoDebug "Start evaluation of the CMD."
eval "$@" && updateStatusToSucceeded
echoDebug "Done evaluation of the CMD."

echoDebug "Turn in infinity sleep..."
sleep infinity &; readonly local SLEEP_PID=$!
wait ${SLEEP_PID}
exit $?
