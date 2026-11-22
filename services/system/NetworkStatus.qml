pragma Singleton
import Quickshell
import Quickshell.Networking
import QtQml

Singleton {
    id: root

    property var wifiDevice: null
    property var ethernetDevice: null

    readonly property bool wifiConnected: root.wifiDevice !== null && root.wifiDevice.connected
    readonly property bool ethernetConnected: root.ethernetDevice !== null && root.ethernetDevice.connected
    readonly property bool connected: root.wifiConnected || root.ethernetConnected
    readonly property var activeNetwork: {
        if (!root.wifiConnected)
            return null;
        const networks = root.wifiDevice.networks.values;
        for (const network of networks)
            if (network.connected)
                return network;
        return null;
    }
    readonly property string ssid: root.activeNetwork ? root.activeNetwork.name : ""
    readonly property int signalPercent: root.activeNetwork ? Math.round(root.activeNetwork.signalStrength * 100) : 0
    readonly property string status: {
        if (!Networking.wifiHardwareEnabled)
            return "no hw";
        if (!Networking.wifiEnabled)
            return "off";
        if (!root.wifiConnected)
            return "--";
        const name = root.ssid.length > 12 ? root.ssid.slice(0, 11) + "…" : root.ssid;
        return name + " " + String(root.signalPercent).padStart(2, "0") + "%";
    }
    readonly property string label: root.ethernetConnected ? "eth" : "wifi " + root.status

    property Timer initTimer: Timer {
        interval: 0
        running: true
        onTriggered: root.refresh()
    }

    property Timer pollTimer: Timer {
        interval: 2000
        running: true
        repeat: true
        onTriggered: root.refresh()
    }

    function refresh() {
        let wifi = null;
        let ethernet = null;
        const devices = Networking.devices.values;
        for (const device of devices) {
            if (device.type === DeviceType.Wifi)
                wifi = device;
            if (device.type === DeviceType.Wired)
                ethernet = device;
        }
        if (root.wifiDevice !== wifi)
            root.wifiDevice = wifi;
        if (root.ethernetDevice !== ethernet)
            root.ethernetDevice = ethernet;
        if (wifi && !wifi.scannerEnabled)
            wifi.scannerEnabled = true;
    }
}
