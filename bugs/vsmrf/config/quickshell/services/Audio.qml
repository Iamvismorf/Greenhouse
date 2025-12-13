pragma Singleton
import Quickshell.Services.Pipewire
import Quickshell
import QtQuick

Singleton {
    id: root
    property PwNode defaultSink: Pipewire.defaultAudioSink
    PwObjectTracker {
        objects: [defaultSink]
    }

    Connections {
        // Protection against sudden volume changes
        target: defaultSink?.audio ?? null
        property bool lastReady: false
        property real lastVolume: 0
        function onVolumeChanged() {
            // if (!Config.options.audio.protection.enable)
            //     return;
            if (!lastReady) {
                lastVolume = defaultSink.audio.volume;
                lastReady = true;
                return;
            }
            const newVolume = defaultSink.audio.volume;
            const maxAllowedIncrease = 10 / 100;
            const maxAllowed = 105 / 100;

            if (newVolume - lastVolume > maxAllowedIncrease) {
                defaultSink.audio.volume = lastVolume;
            } else if (newVolume > maxAllowed) {
                defaultSink.audio.volume = Math.min(lastVolume, maxAllowed);
            }
            if (defaultSink.ready && (isNaN(defaultSink.audio.volume) || defaultSink.audio.volume === undefined || defaultSink.audio.volume === null)) {
                defaultSink.audio.volume = 0;
            }
            lastVolume = defaultSink.audio.volume;
        }
    }// property real vol: {
    //     if (Pipewire.defaultAudioSink.ready)
    //         return Pipewire.defaultAudioSink.audio.volume;
    // }
}
