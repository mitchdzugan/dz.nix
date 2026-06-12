import QtQuick
import QtQuick.Controls as QQC2
import QtQuick.Layouts
import org.kde.kirigami as Kirigami
import org.kde.kcmutils as KCM

KCM.SimpleKCM {
    id: root

    property alias cfg_minSize: minSizeSpinBox.value
    property alias cfg_preferredSize: preferredSizeSpinBox.value
    property alias cfg_expanding: expandingCheckBox.checked
    property alias cfg_fullHeight: fullHeightCheckBox.checked
    property alias cfg_dividerHeight: dividerHeightSlider.value
    property alias cfg_dividerThickness: thicknessSpinBox.value
    property alias cfg_dividerOpacity: opacitySlider.value

    Kirigami.FormLayout {
        anchors.fill: parent

        Kirigami.Separator {
            Kirigami.FormData.isSection: true
            Kirigami.FormData.label: i18n("Spacer Size")
        }

        QQC2.SpinBox {
            id: minSizeSpinBox
            Kirigami.FormData.label: i18n("Minimum width (px):")
            from: 5
            to: 500
            stepSize: 5
        }

        QQC2.SpinBox {
            id: preferredSizeSpinBox
            Kirigami.FormData.label: i18n("Preferred width (px):")
            from: 10
            to: 1000
            stepSize: 10
        }

        QQC2.CheckBox {
            id: expandingCheckBox
            Kirigami.FormData.label: i18n("Flexible:")
            text: i18n("Expand to fill available space")
        }

        Kirigami.Separator {
            Kirigami.FormData.isSection: true
            Kirigami.FormData.label: i18n("Divider Appearance")
        }

        QQC2.CheckBox {
            id: fullHeightCheckBox
            Kirigami.FormData.label: i18n("Full height:")
            text: i18n("Stretch from top to bottom")
        }

        RowLayout {
            Kirigami.FormData.label: i18n("Height:")
            enabled: !fullHeightCheckBox.checked
            
            QQC2.Slider {
                id: dividerHeightSlider
                from: 10
                to: 100
                stepSize: 5
                Layout.fillWidth: true
            }
            QQC2.Label {
                text: dividerHeightSlider.value + "%"
                Layout.minimumWidth: Kirigami.Units.gridUnit * 2
            }
        }

        QQC2.SpinBox {
            id: thicknessSpinBox
            Kirigami.FormData.label: i18n("Thickness (px):")
            from: 1
            to: 10
            stepSize: 1
        }

        RowLayout {
            Kirigami.FormData.label: i18n("Opacity:")
            
            QQC2.Slider {
                id: opacitySlider
                from: 10
                to: 100
                stepSize: 5
                Layout.fillWidth: true
            }
            QQC2.Label {
                text: opacitySlider.value + "%"
                Layout.minimumWidth: Kirigami.Units.gridUnit * 2
            }
        }
    }
}
