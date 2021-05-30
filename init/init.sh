. init/logbot/logbot.sh
. init/utils.sh
. init/checks.sh

trap handleSigTerm TERM
trap handleSigInt INT
trap 'echo hi' USR1

initPetercord-Plugins() {
    printLogo
    assertPrerequisites
    sendMessage "Initializing Petercord-Plugins ..."
    assertEnvironment
    editLastMessage "Starting Petercord-Plugins ..."
    printLine
}

startPetercord-Plugins() {
    startLogBotPolling
    runPythonModule petercord "$@"
}

stopPetercord-Plugins() {
    sendMessage "Exiting Petercord-Plugins ..."
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

runPetercord-Plugins() {
    initPetercord-Plugins
    startPetercord-Plugins "$@"
    local code=$?
    stopPetercord-Plugins
    return $code
}
