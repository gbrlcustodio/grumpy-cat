# nextjs-boilerplate

This repo contains boilerplate coide to create an application based on react using nextjs as framework and typescript as type checker.

## Installation

Clone this repository:

```sh
git clone https://github.com/gbrlcustodio/nextjs-boilerplate.git
cd nextjs-boilerplate
```

Install the dependencies:

```sh
npm install
```

Now you should be able to run the development server:

```sh
npm run dev
```

## Editing

This project contains a `.vscode` directory witch contains settings and extensions to work with `Visual Studio Code` using the recommended configurations.

## Directory structure

The basic project structure follows the hierarchy presented bellow and it's not but a suggestion, change it as you find necessary.

```
.
+-- assets/                             # Static files
|   +-- logo.png
+-- components/                         # Shared components
|   +-- Button.tsx
+-- hooks/                              # Shareable state logics
|   +-- useDeviceType.ts
+-- layouts/                            # Layout specific
|   +-- Authenticated.tsx
|   +-- Unauthenticated.tsx
+-- pages/                              # Aplication pages
|   +-- Home.tsx
+-- types/                              # Types descriptions
|-- +-- device.ts
```

## Building

This boilerplate includes docker support, if that is what you wish, create an image by running `docker build .` or `npm run build` if your build process doesn't requires docker.

## Contributions

I'm open to contributions & suggestions in making this a lot better :hand:

## LICENSE

GPL
