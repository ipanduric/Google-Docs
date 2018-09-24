require 'google/apis/drive_v2'
require 'google/api_client/client_secrets'
require 'json'

class Oauth2callbackController < ApplicationController
  def check
    if request['code'].nil?
      render 'failure'
    else
      google_client = GoogleClient.new
      google_client.fetch_access_token!(request['code'])
      cookies[:access_token] = google_client.access_token
      cookies[:refresh_token] = google_client.refresh_token
      cookies[:expires_in] = google_client.expires_in
      cookies[:issued_at] = google_client.issued_at
      @files = google_client.all_files
      render 'success'
    end
  end
end
