# FromScratch

I'm sick and tired of thousands of articles "How to setup Rails app server". Here is your last command to do that.

No configs, no questions. Just ~~one ring to rule them all~~ one command to get fully functional server with best security practices ready for first `cap production deploy`.

## Usage

    $ gem install from-scratch
    $ scratchify your_app_name your.host.com

And everything is done. Then add following to your `config/deploy.rb` or `config/deploy/production.rb` for Capistrano:

```ruby
server 'your.host.com', user: 'deploy', roles: %w(app db web)
set :deploy_to, "/home/deploy/#{fetch(:application)}"
```

## Supports

OS:

  - APT-based Linux (Ubuntu, Debian)
  - YUM-based Linux (RedHat, CentOS)

Ruby installers:

  - RVM (default)
  - rbenv: `scratchify your_app_name your.host.com --rbenv`

Setting specific ruby version:

    $ scratchify your_app_name your.host.com --ruby jruby-1.7.19

## It's a kind of magic!

Not actully. Just preconfigured [Chef](https://www.chef.io/). Here are the things done with the command:

  - Install user-wide RVM with latest MRI (2.2.4)
  - Install PostgreSQL, create database with user, pg_tune a little
  - Add _deploy_ non-admin user to system specially for your app, upload your SSH pub key to it
  - Install nginx and replace it's default site config with one prepared for rails app
  - Generate app folder inside _deploy_'s home and generate `database.yml` and `secrets.yml`

## Things you need to know

Nginx config is set up to connect to unix socket placed at `/home/deploy/your_app_name/shared/tmp/sockets/application.sock`. Change it manually or config your favorite app server (Puma, Unicorn, Thin etc) to place it's socket there.

You can just `ssh deploy@your.host.com` because your SSH pub key is already there.

Both `postgres` and `your_app_name` DB users get (different) randomly generated passwords. You can see app-user password inside `config/database.yml`, but `postgres` password is not saved anywhere. If you need admin access to your PostgreSQL, then you should SSH as root and:

    # su - postgres
    $ psql

## Development

Feel free to create bug-reports and feature-requests here on [Issues page](https://github.com/sandrew/from-scratch/issues)

## Contributing

All help is highly appreciated. I'll be thankful for recipes fixes and advices as well as new features implementations. Just fork and pull-request when you have some proposals.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

