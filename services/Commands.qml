pragma Singleton
import Quickshell
import qs.config

Singleton {
    id: root

    function term(args) {
        return [Config.terminal, "-e"].concat(args);
    }

    readonly property var list: [
        { name: "sys",   desc: "btop in a terminal",  cmd: term(["btop"]) },
        { name: "wifi",     desc: "nmtui in a terminal", cmd: term(["nmtui"]) },
        { name: "audio",    desc: "pwvucontrol",         cmd: ["pwvucontrol"] },
        { name: "reload",   desc: "reload hyprland",     cmd: ["hyprctl", "reload"] },
        { name: "suspend",  desc: "suspend the pc",      cmd: ["systemctl", "suspend"] },
        { name: "logout",   desc: "exit hyprland",       cmd: ["hyprctl", "dispatch", "hl.dsp.exit()"], confirm: true },
        { name: "reboot",   desc: "reboot the pc",       cmd: ["systemctl", "reboot"],   confirm: true },
        { name: "poweroff", desc: "shut down the pc",    cmd: ["systemctl", "poweroff"], confirm: true }
    ]
}
