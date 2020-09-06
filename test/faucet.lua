min_withdraw_msat = 10000
max_withdraw_msat = 100000

function __init__ ()
  return {}
end

function fundfaucet ()
  -- don't need to do anything here, any money you send will just be added
  -- to the total contract funds.
end

function getmoney ()
  -- here we require the user to be authenticated.
  if not account.id then
    -- this terminates the call execution and
    -- invalidates anything that might have happened before.
    error('you must be authenticated')
  end

  -- we let the user specify how much he's going to take from the faucet
  local withdraw_msat = call.payload.withdraw_msat
  if not withdraw_msat then
    withdraw_msats = min_withdraw_msat -- default to 10 sat
  end
  if withdraw_msat > max_withdraw_msat then
    withdraw_msat = max_withdraw_msat -- the amount is limited to 100 sat
  end

  -- this sends the money to the account balance of the caller
  contract.send(account.id, money_to_get)
end