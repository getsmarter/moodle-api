[![Gem Version](https://badge.fury.io/rb/moodle-api.svg)](http://badge.fury.io/rb/moodle-api)
[![Code Climate](https://codeclimate.com/repos/559ea924e30ba001ad00a507/badges/bf95c036334b007100d3/gpa.svg)](https://codeclimate.com/repos/559ea924e30ba001ad00a507/feed)
[![Build Status](https://travis-ci.org/getsmarter/moodle-api.svg?branch=master)](https://travis-ci.org/getsmarter/moodle-api.svg)
[![Test Coverage](https://codeclimate.com/repos/559ea924e30ba001ad00a507/badges/bf95c036334b007100d3/coverage.svg)](https://codeclimate.com/repos/559ea924e30ba001ad00a507/coverage)
[![Dependency Status](https://gemnasium.com/get-smarter/moodle-api.svg)](https://gemnasium.com/get-smarter/moodle-api)

# Moodle API

A ruby wrapper for the Moodle REST API. 

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'moodle-api'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install moodle-api

## Usage

### Configuration

Different ways to configure gem.

```ruby
# Pass block to configure
 Moodle::Api.configure do|c|
  c.host = 'http://my_moodle_instance.com'
  c.token = 'mytoken'
end

# Set configuration values individually
Moodle::Api.configuration.host = 'http://my_moodle_instance.com'
Moodle::Api.configuration.token = 'mytoken'

# Pass options hash to configure
Moodle::Api.configure({host: 'http://my_moodle_instance.com', token: 'mytoken'})

# The client can also be instantiated and used.
client = Moodle:Client.new({host: 'http://my_moodle_instance.com', token: 'mytoken'})

client.make_request(:function_name_here, my_params)
```

Moodle requires users to expose [web service functions](https://docs.moodle.org/dev/Web_service_API_functions) in order for them to be used. A MoodleError exception will be raised if a function with the incorrect name is called

### Calling a service

All web services are available by calling

```ruby
Moodle::Api.function_name_here(my_parameters)
```

New functions created in Moodle will automatically be available in the gem.

### Example

```ruby
Moodle::Api.configure({host: 'http://my_moodle_instance.com', token: 'mytoken'})

params = { 'criteria[0][key]' => 'firstname', 'criteria[0][value]' => 'Jon' }

Moodle::Api.core_user_get_users(params)
```

### Authentication
Moodle uses token authentication, but sometimes you might not have a token. Users are able to generate tokens automatically when calling services using basic authentication.
```ruby
Moodle::Api.configure({host: 'http://my_moodle_instance.com',
                       service: 'my_external_service', # ensure you include the shortname of the external service
                       username: 'jonsnow',
                       password: 'defendthewall'})

params = { 'criteria[0][key]' => 'firstname', 'criteria[0][value]' => 'Jon' }

Moodle::Api.core_user_get_users(params)
```
The gem will handle generating the token automatically and making the call to `core_user_get_users` with the token. If you want you can also just generate a token using
```ruby
configuration = Moodle::Api::Configuration.new
configuration.host = 'http://example.com'
configuration.username = 'jonsnow'
configuration.password = 'batman'
configuration.service = 'service'
configuration

# Note you could pass in a struct with these attributes and it should work the same
Moodle::Api::TokenGenerator.new(configuration).call
```

## Documentation
- Local documentation - http://[my_moodle_instance].com/admin/webservice/documentation.php
- [Service creation guide](https://docs.moodle.org/20/en/Using_web_services#Creating_a_service)
- [Token creation](https://docs.moodle.org/24/en/Using_web_services#Create_a_token)
- [Web Service API function reference](https://docs.moodle.org/dev/Web_service_API_functions)
- [Testing harness](https://testing.vle.getsmarter.co.za/admin/webservice/testclient.php)

## Development
A bundle install should get you going. Rspec, guard and vcr are leveraged for testing.

Note: regenerating vcr cassettes, some data will change which will break the tests. They are pretty easy to compare and correct with a simple diff. The fields that change are timing fields such as last login date, etc. which are specific to the users system. A todo has been added to make the cassettes easily rerunnable.

## Contributing

1. Fork it ( https://github.com/[my-github-username]/moodle-api/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
6. Ensure your stuff is rubocop'd

I am always keen to learn so please feel free to create an issue with code reviews, suggestions and possible refactorings.

## Compatibility

This gem has been use in production against Moodle 2.8. As long as the version you are using has Moodle web services you should be good to go. We are using this gem in production so, future upgrades will be done as releases come out.

## TODOS

- Add additional protocols
- Make cassettes easily rerunnable - will require a parser for the response to remove dynamic data or a funky regex in the specs.
- Moodle web services require you to know how the Moodle API expects params. They are pretty messy. It would be nice to leverage hashes and arrays and then parse them to into what moodle expects.

