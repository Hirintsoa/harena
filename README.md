# README

This project aims to be a simple app for "simple" use cases with a focus on giving quicker overview of the cash flow and simulating projection on the future.

## Underlying system overview

![Background jobs](/public/harena-background-jobs.excalidraw.png)

## Technologies

The project is built using the following technologies:

### Frontend

+ esbuild
+ tailwindcss
+ daisyUI

### Backend

+ Rails 7.1
+ Noticed gem
+ Good job gem
+ Devise gem
+ Rspec gem
+ Papertrail gem
+ Postgresql 15

## Running the application locally

Clone the repository:

```sh
  git clone  https://github.com/Hirintsoa/harena.git
```

Install the necessary gems and packages:

```sh
  cd harena &  bundle install --path vendor/bundle
  yarn  install
```

Launch the servers:

```sh
  ./bin/dev
```

Chech out `http://localhost:3000/`
