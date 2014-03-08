## Rails` examples for MultiSync

`MultiSync` supports both [Rails 4](/tree/rails-4) and [Rails 3](/tree/rails-3). Please check out [the example branches](/branches).

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

`MultiSync.prepare` simply bootstraps `MultiSync` for when its ran later on (for example during `rake assets:precompile`). `MultiSync` can be disabled from being ran on build by turning `MultiSync.run_on_build` off (`false`).

When `multi_sync` is included in your `Gemfile` an additional rake task `rake assets:sync` will be available which can then be ran manually or perhaps after a successful green build?

### AssetSync compatibility

Many people use [AssetSync](https://github.com/rumblelabs/asset_sync) and for `MultiSync`'s first release, compatibility with it has been built in. When within a `Rails` environment `MultiSync` will check for `asset_sync.yml` and read in its settings. You should be able to simply [require `multi_sync`](https://github.com/karlfreeman/multi_sync-rails/blob/rails-4-asset_sync-compatibility/config/initializers/multi_sync.rb) and try things out.

Please check out the [`rails-4-asset_sync-compatibility`](/tree/rails-4-asset_sync-compatibility) branch for an example (or the [`rails-3-asset_sync-compatibility`](/tree/rails-4-asset_sync-compatibility))

#### Unsupported AssetSync features
- [gzip_compression](https://github.com/rumblelabs/asset_sync#automatic-gzip-compression) hack. [related issue](https://github.com/karlfreeman/multi_sync/issues/1)
- custom [asset_sync environment variables](https://github.com/rumblelabs/asset_sync#built-in-initializer-environment-variables). [related issue](https://github.com/karlfreeman/multi_sync/issues/2)

