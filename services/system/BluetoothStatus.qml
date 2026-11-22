pragma Singleton
import Quickshell
import Quickshell.Bluetooth
import QtQml

Singleton {
    id: root

    readonly property var adapter: Bluetooth.defaultAdapter
    readonly property var activeDevice: {
        for (const device of Bluetooth.devices.values)
            if (device.state === BluetoothDeviceState.Connected)
                return device;
        return null;
    }
    readonly property bool enabled: root.adapter !== null && root.adapter.enabled
    readonly property bool connected: root.activeDevice !== null
    readonly property string deviceName: root.connected ? root.activeDevice.deviceName || root.activeDevice.name : ""
    readonly property int batteryPercent: root.connected && root.activeDevice.batteryAvailable ? Math.round(root.activeDevice.battery * 100) : 0
    readonly property string label: {
        if (!root.adapter)
            return "BT no hw";
        if (!root.enabled)
            return "BT OFF";
        if (!root.connected)
            return "BT ON";
        const name = root.deviceName.length > 12 ? root.deviceName.slice(0, 11) + "…" : root.deviceName;
        if (!root.activeDevice.batteryAvailable)
            return "BT " + name;
        return "BT " + name + " " + String(root.batteryPercent).padStart(2, "0") + "%";
    }
}
