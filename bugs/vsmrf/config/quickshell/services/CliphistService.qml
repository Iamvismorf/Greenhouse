pragma Singleton
import Quickshell.Io
import Quickshell
import QtQuick

Singleton {
    id: root
    property ScriptModel cliphistModel: ScriptModel {}
    function refetch() {
        cliphistList.running = true;
    }
    function wipe() {
        cliphistWipe.running = true;
    }
    function deleteById(id) {
        let deleteScript = `echo ${id} | cliphist delete`;
        cliphistDelete.command = ["bash", "-c", deleteScript];
        cliphistDelete.running = true;
    }
    function selectById(id) {
        let selectItemScript = `cliphist decode ${id} | wl-copy`;
        selectItem.command = ["bash", "-c", selectItemScript];
        selectItem.running = true;
    }
    IpcHandler {
        target: "cliphistService"
        function refetch(): void {
            root.refetch();
        }
    }
    Process {
        id: selectItem
    }
    Process {
        id: cliphistDelete
        running: false
        onExited: (exitCode, exitStatus) => {
            root.refetch();
        }
    }
    Process {
        id: cliphistWipe
        running: false
        command: ["cliphist", "wipe"]
        onExited: (exitCode, exitStatus) => {
            root.refetch();
        }
    }
    Process {
        id: cliphistList
        running: true
        command: {
            let bashScript = `
while read -r entry; do
   cliphistId=$(echo "$entry" | awk '{print $1}')
   type=$(cliphist decode "$cliphistId" | file - --mime-type -b)
   if [[ "$type" == "image"* ]]; then
      dimension=$(echo "$entry" | grep -oP '\\d+x\\d+(?=.*\]\]$)' | sed 's/x/ /')
      width=$(echo "$dimension" | awk '{print $1}')
      height=$(echo "$dimension" | awk '{print $2}')

      cliphist decode $cliphistId | base64 -w 0 | jq -Rs --argjson eyeDih "$cliphistId" --argjson width "$width" --argjson height "$height" --arg type "$type" '{eyeDih: $eyeDih, type: $type, dimensions:{width: $width, height:$height}, data: .}'
   else
      cliphist decode $cliphistId | sed -e 's/^[ \t]*//' | jq -Rs --argjson eyeDih "$cliphistId" --arg type "$type" '{eyeDih: $eyeDih, type: $type, data: .}'
   fi

done < <(cliphist list) | jq -s '.'
`;

            return ["bash", "-c", bashScript];
        }
        stdout: StdioCollector {
            onStreamFinished: {
                root.cliphistModel.values = JSON.parse(text);
            }
        }
    }
}
