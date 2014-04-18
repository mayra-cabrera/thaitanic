source 'https://rubygems.org'

# =================
# Core Gems
# =================
gem 'rails', '3.2.17'
gem 'jquery-rails', '3.0.0'
gem 'sqlite3'

# =================
# Assets
# =================
group :assets do
  gem 'sass-rails', " ~> 3.2.3"
  gem 'sass', '3.3.0.alpha.149'
  gem 'compass', '0.12.2'
  gem 'compass-sourcemaps', "~> 0.12.2.sourcemaps.57a186c"
  gem 'coffee-rails'
  gem 'uglifier'
end

# =================
# Utilities
# =================
gem 'haml'
gem 'select2-rails'

# =================
# Spree & Refinery
# =================
gem 'spree', github: 'spree/spree', branch: '2-0-stable'
gem 'spree_gateway', git: 'https://github.com/spree/spree_gateway.git', branch: "2-0-stable"
gem 'spree_fancy', :git => 'git://github.com/spree/spree_fancy.git', :branch => '2-0-stable'
gem 'spree_auth_devise', github: 'spree/spree_auth_devise', branch: '2-0-stable'

# =================
# Braintree
# =================
gem 'braintree'

group :development, :test do
  gem "ffaker"
  gem "pry"
  gem "rspec-rails"
  gem "factory_girl_rails", "~> 3.0"
  gem "letter_opener"
  gem 'shoulda-matchers'
end