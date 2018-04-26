require 'google/apis/drive_v2'
require 'signet/oauth_2/client'

class GoogleDrive

  SYSTEM_ACCOUNT_CREDENTIALS_FILE = "#{Rails.root}/config/google-api-service-account.json"

  def initialize
    ENV['GOOGLE_APPLICATION_CREDENTIALS'] = SYSTEM_ACCOUNT_CREDENTIALS_FILE

    @drive = Google::Apis::DriveV2::DriveService.new
    @drive.authorization = Google::Auth.get_application_default([Google::Apis::DriveV2::AUTH_DRIVE])
  end

  def do_something
    files = @drive.fetch_all do |page_token|
      @drive.list_files(
        spaces: 'drive',
        fields: 'nextPageToken, items(*)',
        page_token: page_token)
    end

    files.each do |file|
      puts file.title
    end
  end

end

