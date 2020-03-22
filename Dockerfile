FROM ruby:2.7.0

RUN apt-get update && apt-get install -y build-essential

RUN mkdir -p /app
WORKDIR /app

COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock

RUN bundle install

COPY . /app

EXPOSE 3000

CMD ["bundle", "exec", "puma"]
