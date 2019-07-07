# Given dockerfile in the subject

FROM ft-rails:on-build
EXPOSE 3000
CMD ["rails", "s", "-b", "0.0.0.0", "-p", "3000"]

# To build and run:
# Make sure the image in on-build/ has been built
# docker build -t ex02 .
# docker run --rm -it -p 3000:3000 ex02
