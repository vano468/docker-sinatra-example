FROM ruby:2.2
MAINTAINER Ivan Kornilov <vano468@gmail.com>

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY Gemfile /usr/src/app/
COPY Gemfile.lock /usr/src/app/
RUN bundle install --jobs 8 --frozen
COPY . /usr/src/app

EXPOSE 80
CMD ruby app.rb