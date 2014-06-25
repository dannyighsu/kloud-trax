module ApplicationHelper

  # Finds Kloudless account id
  def findAccountId(account_id)
    return Account.find_by(account_id).accountid
  end

  # Finds Kloudless account key
  def findAccountKey(account_id)
    key = Account.find_by(account_id).accountkey
    if not key
      raise "error: no account key present"
    end
    return key
  end
end
