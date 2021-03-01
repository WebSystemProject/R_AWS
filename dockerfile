FROM ruby:2.7.2
RUN apt-get update && apt-get upgrade -y && apt-get install -y nodejs npm postgresql-client
RUN npm install -g yarn
RUN gem install bundler
WORKDIR /usr/src/app
COPY package.json yarn.lock ./
RUN yarn install --check-files
COPY Gemfile* ./
RUN bundle install
COPY .. .
ENV PATH=./bin:$PATH
EXPOSE 3000
CMD rails server -b 0.0.0.0 --port 3000