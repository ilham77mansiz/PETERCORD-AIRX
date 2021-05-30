. init/logbot/logbot.sh
. init/utils.sh
. init/checks.sh

trap handleSigTerm TERM
trap handleSigInt INT
trap 'echo hi' USR1

initPETERCORD-AIRX() {
    printLogo
    assertPrerequisites
    sendMessage "Initializing PETERCORD-AIRX ..."
    assertEnvironment
    editLastMessage "Starting PETERCORD-AIRX ..."
    printLine
}

startPETERCORD-AIRX() {
    startLogBotPolling
    runPythonModule petercord "$@"
}

stopPETERCORD-AIRX() {
    sendMessage "Exiting PETERCORD-AIRX ..."
    endLogBotPolling
}

handleSigTerm() {
    log "Exiting With SIGTERM (143) ..."
    stopUserge
    exit 143
}

handleSigInt() {
    log "Exiting With SIGINT (130) ..."
    stopUserge
    exit 130
}

runPETERCORD-AIRX() {
    initPETERCORD-AIRX
    startPETERCORD-AIRX "$@"
    local code=$?
    stopPETERCORD-AIRX
    return $code
}
