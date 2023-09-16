
var statusCommand = 'cyberghostvpn --status';

function getStatus(statusString) {
    return typeof statusString == "string" && statusString.trim() == "VPN connection found.";
}

function getStatusString(state) {
    return state ? i18n("Connected") : i18n("Not connected");
}
