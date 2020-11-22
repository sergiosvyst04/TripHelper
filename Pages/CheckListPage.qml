import QtQuick 2.10
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.0
import QtQml.Models 2.13
import PackService 1.0
import "../Singletons"
import "../Components"


BasePage {

    footer: Item {}

    property PackService packer

    ColumnLayout {
        anchors{
            fill: parent
        }

        spacing: 20

        TabBar {
            id: tabBar
            Layout.fillWidth: true

            contentHeight: 50 * ScreenProperties.scaleRatioHeight
            currentIndex: swipeView.currentIndex

            onCurrentIndexChanged: {
                swipeView.currentIndex = tabBar.currentIndex
            }

            background: Rectangle {
                anchors.fill: parent
                color: Colors.white
                Rectangle {
                    width: parent.width
                    height: 2
                    color: Colors.primaryColor
                    anchors.bottom: parent.bottom
                    opacity: 0.6
                }
            }

            CountryTabButton {
                text: qsTr("What to do")
                tabText.font: checked ? Fonts.openSansBold(13, Font.MixedCase)
                                      : Fonts.openSans(13, Font.MixedCase)
                tabText.layer.enabled: false
            }

            CountryTabButton {
                text: qsTr("What to pack")
                tabText.font:  checked ? Fonts.openSansBold(13, Font.MixedCase)
                                       : Fonts.openSans(13, Font.MixedCase)
                tabText.layer.enabled: false
            }
        }

        DescriptionText {
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: parent.width
            lineHeightMode: Text.FixedHeight
            lineHeight: 20
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            text: qsTr("It is important - to not forget something
before you start your
trip")
        }

        Image {
            Layout.alignment: Qt.AlignHCenter
            sourceSize: Qt.size(100 * ScreenProperties.scaleRatioWidth, 100 * ScreenProperties.scaleRatioHeight)
            opacity: 0.3
            source: "qrc:/images/assets/icons/idea5.png"
        }

        SwipeView {
            id: swipeView
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.leftMargin: 35
            Layout.rightMargin: 35
            currentIndex: tabBar.currentIndex
            clip: true


            ListView {
                id: toDoList
                Layout.fillWidth: true
                Layout.fillHeight: true
                spacing: 15

                model: toDoModel

                ObjectModel {
                    id: toDoModel
                    CheckListItem {
                        width : toDoList.width
                        group: qsTr("1 day before departure")
                        things: ["Print checklist", "Print tickets and bookings", "Buy and print insurance", "Take cash and exchange currency", "Inform your bank about trip",
                            "Check in for a journey", "Make a copy of passport", "Buy books", "Download movies and games", "Download maps and guides", "Charge gedgets",
                            "Plan hour of leaving of home", "Buy a ticket on airexpress"]
                    }

                    CheckListItem {
                        width : toDoList.width
                        group: qsTr("Before leaving the home")
                        things: ["Check point 'Necessarily from' 'What to pack' section", "Switch off light and all devices", "Turn off water supply", "Discard garbage and perishable products",
                            "WaMakeListter plants", "Close balcony and windows"]
                    }

                    CheckListItem {
                        width : toDoList.width
                        group: qsTr("Before departure")
                        things: ["Buy water", "Drink soothing/nausea remedy", "Send message to family", "Switch on airplane mode"]
                    }

                }

            }

            ListView {
                id: toPackList
                Layout.fillHeight: true
                Layout.fillWidth: true
                spacing: 15

                model: toPackModel

                ObjectModel {
                    id: toPackModel

                    CheckListItem {
                        isPackItem: true
                        width: toPackList.width
                        group: qsTr("Necessarily")
                        things: ["Passport", "Tickets", "Hotels booking", "Insurance", "Money", "Credit card", "Phone", "Charge", "Powerbank",
                            "Earphones", "First Aid Kit", "Drive licence"]
                    }

                    CheckListItem {
                        isPackItem: true
                        width: toPackList.width
                        group: qsTr("Clothes and shoes")
                        things: ["Socks", "Briefs", "T-shirts", "Dresses/Skirts", "Jeans/Pants", "Warm sweatshirt", "Pyjamas", "Sneakers", "Changeable shoes",
                            "Shoes to go out", "Flip flops", "Swimsuit", "Swim trunks", "Cap", "Bech towel", "Beach bag", "Shorts", "Thermal underweear", "Warm socks", "Hat/scarf/gloves"]
                    }

                    CheckListItem {
                        isPackItem: true
                        width: toPackList.width
                        group: qsTr("Hygiene products")
                        things: ["Toothbrush and paste", "Shampoo and shower gel", "Cleanser", "Comb", "Cotton swabs and disks", "Tweezers", "Deodorant", "Parfumes", "Lenses and liquid",
                            "Sun protect cream", "Flip flops", "Swimsuit", "Swim trunks", "Cap", "Bech towel", "Beach bag", "Shorts", "Thermal underweear", "Warm socks", "Hat/scarf/gloves"]
                    }

                    CheckListItem {
                        isPackItem: true
                        width: toPackList.width
                        group: qsTr("Userfull in trip")
                        things: ["Umbrella", "Notebook and pen", "CorkScrew", "Sun protect glasses", "Hair dryer"]
                    }

                    CheckListItem {
                        isPackItem: true
                        width: toPackList.width
                        group: qsTr("Userfull in plane")
                        things: ["Chewing gum/Candys", "Inflatable pillow", "Napkins", "Moiturizing cream", "Antiseptic for hands", "Book",
                            "Nausea remedy", "Hygiene pomade"]
                    }

                    CheckListItem {
                        isPackItem: true
                        width: toPackList.width
                        group: qsTr("Favourite gadgets")
                        things: ["Camera and memory card", "Charge", "E-book", "Watch", "Tablet", "Adapter"]
                    }

                }
            }
        }
    }
}

