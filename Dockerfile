FROM docker.io/library/ruby:2.7-alpine

RUN apk update && \
    apk add \
        g++ \
        gcc \
        libc-dev \
        make \
        openssl-dev

RUN adduser -h /home/jekyll -g "Jekyll Build" -s /bin/sh -D jekyll

WORKDIR /home/jekyll

COPY Gemfile Gemfile.lock ./

RUN bundle install

COPY ./ build/

WORKDIR /home/jekyll/build

EXPOSE 4000/tcp

CMD ["bundle", "exec", "jekyll", "serve", "--host=0.0.0.0"]
