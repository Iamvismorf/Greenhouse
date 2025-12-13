pragma Singleton
import Quickshell
import Quickshell.Hyprland
import Quickshell.Io
import QtQuick

Singleton {
    id: root

    readonly property var toplevels: Hyprland.toplevels
    readonly property var workspaces: Hyprland.workspaces
    readonly property var monitors: Hyprland.monitors
    // readonly property HyprlandToplevel activeToplevel: Hyprland.activeToplevel
    property var activeToplevel: null
    readonly property HyprlandWorkspace focusedWorkspace: Hyprland.focusedWorkspace
    readonly property HyprlandMonitor focusedMonitor: Hyprland.focusedMonitor
    readonly property int activeWsId: focusedWorkspace?.id ?? 1
    property bool kbReady: false
    property string kbLayout: ""
    property string kbName

    function dispatch(request: string): void {
        Hyprland.dispatch(request);
    }
    function getActiveWindow() {
        getActiveWi.running = true;
    }
    Component.onCompleted: {
        getActiveWindow();
    }

    Connections {
        target: Hyprland

        function onRawEvent(event: HyprlandEvent): void {
            Hyprland.refreshToplevels();
            const n = event.name;
            getActiveWindow();
            if (n.endsWith("v2"))
                return;

            if (n === "activelayout" && event.parse(2)[1] != "error") {
                root.kbLayout = event.parse(2)[1];
            } else if (["workspace", "workspacev2", "moveworkspace", "activespecial", "focusedmon"].includes(n)) {
                // Hyprland.refreshWorkspaces();
                Hyprland.refreshMonitors();
            } else if (["openwindow", "closewindow", "swapwindow", "movewindowv2", "movewindow"].includes(n)) {
                Hyprland.refreshToplevels();
                // Hyprland.refreshWorkspaces();
            } else if (n.includes("mon")) {
                Hyprland.refreshMonitors();
            } else if (n.includes("workspace")) {
                // Hyprland.refreshWorkspaces();
                {}
            } else if (n.includes("window") || n.includes("group") || ["pin", "fullscreen", "changefloatingmode", "minimize"].includes(n)) {
                Hyprland.refreshToplevels();
            }
        }
    }

    Process {
        id: kb
        running: true
        command: ["hyprctl", "-j", "devices"]
        stdout: StdioCollector {
            onStreamFinished: {
                root.kbLayout = JSON.parse(text).keyboards.find(k => k.main).active_keymap;
                root.kbReady = true;
            }
        }
    }
    Process {
        command: ["hyprctl", "-j", "devices"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: {
                root.kbName = JSON.parse(text).keyboards.find(k => k.main).name;
            }
        }
    }
    Process {
        id: getActiveWi
        command: ["hyprctl", "-j", "activewindow"]
        stdout: StdioCollector {
            onStreamFinished: {
                root.activeToplevel = JSON.parse(text);
            }
        }
    }
}
