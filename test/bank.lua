function __init__ ()
  return {title = 'Bank'}
end

function deposit ()
  local amount = call.msatoshi or 0
  local balance = contract.state[account.id] or 0
  
  contract.state[account.id] = balance + amount
end


function withdraw ()
  local amount = call.payload.amount or 0
  local balance = contract.state[account.id] or 0

  if amount <= balance then 
    contract.send(account.id, amount)
    contract.state[account.id] = contract.state[account.id] - amount
  end
end


function transfer ()
  local amount = call.payload.amount or 0
  local user = call.payload.user
  local userbalance = contract.state[user] or 0

  local balance = contract.state[account.id] or 0

  if amount <= balance then 
    contract.state[account.id] = contract.state[account.id] - amount
    contract.state[user] = userbalance + amount
  end
end
