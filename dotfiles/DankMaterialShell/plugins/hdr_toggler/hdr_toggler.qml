import QtQuick
import Quickshell
import qs.Common
import qs.Services
import qs.Widgets
import qs.Modules.Plugins

PluginComponent {
    id: root

    property bool isEnabled: pluginData.isEnabled || false

    ccWidgetIcon: isEnabled ? "toggle_on" : "toggle_off"
    ccWidgetPrimaryText: "HDR"
    ccWidgetIsActive: isEnabled

    onCcWidgetToggled: {
        isEnabled = !isEnabled
        Quickshell.execDetached(["toggle_hdr", `${isEnabled}`])
        if (pluginService) {
            pluginService.savePluginData(pluginId, "isEnabled", isEnabled)
        }
        ToastService.showInfo(isEnabled ? "HDR Enabled" : "HDR Disabled")
    }

    horizontalBarPill: Component {
        Row {
            DankIcon {
                name: root.isEnabled ? "toggle_on" : "toggle_off"
                color: root.isEnabled ? Theme.primary : Theme.surfaceVariantText
            }
            StyledText {
                text: `some text 1`
                color: Theme.surfaceText
            }
        }
    }

    verticalBarPill: Component {
        Column {
            DankIcon {
                name: root.isEnabled ? "toggle_on" : "toggle_off"
                color: root.isEnabled ? Theme.primary : Theme.surfaceVariantText
                anchors.horizontalCenter: parent.horizontalCenter
            }
            StyledText {
                text: `some text 2`
                color: Theme.surfaceText
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }
    }
}
