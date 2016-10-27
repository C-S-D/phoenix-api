## A Docker container for the Phoenix framework

It features all the latest versions of the Phoenix web framework, the Elixir language and the Erlang platform.

**No Node installation is present so Brunch will not work (no Assets management). This is for APIs only.**

Borrowed from https://github.com/marcelocg/phoenix-docker

![Phoenix Logo](https://www.filepicker.io/api/file/9prSmznZTiaRRmI3t89E)

Phoenix is a framework for building scalable web applications with realtime connectivity across all your devices. It relies on the Elixir language for making the development of maintainable applications productive and fun.

### Building local image
    docker build -t csd1/phoenix-api:latest .

### How to use this image

    docker run -it --rm -v "$PWD":/code -w /phoenix csd1/phoenix-api mix phoenix.new --no-brunch /code/my_new_app
