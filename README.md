# Nails Skeleton App

This is a skeleton app for Nails, the absolute basics for a Nails application. Update this README file with details about your project.


## Basic Setup

The [Nails Command Line Tool](https://github.com/nailsapp/command-line-tool) is a helpful tool to make dealing with your Nails apps a total breeze. If you haven't already, install it like so using [Homebrew](http://brew.sh):

    brew tap nailsapp/utilities
    brew install nails

For other operating systems, or a manual install, please see instructions on the [tool's homepage](https://github.com/nailsapp/command-line-tool).

You can now setup the project simply and easily using:

    nails install

If you wish to upgrade to the latest version of your dependencies then execute:

    nails upgrade

Finally, if at any time you wish to migrate the database then simply execute:

    nails db:migrate


## Compiling Styles and JS

Included in the skeleton is a [Laravel Mix](https://laravel-mix.com/docs/2.1/basic-example) configuration to compile your styles and JS with [Webpack](https://webpack.js.org/). By default compiled files are ignored from VCS so as to minimise conflicts.

Start by installing the compiling dependencies of your project:

```
npm install
```

The following `npm` scripts are available for compiling your Sass into CSS and for compiling JS modules.

- `npm run dev` compiles without minification
- `npm run prod` compiles a production build of the files with minification
- `npm run watch` creates a watch task which will re-run compilation on any of your source files being re-saved

## If using from nailsapp/skeleton-docker-lamp

The build scripts are wrapped up in the `build.sh` and `watch.sh` files for usage within the context of the docker container. These can be accessed with `make watch` and `make build`.
