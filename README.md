# TaserCart
# Author: KlausNO
TaserCart is a standalone

Just drag and drop to [standalone]

Go to Server CFG and put `ensure tasercart`

Go to qb-inventory/html/images and put the `taser_cardridge.png` in there

Go to qb-core/shared/items.lua and paste this in

`['taser_cardridge'] = {
                    ["name"] = "taser_cardridge",
                    ["label"] = "Taser Cardridge",
                    ["weight"] = 100,
                    ["type"] = "item",
                    ["image"] = "taser_cardridge.png",
                    ["unique"] = false,
                    ["useable"] = true,
                    ["shouldClose"] = true,
                    ["combinable"] = nil,
                    ["description"] = ""
                },`

You can add your own notification system

#example

exports['okokNotify']:Alert('Title', 'Message', Time, 'type')
exports['mythic_notify']:DoHudText('type', 'message')
