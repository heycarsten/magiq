# Magiq

### A library for building magical query interfaces for Arel scopes

_Say it like: "Ma-Jee-Que"_

This is a small ad-hoc utility library that I built in 2014 for use in
[LCBO API](https://lcboapi.com). I wanted a clean, declarative way to specify
query param interfaces to my API endpoints.

Ultimately, it works! But life happened and I never really got the second
version out the door. Since then JSON-API has really matured and a number of
libraries have been released to solve this problem and much more.

These days I'd like to just use `JSONAPI::Resources` for everything, but I still
sort of find myself wanting for a better way to specifiy query interfaces.

I'd like to morph `Magiq` into something that could enhance sorting and
filtering in `JSONAPI::Resources`. It might remain a more generic library with
an integration gem `jsonapi-resources-magiq` maybe?

## Should I use this?

Probably not, I put it here to see if other people like the idea and want to
help integrate it with `JSONAPI::Resources` or so they can tell me that
something better already exists.

## Installation

You'll probably be using this in a Rails application or something similar,
simply add this line to your application's Gemfile:

```ruby
gem 'magiq'
```

And then execute:

```
$ bundle
```

## Usage

```ruby
# app/queries/posts_query.rb
class PostsQuery < Magiq::Query
  model { BlogPost }

  # Allow lookup by BlogPost#id via one or up to 100 IDs passed in via "id" or
  # "ids" param:
  by :id, alias: :ids, limit: 100

  # Allow sorting by BlogPost#id, #title, and #created_at
  sort [
    :id,
    :title,
    :created_at
  ]

  # Allow filtering by range on BlogPost#created_at
  range :created_at, type: :date

  # Apply a custom #search scope on the "q" param
  param :q, type: :string do |q|
    scope.search(q)
  end
end

# app/controllers/posts_controller.rb
class PostsController < ApplicationController
  def index
    query = PostsQuery.new(params)
    scope = query.to_scope # An ActiveRecord scope
    render json: scope
  end
end


# GET /posts?ids[]=105&ids[]=109
# GET /posts?sort=-id
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then,
run `rake spec` to run the tests. You can also run `bin/console` for an
interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.
To release a new version, update the version number in `version.rb`, and then
run `bundle exec rake release`, which will create a git tag for the version,
push git commits and tags, and push the `.gem` file to
[rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/heycarsten/magiq. This project is intended to be a safe,
welcoming space for collaboration, and contributors are expected to adhere to
the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the
[MIT License](http://opensource.org/licenses/MIT).
