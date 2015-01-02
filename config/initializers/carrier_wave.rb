if Rails.env.production?
  CarrierWave.configure do |config|
    config.fog_credentials = {
      # Configuration for Amazon S3
      :provider              => 'AWS',
      :aws_access_key_id     => ENV['AKIAJV45CWF36WNYLHKA'],
      :aws_secret_access_key => ENV['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']
    }
    config.fog_directory     =  ENV['imgstanley']
  end
end