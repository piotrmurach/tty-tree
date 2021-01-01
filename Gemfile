source 'https://rubygems.org'

gemspec

gem "json", "2.4.1" if RUBY_VERSION == "2.0.0"

group :test do
  gem 'benchmark-ips', '~> 2.7.2'
  gem 'simplecov', '~> 0.16.1'
  gem 'coveralls', '~> 0.8.22'
end

group :tools do
  gem 'byebug', platform: :mri
end

group :metrics do
  gem 'yardstick', '~> 0.9.9'
end
