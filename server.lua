local allowedWalletItems = {
    "we1",
    "we5",
    "we10",
    "we20",
    "we50",
    "we100",
    "we500",
    "we1000",
    "we10000",
    "nh1",
    "nh5",
    "nh10",
    "nh20",
    "nh50",
    "nh100",
    "nh500",
    "nh1000",
    "nh10000",
    "na1",
    "na5",
    "na10",
    "na20",
    "na50",
    "na100",
    "na500",
    "na1000",
    "na10000",
    "le1",
    "le5",
    "le10",
    "le20",
    "le50",
    "le100",
    "le500",
    "le1000",
    "le10000",
    "am1",
    "am5",
    "am10",
    "am20",
    "am50",
    "am100",
    "am500",
    "am1000",
    "am10000",
    "gu1",
    "gu5",
    "gu10",
    "gu20",
    "gu50",
    "gu100",
    "gu500",
    "gu1000",
    "gu10000",
    "np1",
    "np5",
    "np10",
    "np20",
    "np50",
    "np100",
    "np500",
    "np1000",
    "np10000",
}

exports.vorp_inventory:registerUsableItem("wallet", function(source)
    TriggerClientEvent("vorp_inventory:openInventory", source, "wallet_inventory_" .. tostring(source))
end)

RegisterServerEvent("myWallet:AddItem")
AddEventHandler("myWallet:AddItem", function(itemName, amount)
    if not IsAmountValid(amount) then
        TriggerClientEvent("myWallet:Notify", source, "Invalid amount. Must be 1 or more.")
        return
    end

    if IsItemAllowed(itemName) then
        exports.vorp_inventory:addToInventory(source, "wallet_inventory_" .. tostring(source), itemName, amount)
    else
        TriggerClientEvent("myWallet:Notify", source, "Wallets can only store currency!")
    end
end)

RegisterServerEvent("myWallet:RemoveItem")
AddEventHandler("myWallet:RemoveItem", function(itemName)
    exports.vorp_inventory:subItem(source, "wallet_inventory_" .. tostring(source), itemName, 1)
end)

exports.vorp_inventory:isCustomInventoryRegistered("wallet_inventory_" .. tostring(source), function(registered)
    local walletInventoryId = "wallet_inventory_" .. tostring(source)  -- Move inside the function
    if not registered then
        local walletInventoryData = {
            id = walletInventoryId,
            name = "Wallet",
            limit = 1000,
            acceptWeapons = false,
            shared = false,
            ignoreItemStackLimit = false,
            whitelistItems = true,
            UsePermissions = true,
            UseBlackList = false,
            whitelistWeapons = false,
        }
        exports.vorp_inventory:registerInventory(walletInventoryData, source)
    end
end)

function IsAmountValid(amount)
    return amount and amount >= 1
end

function IsItemAllowed(itemName)
    for _, allowedItem in ipairs(allowedWalletItems) do
        if allowedItem == itemName then
            return true
        end
    end
    return false
end

