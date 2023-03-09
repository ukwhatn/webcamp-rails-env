ARG IMAGE_FROM

FROM $IMAGE_FROM:latest

RUN bundle exec rspec spec/ --format documentation

CMD ["rails", "s", "-b", "0.0.0.0"]
