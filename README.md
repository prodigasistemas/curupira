# curupira
Easy way to authentication and authorization for ActiveRecord based on Sorcery. Curupira will help you quickly develop an application that uses authentication and authorization rules with database.

By [Pródiga Sistemas](http://www.prodigasistemas.com.br/).

[![Build Status](https://travis-ci.org/prodigasistemas/curupira.svg?branch=master)](https://travis-ci.org/prodigasistemas/curupira)
[![Code Climate](https://codeclimate.com/github/prodigasistemas/curupira/badges/gpa.svg)](https://codeclimate.com/github/prodigasistemas/curupira)
[![Test Coverage](https://codeclimate.com/github/prodigasistemas/curupira/badges/coverage.svg)](https://codeclimate.com/github/prodigasistemas/curupira)

## Getting started

Curupira works with rails 4.0 or onwards. Add curupira to your Gemfile:

```ruby
gem 'curupira'
```

And run:

```console
bundle install
```

## Environment preparation
It's necessary to setup user and password on database.yml. Ex:
```ruby
user: "postgres"
password: "postgres"
```

After this, run:

```console
rake db:create
```

## Rails Configuration

```console
rails generate curupira:install
```

The generator will install an initializer which describes ALL of Sorcery's configuration options, models and migrations for authentication and authorization solution.

So, run migrations:

```console
rake db:migrate
```

You have to add an admin user to application. Edit the seeds.rb file:

```ruby
User.create(username: "user", name: "Default Admin User", email: "user@mail.com", password: "123456", admin: true)
```

Then run:

```console
rake db:seed
```

Run the following task:

```console
rake curupira:db:generate_features
```

Replace your en.yml file by curupira/spec/dummy/config/locales/en.yml

## Root path

If you dont't have root path configurations on your applications, follow these step:

Add this line to routes.rb file:

```ruby
root to: "home#index"
```

Create the home controller:

```ruby
class HomeController < ApplicationController
  def index
  end
end
```

Create the index home page:

```ruby
app/views/home/index.html.erb
```

## Controller filters and helpers

Curupira will provide some helpers to use inside controllers and views. To setup controller with user authentication, just add this before_action:

```ruby
before_action :require_login
```

Curupira will provide all features and [Sorcery api](https://github.com/NoamB/sorcery).

To authorization, add filter authorize on ApplicationController.

```ruby
before_action :authorize
```

## Configuring views

Curupira will generate views to add users, roles, groups and features in database. You can customize it.

```console
rails generate curupira:views
```

For default, the curupira views use coccon for nested forms.

## Configuring controllers

If the customization at the views level is not enough, you can customize each controller:

```console
rails generate curupira:controllers
```

## Partials

You should add in application.html.erb partials for menu, and helper for display flash messages:

```ruby
<%- flash.each do |name, msg| -%>
  <%= content_tag :div, msg, id: "flash_#{name}" %>
<%- end -%>

<%= render "curupira/shared/session_links" %>
<%= render "curupira/shared/model_links" %>
<%= yield %>
```

* Add to your application.js
```ruby
//= require jquery
//= require cocoon
```

## Using curupira

Open http://localhost:3000/session/new and inform the same user configured on seed file.

## License

Curupira is released under the [MIT License](http://www.opensource.org/licenses/MIT).
