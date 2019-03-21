FROM ruby:2.5
RUN apt-get update -qq
RUN mkdir /myapp
WORKDIR /myapp
COPY ./parse.rb /myapp/parse.rb
RUN gem install bunny
RUN gem install faker
CMD ["ruby", "/myapp/parser.rb"]
