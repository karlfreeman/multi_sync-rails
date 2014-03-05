require 'multi_sync'

MultiSync.configure do |config|
  config.verbose = true # turn on verbose logging (defaults to false)
  # config.force = false # force syncing of outdated_files (defaults to false)
  # config.run_on_build = true # when within a framework which `builds` assets, whether to sync afterwards (defaults to true)
  # config.sync_outdated_files = true # when an outdated file is found whether to replace it (defaults to true)
  # config.delete_abandoned_files = true # when an abondoned file is found whether to remove it (defaults to true)
  # config.upload_missing_files = true # when a missing file is found whether to upload it (defaults to true)
  # config.target_pool_size = 8 # how many threads you would like to open for each target (defaults to the amount of CPU core's your machine has)
  # config.max_sync_attempts = 3 # how many times a file should be retried if there was an error during sync (defaults to 3)
end

MultiSync.prepare do

  target :rails, {
    type: :aws,
    target_dir: 'multi-sync-rails-4',
    destination_dir: MultiSync::Extensions::Rails.destination_dir,
    credentials: {
      region: 'us-east-1',
      aws_access_key_id: 'AKIAI6IOHCMYYPNEJ6VQ',
      aws_secret_access_key: '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'
    }
  }

  source :assets, {
    type: :manifest,
    source_dir: MultiSync::Extensions::Rails.source_dir
  }

end
