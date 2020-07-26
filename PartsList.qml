import QtQuick 2.0
import MuseScore 3.0
import FileIO 3.0

MuseScore {
    menuPath: "Plugins.PartsList"
    version:  "1.0"
    description: "Lists the parts in a score. By John Asendorf"
    pluginType: "dialog"
    width:  300
    height: 200

    FileIO {
          id: outfile
          source: tempPath() + "/" + curScore.scoreName + "-partlist.txt"
          onError: console.log(msg)
    }
    QProcess {
      id: proc
    }

    Rectangle {
        color: "white"
        anchors.fill: parent

        Text {
            anchors.fill: parent
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            wrapMode: Text.WordWrap
            text: "Parts List Completed,\nClick Here to Close\n\nIt has been written to:\n" + outfile.source
        }

        MouseArea {
            anchors.fill: parent
            onClicked: Qt.quit()
        }
    }

    onRun: {
            var thepartslist = curScore.scoreName + " Parts List\n";
            for (var i = 0; i < curScore.parts.length; i++) {
              thepartslist += curScore.parts[i].partName + "\n";
            }
            var rc = outfile.write(thepartslist);
            if (rc){
                  console.log("Parts list has been  written to " + outfile.source);
                  proc.start("notepad " + outfile.source); // Windows
            } else {
                  console.log("Something went wrong. File cannot be written");
            }
            //Qt.quit()
    }
}
