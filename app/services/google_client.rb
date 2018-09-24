class GoogleClient
  def authorization_uri
    auth_uri = authorization_client_updated.authorization_uri.to_s
    auth_uri
  end

  def fetch_access_token!(code)
    authorization_client.code = code
    authorization_client.fetch_access_token!
  end

  def all_files
    drive_auth.list_files
  end

  def show_files(q)
    drive_auth.list_files(q: "fullText contains '#{q}'",
                          spaces: 'drive',
                          fields: 'nextPageToken, items(id, title, owner_names)')
  end

  def access_token
    authorization_client.access_token
  end

  def refresh_token
    authorization_client.refresh_token
  end

  def expires_in
    authorization_client.expires_in
  end

  def issued_at
    authorization_client.issued_at
  end

  def atoken(atoken)
    authorization_client.access_token = atoken
  end

  def rtoken(rtoken)
    authorization_client.refresh_token = rtoken
  end

  def expiration(e)
    authorization_client.expires_in = e
  end

  def issued(i)
    authorization_client.issued_at = i
  end

  private

  def authorization_client
    @authorization_client ||=
      Google::APIClient::ClientSecrets
      .load('google/api_client/client_secrets.json')
      .to_authorization
  end

  def authorization_client_updated
    authorization_client.update!(
      scope: 'https://www.googleapis.com/auth/drive.metadata.readonly',
      redirect_uri: 'http://localhost:3000/oauth2callback/check',
      additional_parameters: {'access_type' => 'offline',
                              'include_granted_scopes' => 'true'}
    )
  end

  def drive_auth
    drive = Google::Apis::DriveV2::DriveService.new
    drive.authorization = authorization_client
    drive
  end
end
