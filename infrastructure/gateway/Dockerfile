FROM lambci/lambda:build-ruby2.5

WORKDIR /var/task

RUN yum install -y postgresql-devel

RUN gem install bundler:2.0

CMD bundle install --path vendor/bundle

COPY . .

CMD ["vendor/bundle/ruby/2.5.0/bin/rerun", "--dir", "/var/task", "ruby", "gateway.rb"]