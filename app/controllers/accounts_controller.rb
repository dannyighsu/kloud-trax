class AccountsController < ApplicationController

    require 'eventmachine'

    # Create an account and run the populate script
    def show
        @account = Account.find_by(accountid: params[:accountid])
        if not @account
            @account = Account.new
            @account.accountid = params[:accountid]
            @account.service = params[:service]
            @account.user_id = current_user.id
            key = HTTParty.get("https://api.kloudless.com/" +
            "v0/accounts/#{@account.accountid}/keys",
            headers: {"Authorization" => 'ApiKey nPEs_C' +
                '7ORsuc2MLPbAj248NuSm_AG8EkTlCERecNZaB5xIKt'})['objects']
            @account.accountkey = key[0]['key']
            @account.save
        end

        operation = proc {
            @account.populate
        }

        callback = proc {
            logger.info "Account #{@account.accountid} processing complete"
        }

        #call_rake :populate, id: "#{@account.id}
        EventMachine.defer(operation, callback)
        redirect_to root_url
    end

    def create
    end

    def destroy
        @account = Account.find(params[:account][:id])
        Account.destroy(@account)
        redirect_to root_url
    end

    def update
        @account = Account.find(params[:account][:id])
        @account.accountid = params[:accountid]
        @account.save
        redirect_to root_url
    end
end
