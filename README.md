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

## Rails Configuration

```console
rails generate curupira:install
```

The generator will install an initializer which describes ALL of Sorcery's configuration options, models and migrations for authentication and authorization solution.

## Controller filters and helpers

Curupira will provide some helpers to use inside controllers and views. To setup controller with user authentication, just this add before_action:

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

For dafault, the curupira views use coccon for nested forms.

## Configuring controllers

If the customization at the views level is not enough, you can customize each controller:

```console
rails generate curupira:controllers
```

## Partials

You should add in application.html.erb partials for menu, and helper for dispaly flash messages:

```ruby
<%- flash.each do |name, msg| -%>
  <%= content_tag :div, msg, id: "flash_#{name}" %>
<%- end -%>

<%= render "curupira/shared/session_links" %>
<%= render "curupira/shared/model_links" %>
<%= yield %>
```

* Add to your application.js
//= require jquery
//= require cocoon

## License

Curupira is released under the [MIT License](http://www.opensource.org/licenses/MIT).