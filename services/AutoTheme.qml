import Quickshell
import QtQuick
import qs.config
import qs.services

QtObject {
    id: root

    property ColorQuantizer quantizer: ColorQuantizer {
        source: Wallpaper.source
        depth: 6
        rescaleSize: 128

        onColorsChanged: {
            if (!colors || colors.length === 0)
                return;

            const sorted = Array.prototype.slice.call(colors).sort((a, b) => a.hslLightness - b.hslLightness);
            const dark = sorted[0];
            const light = sorted[sorted.length - 1];

            let accent = light;
            let best = -1;
            for (const c of sorted) {
                if (c.hslLightness < 0.28 || c.hslSaturation < 0.2)
                    continue;
                const score = c.hslSaturation * (0.3 + c.hslLightness);
                if (score > best) {
                    best = score;
                    accent = c;
                }
            }

            const hue = accent.hslHue >= 0 ? accent.hslHue : 0.08;
            const darkness = Math.max(dark.hslLightness * 0.6, 0.035);

            Theme.bg = Qt.hsla(hue, 0.2, darkness, 1);
            Theme.box = Qt.hsla(hue, 0.2, darkness + 0.07, 1);
            Theme.border = Qt.hsla(hue, 0.22, 0.22, 1);
            Theme.dim = Qt.hsla(hue, 0.16, 0.45, 1);
            Theme.fg = Qt.hsla(hue, Math.min(light.hslSaturation, 0.18), Math.max(light.hslLightness, 0.82), 1);
            Theme.accent = Qt.hsla(hue, Math.max(accent.hslSaturation, 0.55), Math.max(accent.hslLightness, 0.52), 1);
        }
    }
}
