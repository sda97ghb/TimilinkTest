import QtQuick 2.0
import QtQuick.Shapes 1.12

Item {
    id: root

    implicitWidth: 200
    implicitHeight: 200

    property int topLeftRadius: 10
    property int topRightRadius: 10
    property int bottomLeftRadius: 10
    property int bottomRightRadius: 10

    property alias color: theShapePath.fillColor

    Shape {
        anchors.fill: parent
        layer.enabled: true
        layer.samples: 4

        ShapePath {
            id: theShapePath
            strokeColor: "transparent"
            fillColor: "white"
            startX: 0; startY: root.topLeftRadius
            PathArc {
                x: root.topLeftRadius; y: 0
                radiusX: root.topLeftRadius; radiusY: root.topLeftRadius
            }
            PathLine {
                x: root.width - root.topRightRadius; y: 0
            }
            PathArc {
                x: root.width; y: root.topRightRadius
                radiusX: root.topRightRadius; radiusY: root.topRightRadius
            }
            PathLine {
                x: root.width; y: root.height - root.bottomRightRadius
            }
            PathArc {
                x: root.width - root.bottomRightRadius; y: root.height
                radiusX: root.bottomRightRadius; radiusY: root.bottomRightRadius
            }
            PathLine {
                x: root.bottomLeftRadius; y: root.height
            }
            PathArc {
                x: 0; y: root.height - root.bottomLeftRadius
                radiusX: root.bottomLeftRadius; radiusY: root.bottomLeftRadius
            }
            PathLine {
                x: 0; y: root.topLeftRadius
            }
        }
    }
}
