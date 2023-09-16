import QtQuick 2.0
import QtQuick.Layouts 1.0
import QtGraphicalEffects 1.12

import QtQml.Models 2.1

import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 2.0 as PlasmaComponents
import org.kde.plasma.plasmoid 2.0

import '../code/cyberghost.js' as CyberghostStatus

Item {
    QtObject {
        id: dataModel
        property var status: false
    }

    // Always display the compact view.
    // Never show the full popup view even if there is space for it.
    Plasmoid.preferredRepresentation: Plasmoid.compactRepresentation

    Plasmoid.toolTipMainText: i18n("Cyberghost VPN Status");
    Plasmoid.toolTipSubText: CyberghostStatus.getStatusString(dataModel.status)

    Plasmoid.compactRepresentation: Item {
        PlasmaCore.IconItem {
            id: cyberghosticon
            anchors.centerIn: parent
            width: Math.round(parent.width * 0.9)
            height: width
            source: plasmoid.file('', 'icons/cyberghost.svg')
        }
        
        ColorOverlay {
            anchors.fill: cyberghosticon
            source: cyberghosticon
            color: dataModel.status ? theme.textColor : theme.negativeTextColor
        }
    }

    PlasmaCore.DataSource {
        id: executable
        engine: "executable"
        connectedSources: [CyberghostStatus.statusCommand]
        onNewData: {
            var exitCode = data["exit code"]
            var exitStatus = data["exit status"]
            var stdout = data["stdout"]
            var stderr = data["stderr"]
            dataModel.status = CyberghostStatus.getStatus(stdout)
        }
        
        interval: 2000
    }
}
