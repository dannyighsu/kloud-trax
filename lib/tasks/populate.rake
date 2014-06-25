desc "Populate Tracks"
task :populate, [:id] do |t, args|
  account = Account.find_by(accountid: "#{:id}")
  account.populate
end
