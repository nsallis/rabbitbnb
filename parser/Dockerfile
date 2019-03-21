FROM ruby:2.5
RUN apt-get update -qq
RUN mkdir /myapp
WORKDIR /myapp
COPY ./parse.rb /myapp/parse.rb
RUN gem install bunny
CMD ["ruby", "/myapp/parser.rb"]
