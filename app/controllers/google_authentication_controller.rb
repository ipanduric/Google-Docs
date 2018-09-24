require 'google/apis/drive_v2'
require 'google/api_client/client_secrets'

class GoogleAuthenticationController < ApplicationController
  def login
    redirect_to(GoogleClient.new.authorization_uri)
  end
end
