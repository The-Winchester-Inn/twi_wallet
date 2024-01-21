RegisterNetEvent("myWallet:Notify")
AddEventHandler("myWallet:Notify", function(message)
    VORPcore.NotifyRightTop(message, 4000)
end)
