## Rails 4 example for MultiSync

`MultiSync` prefers ruby backed configuration instead of `YAML` so you'll need to create an initializer for `MultiSync` inside your `/config/initializers`. 

```ruby
MultiSync.prepare do

  target :assets, {
    type: :aws,
    target_dir: 'your_aws_bucket',
    destination_dir: MultiSync::Extensions::Rails.destination_dir,
    credentials: {
      region: 'us-east-1',
      aws_access_key_id: 'super_secret',
      aws_secret_access_key: 'super_secret'
    }
  }

  source :rails, {
    type: :manifest,
    source_dir: MultiSync::Extensions::Rails.source_dir
  }

end
```

`MultiSync.prepare` simply bootstraps `MultiSync` for when it ran later on during `rake assets:precompile`. `MultiSync` can be turned off synchronising disabling `MultiSync.run_on_build`.By having `multi_sync` included in your `Gemfile`, the rake task `rake assets:sync` will be available which can then be ran manually or perhaps after a successful green build?

#### AssetSync compatibility

Many people use [AssetSync](https://github.com/rumblelabs/asset_sync) and for `MultiSync`'s first release compatibility with it has been built in. When within a `Rails` environment `MultiSync` will check for `asset_sync.yml` and read in its settings. You should be able to simply require `multi_sync` and try things out.

Please check out the [`asset_sync-compatiabilty`](/tree/asset_sync-compatibility) branch for an example

##### Unsupported AssetSync features

- [gzip_compression](https://github.com/rumblelabs/asset_sync#automatic-gzip-compression) hack. [related issue](https://github.com/karlfreeman/multi_sync/issues/1)
- custom [asset_sync environment variables](https://github.com/rumblelabs/asset_sync#built-in-initializer-environment-variables). [related issue](https://github.com/karlfreeman/multi_sync/issues/2)

