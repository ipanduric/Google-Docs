class SearchController < ApplicationController
  def show
    client = GoogleClient.new
    client.atoken(cookies[:access_token])
    client.rtoken(cookies[:refresh_token])
    client.expiration(cookies[:expires_in])
    client.issued(cookies[:issued_at])
    @searched_files = client.show_files(params[:search])
  end
end
