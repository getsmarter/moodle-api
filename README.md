# Moodle

A ruby wrapper for the Moodle REST API.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'moodle'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install moodle

## Usage

### Configuration

Different ways to configure gem.

```
# Pass block to configure
 Moodle.configure do|c|
  c.host = 'http://dev.vle.getsmarter.co.za'
  c.token = '072556801bf07076fff6bff2a463b7c5'
end

# Set configuration values individually
Moodle.configuration.host = 'http://dev.vle.getsmarter.co.za'
Moodle.configuration.token = '072556801bf07076fff6bff2a463b7c5'

# Pass options hash to configure
Moodle.configure({host: 'http://dev.vle.getsmarter.co.za',
                  token: '072556801bf07076fff6bff2a463b7c5'})
```

Moodle requires users to expose [web service functions](https://docs.moodle.org/dev/Web_service_API_functions) in order for them to be used. A MoodleError exception will be raised if a function with the incorrect name is called

### Calling a service

All web services are available by calling

```
Moodle.function_name_here(my_parameters)
```

New functions created in Moodle will automatically be available in the gem.

### Example

```
Moodle.configure({host: 'http://dev.vle.getsmarter.co.za',
                  token: '072556801bf07076fff6bff2a463b7c5'})

params = { 'criteria[0][key]' => 'firstname', 'criteria[0][value]' => 'Jon' }
Moodle.core_user_get_users(params)
```

## Documentation

For documentation on all the web services check your moodle site at:
- http://[my_moodle_instance].com/admin/webservice/documentation.php

Useful links:
- [Service creation guide](https://docs.moodle.org/20/en/Using_web_services#Creating_a_service)
- [Web Service API function reference](https://docs.moodle.org/dev/Web_service_API_functions)
- [Testing harness](https://testing.vle.getsmarter.co.za/admin/webservice/testclient.php)


## Development

A bundle install should get you going. Rspec, guard and vcr are leveraged for testing.

## Contributing

1. Fork it ( https://github.com/[my-github-username]/moodle/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

I am always keen to learn so please feel free to create an issue with code reviews, suggestions and possible refactorings.

## TODOS

- Add functionality to make XML-RPC requests
- Add the ability to generate tokens from username and password
