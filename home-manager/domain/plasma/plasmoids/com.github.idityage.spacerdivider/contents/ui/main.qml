import QtQuick
import QtQuick.Layouts
import org.kde.plasma.plasmoid
import org.kde.kirigami as Kirigami
import org.kde.plasma.core as PlasmaCore

PlasmoidItem {
    id: root

    property bool isHorizontal: Plasmoid.formFactor === PlasmaCore.Types.Horizontal
    property bool expanding: Plasmoid.configuration.expanding

    preferredRepresentation: fullRepresentation

    Layout.fillWidth: isHorizontal && expanding
    Layout.fillHeight: !isHorizontal && expanding

    Layout.minimumWidth: isHorizontal ? Plasmoid.configuration.minSize : Kirigami.Units.smallSpacing
    Layout.minimumHeight: !isHorizontal ? Plasmoid.configuration.minSize : Kirigami.Units.smallSpacing

    Layout.preferredWidth: isHorizontal ? (expanding ? -1 : Plasmoid.configuration.preferredSize) : -1
    Layout.preferredHeight: !isHorizontal ? (expanding ? -1 : Plasmoid.configuration.preferredSize) : -1

    fullRepresentation: Item {
        id: container
        
        Layout.fillWidth: root.isHorizontal && root.expanding
        Layout.fillHeight: !root.isHorizontal && root.expanding
        Layout.minimumWidth: root.Layout.minimumWidth
        Layout.minimumHeight: root.Layout.minimumHeight
        Layout.preferredWidth: root.Layout.preferredWidth
        Layout.preferredHeight: root.Layout.preferredHeight

        // Helper functions for pixel-perfect rendering
        function snapToPixel(value) {
            return Math.floor(value) + 0.5
        }
        
        function evenFloor(value) {
            var floored = Math.floor(value)
            return floored % 2 === 0 ? floored : floored - 1
        }

        // Vertical divider line using Canvas for pixel-perfect rendering
        Canvas {
            id: dividerCanvas
            anchors.fill: parent
            
            property int thickness: Plasmoid.configuration.dividerThickness
            property real dividerOpacity: Plasmoid.configuration.dividerOpacity / 100
            property bool fullHeight: Plasmoid.configuration.fullHeight
            property int heightPercent: Plasmoid.configuration.dividerHeight
            property color lineColor: Kirigami.Theme.textColor
            
            onPaint: {
                var ctx = getContext("2d")
                ctx.reset()
                
                var w = width
                var h = height
                
                // Calculate divider dimensions
                var divH = fullHeight ? h : Math.floor(h * heightPercent / 100)
                var divW = thickness
                
                // Center position - snap to integer
                var x = Math.floor((w - divW) / 2)
                var y = Math.floor((h - divH) / 2)
                
                // Draw the line
                ctx.fillStyle = Qt.rgba(lineColor.r, lineColor.g, lineColor.b, dividerOpacity)
                ctx.fillRect(x, y, divW, divH)
            }
            
            onThicknessChanged: requestPaint()
            onDividerOpacityChanged: requestPaint()
            onFullHeightChanged: requestPaint()
            onHeightPercentChanged: requestPaint()
            onLineColorChanged: requestPaint()
            onWidthChanged: requestPaint()
            onHeightChanged: requestPaint()
        }
    }

    Plasmoid.constraintHints: expanding ? Plasmoid.CanFillArea : Plasmoid.NoHint
}
