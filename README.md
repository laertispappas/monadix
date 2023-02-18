# Monadix

Simple result objects in Ruby.

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add monadix

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install monadix

## Usage

```ruby
# file app/lib

# It's a good practice to not expose inner gems to the rest of the app
# so we wrap it.
module Result
  class Success < Monadix::Success; end
  class Failure < Monadix::Success; end
end

class SomeService
  G_OAUTH = lambda do |cmd|
    payload = Google::Auth::IDTokens.verify_oidc(cmd.jwt, aud: ENV.fetch("GOOGLE_OAUTH_CLIENT_ID"))
    info =  UserInfo.new(email: payload[:email], name: payload[:name])
    Result::Success.new(info)
  end

  CreateUser = lambda do |res|
    res.then do |info|
      user = UserFactory.create(info)
      user.save && Result::Success.new(LoginToken.new(user)) || 
        Result::Failure.new("User cannot be created", user.errors.full_messages)
    end
  end
  
  def call(cmd)
    steps.reduce(cmd) { |memo, step| step.call(memo) }
  end
  
  private
  
  def steps
    [
      G_AUTH,
      CreateUser
    ]
  end
end

# Some controller

class AuthCallbacksControler
  def google_oauth2
    cmd = GoogleSignInCommand.new(jwt: params.require(:credential))
    res = SomeService.new.call(cmd)
    if res.success?
      render json: res.data
    else
      render json: res.data, status: :bad_request
    end
  end
end
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/monadix. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/monadix/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Monadix project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/monadix/blob/master/CODE_OF_CONDUCT.md).
