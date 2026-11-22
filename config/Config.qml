pragma Singleton
import Quickshell
import QtQuick

Singleton {
    id: root

    readonly property int workspacesNumber: 5
    readonly property int inputWidth: 300
    readonly property int popupWidth: 460
    readonly property int maxResults: 8
    readonly property string terminal: "ghostty"
    readonly property string wallpaper: "/home/munty/Images/Wallpapers/test.png"
    readonly property string wallpaperDir: "/home/munty/Images/Wallpapers"
    readonly property string wallpaperStateFile: "/home/munty/.cache/inash-wallpaper"
}
