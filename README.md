## Rails' examples for `multi_sync`

[`multi_sync`](https://github.com/karlfreeman/multi_sync) supports both [Rails 4](https://github.com/karlfreeman/multi_sync-rails/tree/rails-4) and [Rails 3](https://github.com/karlfreeman/multi_sync-rails/tree/rails-3). Please check out [the example branches](https://github.com/karlfreeman/multi_sync-rails/branches).

To get started with `multi_sync` you'll need to create an initializer for `multi_sync` inside your `/config/initializers`.

```ruby
MultiSync.prepare do
  manifest_source({
    source_dir: MultiSync::Extensions::Rails.source_dir
  })

  aws_target({
    target_dir: 'your_aws_bucket',
    destination_dir: MultiSync::Extensions::Rails.destination_dir,
    credentials: {
      region: 'us-east-1',
      aws_access_key_id: 'xxx',
      aws_secret_access_key: 'xxx'
    }
  })
end
```

`multi_sync.prepare` simply bootstraps `multi_sync` for when its ran later on (eg during `rake assets:precompile`). `multi_sync` by default is ran after 'build' but this can be disabled by turning `MultiSync.run_on_build` off (eg `false`).

When `multi_sync` is included in your `Gemfile` an additional rake task `assets:sync` will be available which can then be ran manually or perhaps after a successful green build.

### `asset_sync` compatibility

Many people use [asset_sync](https://github.com/rumblelabs/asset_sync) and for `multi_sync`'s first release, compatibility with it has been built in. When within a `Rails` environment `multi_sync` will check for `asset_sync.yml` and read in its settings.

You should be able to simply [require `multi_sync`](https://github.com/karlfreeman/multi_sync-rails/blob/rails-4-asset_sync-compatibility/config/initializers/multi_sync.rb) and try things out.

Please check out the [`rails-4-asset_sync-compatibility`](https://github.com/karlfreeman/multi_sync-rails/tree/rails-4-asset_sync-compatibility) or the [`rails-3-asset_sync-compatibility`](https://github.com/karlfreeman/multi_sync-rails/tree/rails-4-asset_sync-compatibility) branches for examples of this.

#### Unsupported `asset_sync` features
- [gzip_compression](https://github.com/rumblelabs/asset_sync#automatic-gzip-compression) hack. *[Related issue](https://github.com/karlfreeman/multi_sync/issues/1)*
- custom [asset_sync environment variables](https://github.com/rumblelabs/asset_sync#built-in-initializer-environment-variables). *[Related issue](https://github.com/karlfreeman/multi_sync/issues/2)*

